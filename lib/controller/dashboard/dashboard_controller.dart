import 'package:xremitpro/backend/local_storage/local_storage.dart';
import 'package:xremitpro/backend/model/send_remittance/send_remittance_model.dart';
import 'package:xremitpro/extensions/custom_extensions.dart';
import 'package:xremitpro/routes/routes.dart';

import '/utils/basic_widget_imports.dart';
import '../../backend/model/send_remittance/get_transaction_type_model.dart';
import '../../backend/services/send_remittance/send_remittance_api_services.dart';
import '../../backend/utils/api_method.dart';

class DashboardController extends GetxController
    with SendRemittanceApiServices {
  final amountController = TextEditingController();
  final amountGetController = TextEditingController();
  final couponController = TextEditingController();

  RxString feesAndCharges = '0.00'.obs;
  RxString amountWillConvert = '0.00'.obs;
  RxString totalPayableAmount = '0.00'.obs;
  RxString couponAmount = '0.00'.obs;
  RxString featureText = ''.obs;
  RxString identifier = ''.obs;
  RxDouble couponId = 0.0.obs;
  RxBool showData = false.obs;

  RxString flagPath = ''.obs;

  /// >> Base currency info
  RxString senderCurrencyCode = ''.obs;
  RxString senderCurrencyId = ''.obs;
  RxString senderCurrencyFlag = ''.obs;
  RxString receiverCurrencyCode = ''.obs;
  RxString receiverCurrencyId = ''.obs;
  RxString receiverCurrencyFlag = ''.obs;
  RxString selectTransactionType = ''.obs;
  RxString firstCountry = ''.obs;

  final List<String> transactionTypeList = [];
  final List<String> receiverCountryList = [];
  final List<String> featureTextList = [];

  @override
  void onInit() {
    getTransactionTypeInfoProcess().then(
      (value) {
        if (!LocalStorage.getProcess()) {
          amountController.text = '100';
          if (!showData.value) {
            sendRemittanceProcess().then(
              (value) => LocalStorage.saveProcess(value: true),
            );
          }
        }
      },
    );

    super.onInit();
  }

  // Route >>
  get onSendRemittance => Routes.beneficiariesScreen.toNamed;

  /// <*> Get transaction type api process <*>¨
  ///
  /// >> set loading process & Get Transaction Type Model
  final _isTransactionTypeLoading = false.obs;
  late GetTransactionTypeModel _getTransactionTypeModel;

  /// >> get loading process & Get Transaction Type Model
  bool get isTransactionTypeLoading => _isTransactionTypeLoading.value;
  GetTransactionTypeModel get getTransactionTypeModel =>
      _getTransactionTypeModel;

  ///* Get transaction type info api process
  Future<GetTransactionTypeModel> getTransactionTypeInfoProcess() async {
    _isTransactionTypeLoading.value = true;
    update();
    transactionTypeList.clear();
    receiverCountryList.clear();
    await getTransactionTypeApiProcess().then((value) {
      _getTransactionTypeModel = value!;
      _setTransactionTypeData(_getTransactionTypeModel);
      _isTransactionTypeLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isTransactionTypeLoading.value = false;
    update();
    return _getTransactionTypeModel;
  }

  /// <*> Send remittance process api <*>
  ///
  /// >> set loading process & Send Remittance Model
  final _isLoading = false.obs;
  late SendRemittanceModel _sendRemittanceModel;

  /// >> get loading process & Send Remittance Model
  bool get isLoading => _isLoading.value;
  SendRemittanceModel get sendRemittanceModel => _sendRemittanceModel;

  Future<SendRemittanceModel> sendRemittanceProcess() async {
    _isLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {
      'type': selectTransactionType.value,
      'send_money': amountController.text,
      'sender_currency': senderCurrencyId.value,
      'receiver_currency': receiverCurrencyId.value,
      'coupon': LocalStorage.getCouponId(),
    };
    if (amountController.text.isNotEmpty) {
      await sendRemittanceApiProcess(body: inputBody).then((value) {
        _sendRemittanceModel = value!;
        _setRemittanceInfo(_sendRemittanceModel);
        showData.value = true;
        update();
      }).catchError((onError) {
        log.e(onError);
      });
    } else {
      amountGetController.clear();
      feesAndCharges.value = '0.00';
      amountWillConvert.value = '0.00';
      identifier.value = '';
      totalPayableAmount.value = '0.00';
      couponAmount.value = '0.00';
      showData.value = false;
    }

    _isLoading.value = false;
    update();
    return _sendRemittanceModel;
  }

  void _setRemittanceInfo(SendRemittanceModel data) {
    var temporaryData = data.data.temporaryData;
    //recipient get
    amountGetController.text =
        temporaryData.data.receiveMoney.toStringAsFixed(2);
    LocalStorage.saveIdentifierKey(key: temporaryData.identifier);

    /// send remittance info
    feesAndCharges.value = temporaryData.data.fees.toStringAsFixed(2);
    amountWillConvert.value =
        temporaryData.data.convertAmount.toStringAsFixed(2);
    totalPayableAmount.value =
        temporaryData.data.payableAmount.toStringAsFixed(2);
    identifier.value = temporaryData.identifier;

    couponId.value = temporaryData.data.couponId;

    print(temporaryData.data.couponId);
  }

  void _setTransactionTypeData(
      GetTransactionTypeModel getTransactionTypeModel) {
    for (var element in getTransactionTypeModel.data.transactionType) {
      transactionTypeList.add(element.title);
      featureTextList.add(element.featureText);
    }
    featureText.value =
        getTransactionTypeModel.data.transactionType.first.featureText;
    selectTransactionType.value =
        getTransactionTypeModel.data.transactionType.first.title;

    senderCurrencyCode.value =
        getTransactionTypeModel.data.senderCurrency.first.code;

    senderCurrencyId.value =
        getTransactionTypeModel.data.senderCurrency.first.id.toString();
    receiverCurrencyId.value =
        getTransactionTypeModel.data.receiverCurrency.first.id.toString();
    receiverCurrencyCode.value =
        getTransactionTypeModel.data.receiverCurrency.first.code;

    flagPath.value =
        '${getTransactionTypeModel.data.imagePaths.baseUrl}/${getTransactionTypeModel.data.imagePaths.pathLocation}/';

    /// get sender currency flag
    if (getTransactionTypeModel.data.senderCurrency.first.flag != '') {
      senderCurrencyFlag.value =
          "${flagPath.value} ${getTransactionTypeModel.data.senderCurrency.first.flag}";
    } else {
      senderCurrencyFlag.value =
          "${getTransactionTypeModel.data.imagePaths.baseUrl}/${getTransactionTypeModel.data.imagePaths.defaultImage}";
    }

    /// get receiver currency flag
    if (getTransactionTypeModel.data.receiverCurrency.first.flag != '') {
      receiverCurrencyFlag.value =
          "${flagPath.value}${getTransactionTypeModel.data.receiverCurrency.first.flag}";
    } else {
      receiverCurrencyFlag.value =
          "${getTransactionTypeModel.data.imagePaths.baseUrl}/${getTransactionTypeModel.data.imagePaths.defaultImage}";
    }
    firstCountry.value =
        getTransactionTypeModel.data.receiverCurrency.first.country;
    getTransactionTypeModel.data.receiverCurrency.forEach(
      (element) {
        receiverCountryList.add(element.country);
      },
    );
  }
}
