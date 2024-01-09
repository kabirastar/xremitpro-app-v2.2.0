import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:xremitpro/backend/model/submit_data/flutter_wave_model.dart';
import 'package:xremitpro/backend/model/submit_data/manual_payment_model.dart';
import 'package:xremitpro/backend/model/submit_data/paypal_model.dart';
import 'package:xremitpro/backend/services/send_remittance/send_remittance_api_services.dart';
import 'package:xremitpro/extensions/custom_extensions.dart';
import 'package:xremitpro/utils/basic_screen_imports.dart';
import 'package:xremitpro/views/flutter_web/flutter_wab_screen.dart';

import '../../backend/local_storage/local_storage.dart';
import '../../backend/model/send_remittance/payment_store_model.dart';
import '../../backend/model/send_remittance/remittance_send_success_model.dart';
import '../../backend/model/send_remittance/sending_purpose_info_model.dart';
import '../../backend/model/submit_data/ssl_model.dart';
import '../../backend/model/submit_data/stripe_model.dart';
import '../../backend/utils/api_method.dart';
import '../../backend/utils/custom_snackbar.dart';
import '../../routes/routes.dart';
import '../../views/download_pdf/download_pdf_screen.dart';
import '../../widgets/inputs/manual_payment_image_widget.dart';
import '../../widgets/inputs/text_input_field.dart';

class PaymentInformationController extends GetxController
    with SendRemittanceApiServices {
  // all text editing controller
  final selectSendingPurpose = TextEditingController();
  final selectSourceFund = TextEditingController();
  final selectPaymentGateway = TextEditingController();
  final remarksController = TextEditingController();

  // set value for dynamic input field
  List<TextEditingController> inputFieldControllers = [];
  RxList inputFields = [].obs;
  List<String> listImagePath = [];
  List<String> listFieldName = [];
  RxBool hasFile = false.obs;
  @override
  void onInit() {
    getSendingPurposeInfoProcess();
    super.onInit();
  }

  // dispose all controller while the screen destroy
  @override
  void dispose() {
    selectPaymentGateway.dispose();
    selectSourceFund.dispose();
    selectSendingPurpose.dispose();
    super.dispose();
  }

  RxString selectedSendingPurposeName = ''.obs;
  RxString selectedSendingPurposeId = ''.obs;
  RxString selectedFundItem = ''.obs;
  RxString selectedFundId = ''.obs;
  RxString selectedPaymentMethod = ''.obs;
  RxString selectedPaymentMethodId = ''.obs;

  List<String> sendingPurposeNameList = [];
  List<String> sendingPurposeIdList = [];
  List<String> sourceOfFundNameList = [];
  List<String> sourceOfFundIdList = [];
  List<String> paymentGatewayNameList = [];
  List<String> paymentGatewayIdList = [];

  // Remittance Summary
  RxString sendingAmount = ''.obs;
  RxString exchangeRate = ''.obs;
  RxString totalFees = ''.obs;
  RxString amountWillConvert = ''.obs;
  RxString willGetAmount = ''.obs;

  // Recipient Summary
  RxString recipientName = ''.obs;
  RxString country = ''.obs;
  RxString zipCode = ''.obs;
  RxString city = ''.obs;
  RxString contactNumber = ''.obs;

  // Payment Summary
  RxString transactionType = ''.obs;
  RxString bankName = ''.obs;
  RxString ibanNumber = ''.obs;
  RxString sendingPurpose = ''.obs;
  RxString sourceOfFund = ''.obs;
  RxString paymentMethod = ''.obs;

  // get payment url
  RxString paymentUrl = ''.obs;

  // get alias
  RxString alias = ''.obs;

  /// <*> Get sending purpose info api process <*>¨
  ///
  /// >> set loading process & Sending Purpose Info Model
  final _isLoading = false.obs;
  late SendingPurposeInfoModel _sendingPurposeInfoModel;

  /// >> get loading process & Sending Purpose Info Model
  bool get isLoading => _isLoading.value;
  SendingPurposeInfoModel get sendingPurposeInfoModel =>
      _sendingPurposeInfoModel;

  ///* Get sending purpose info api process
  Future<SendingPurposeInfoModel> getSendingPurposeInfoProcess() async {
    _isLoading.value = true;
    update();
    await getSendingPurposeApiProcess(
      identifier: LocalStorage.getIdentifierKey(),
    ).then((value) {
      _sendingPurposeInfoModel = value!;
      _setSendingPurposeList(_sendingPurposeInfoModel);
      _setSourceOfFoundList(_sendingPurposeInfoModel);
      _setPaymentGatewayList(_sendingPurposeInfoModel);
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _sendingPurposeInfoModel;
  }

  void _setSendingPurposeList(SendingPurposeInfoModel data) {
    for (var element in data.data.sendingPurposes) {
      sendingPurposeNameList.add(element.name);
      sendingPurposeIdList.add(element.id.toString());
    }
    selectedSendingPurposeName.value = data.data.sendingPurposes.first.name;
    selectedSendingPurposeId.value =
        data.data.sendingPurposes.first.id.toString();
  }

  void _setSourceOfFoundList(SendingPurposeInfoModel data) {
    for (var element in data.data.sourceOfFunds) {
      sourceOfFundNameList.add(element.name);
      sourceOfFundIdList.add(element.id.toString());
    }
    selectedFundItem.value = data.data.sourceOfFunds.first.name;
    selectedFundId.value = data.data.sourceOfFunds.first.id.toString();
  }

  void _setPaymentGatewayList(SendingPurposeInfoModel data) {
    for (var element in data.data.paymentGateway) {
      paymentGatewayNameList.add(element.name);
      paymentGatewayIdList.add(element.id.toString());
    }
    selectedPaymentMethod.value = data.data.paymentGateway.first.name;
    selectedPaymentMethodId.value =
        data.data.paymentGateway.first.id.toString();
  }

  /// <*> Receipt payment stored process api <*>
  ///
  /// >> set loading process & Receipt Payment Stored Model
  final _isStoreLoading = false.obs;
  late ReceiptPaymentStoredModel _receiptPaymentStoredModel;

  /// >> get loading process & Receipt Payment Stored Model
  bool get isStoreLoading => _isStoreLoading.value;
  ReceiptPaymentStoredModel get receiptPaymentStoredModel =>
      _receiptPaymentStoredModel;

  Future<ReceiptPaymentStoredModel> receiptPaymentStoreProcess() async {
    _isStoreLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'identifier': LocalStorage.getIdentifierKey(),
      'sending_purpose': selectedSendingPurposeId.value,
      'source': selectedFundId.value,
      'remark': remarksController.text,
      'payment_gateway': selectedPaymentMethodId.value
    };
    await receiptPaymentStoreApiProcess(body: inputBody).then((value) {
      _receiptPaymentStoredModel = value!;

      _remittanceSummary(_receiptPaymentStoredModel);
      _recipientSummary(_receiptPaymentStoredModel);
      _paymentSummary(_receiptPaymentStoredModel);
      Get.toNamed(Routes.paymentPreviewScreen);
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isStoreLoading.value = false;
    update();
    return _receiptPaymentStoredModel;
  }

  void _remittanceSummary(ReceiptPaymentStoredModel data) {
    var mainData = data.data.temporaryData.data;
    sendingAmount.value =
        "${mainData.sendMoney.toStringAsFixed(2)} ${mainData.senderCurrency}";
    exchangeRate.value =
        '1 ${mainData.senderCurrency} = ${mainData.receiverExRate} ${mainData.receiverCurrency}';
    totalFees.value =
        "${mainData.fees.toStringAsFixed(2)} ${mainData.senderCurrency}";
    amountWillConvert.value =
        "${mainData.convertAmount.toStringAsFixed(2)} ${mainData.senderCurrency}";
    willGetAmount.value =
        "${mainData.receiveMoney.toStringAsFixed(2)} ${mainData.receiverCurrency}";
  }

  void _recipientSummary(ReceiptPaymentStoredModel data) {
    var mainData = data.data.temporaryData.data;
    recipientName.value =
        "${mainData.firstName} ${mainData.middleName} ${mainData.lastName}";
    country.value = mainData.country;
    zipCode.value = mainData.zipCode;
    contactNumber.value = mainData.phone;
    city.value = mainData.city;
  }

  void _paymentSummary(ReceiptPaymentStoredModel data) {
    var mainData = data.data.temporaryData.data;
    transactionType.value = data.data.temporaryData.type;
    bankName.value = mainData.methodName;
    ibanNumber.value = mainData.accountNumber;
    sendingPurpose.value = mainData.sendingPurpose.name;
    sourceOfFund.value = mainData.source.name;
    paymentMethod.value = mainData.currency.name;
    alias.value = mainData.currency.alias;
  }

  ///_ _ _ _ _ _ _ _ __ _ _ __ _ __ __ _ _ _ _ _ _ _ _ _ SUBMIT DATA PROCESS _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

  onPaymentProcess() {
    if (alias.value.contains('paypal')) {
      paypalSubmitDataProcess();
    } else if (alias.value.contains('flutter')) {
      flutterWaveSubmitDataProcess();
    } else if (alias.value.contains('manual')) {
      manualPaymentSubmitDataProcess();
    } else if (alias.value.contains('stripe')) {
      stripeSubmitDataProcess();
    } else if (alias.value.contains('sslcommerz')) {
      sslCommerzSubmitDataProcess();
    } else if (alias.value.contains('razorpay')) {
      razorpaySubmitDataProcess();
    }
  }

  /// >> set loading process
  final _isSubmitDataLoading = false.obs;
  bool get isSubmitDataLoading => _isSubmitDataLoading.value;

  /// >> get & set Paypal Model
  late PaypalModel _paypalModel;
  PaypalModel get paypalModel => _paypalModel;

  Future<PaypalModel> paypalSubmitDataProcess() async {
    _isSubmitDataLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'identifier': LocalStorage.getIdentifierKey(),
    };
    await paypalSubmitDataProcessApi(body: inputBody).then((value) {
      _paypalModel = value!;

      final data = _paypalModel.data.url;
      for (int i = 0; i < data.length; i++) {
        if (data[i].rel.contains('approve')) {
          paymentUrl.value = data[i].href;
        }
      }
      if (paymentUrl.value != '') {
        Get.to(
          () => FlutterWebScreen(
            title: Strings.paypalPayment,
            paymentUrl: paymentUrl.value,
          ),
        );
      }

      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isSubmitDataLoading.value = false;
    update();
    return _paypalModel;
  }

  /// >> get & set Flutter Wave Model
  late FlutterWaveModel _flutterWaveModel;
  FlutterWaveModel get flutterWaveModel => _flutterWaveModel;

  Future<FlutterWaveModel> flutterWaveSubmitDataProcess() async {
    _isSubmitDataLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'identifier': LocalStorage.getIdentifierKey(),
    };
    await flutterWaveSubmitDataProcessApi(body: inputBody).then((value) {
      _flutterWaveModel = value!;

      Get.to(
        () => FlutterWebScreen(
          title: Strings.flutterWavePayment,
          paymentUrl: _flutterWaveModel.data.url,
        ),
      );

      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isSubmitDataLoading.value = false;
    update();
    return _flutterWaveModel;
  }

  /// STRIPE
  /// >> get & set Stripe Model
  late StripeModel _stripeModel;
  StripeModel get stripeModel => _stripeModel;

  Future<StripeModel> stripeSubmitDataProcess() async {
    _isSubmitDataLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'identifier': LocalStorage.getIdentifierKey(),
    };
    await stripSubmitDataProcessApi(body: inputBody).then((value) {
      _stripeModel = value!;
      Get.to(
        () => FlutterWebScreen(
          title: Strings.stripePayment,
          paymentUrl: _stripeModel.data.url,
        ),
      );

      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isSubmitDataLoading.value = false;
    update();
    return _stripeModel;
  }

  /// razorpay
  /// >> get & set razorpay Model
  late StripeModel _razorpayModel;
  StripeModel get razorpayModel => _razorpayModel;
  Future<StripeModel> razorpaySubmitDataProcess() async {
    _isSubmitDataLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'identifier': LocalStorage.getIdentifierKey(),
    };
    await stripSubmitDataProcessApi(body: inputBody).then((value) {
      _razorpayModel = value!;
      Get.to(
        () => FlutterWebScreen(
          title: Strings.razorpayPayment,
          paymentUrl: _razorpayModel.data.url,
        ),
      );

      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isSubmitDataLoading.value = false;
    update();
    return _razorpayModel;
  }

  /// SSL
  // >> get & set Sslcommerz Model
  late SslcommerzModel _sslCommerzModel;
  SslcommerzModel get sslCommerzModel => _sslCommerzModel;

  Future<SslcommerzModel> sslCommerzSubmitDataProcess() async {
    _isSubmitDataLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'identifier': LocalStorage.getIdentifierKey(),
    };
    await sslSubmitDataProcessApi(body: inputBody).then((value) {
      _sslCommerzModel = value!;
      Get.to(
        () => FlutterWebScreen(
          title: Strings.sslcommerzPayment,
          paymentUrl: _sslCommerzModel.data.url,
        ),
      );

      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isSubmitDataLoading.value = false;
    update();
    return _sslCommerzModel;
  }

  /// >> get & set Manual Payment Model
  late ManualPaymentModel _manualPaymentModel;
  ManualPaymentModel get manualPaymentModel => _manualPaymentModel;

  Future<ManualPaymentModel> manualPaymentSubmitDataProcess() async {
    _isSubmitDataLoading.value = true;
    inputFields.clear();
    listImagePath.clear();
    listFieldName.clear();
    inputFieldControllers.clear();
    update();
    Map<String, dynamic> inputBody = {
      'identifier': LocalStorage.getIdentifierKey(),
    };
    await manualSubmitDataProcessApi(body: inputBody).then((value) {
      _manualPaymentModel = value!;
      _setDynamicInputFieldProcess(_manualPaymentModel);
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isSubmitDataLoading.value = false;
    update();
    return _manualPaymentModel;
  }

  void _setDynamicInputFieldProcess(ManualPaymentModel manualPaymentModel) {
    final data = manualPaymentModel.data.inputFields;

    for (int item = 0; item < data.length; item++) {
      // make the dynamic controller
      var textEditingController = TextEditingController();
      inputFieldControllers.add(textEditingController);

      // make dynamic input widget
      if (data[item].type.contains('file')) {
        hasFile.value = true;
        inputFields.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: ManualPaymentImageWidget(
              labelName: data[item].label,
              fieldName: data[item].name,
            ),
          ),
        );
      } else if (data[item].type.contains('text') ||
          data[item].type.contains('textarea')) {
        inputFields.add(
          Column(
            children: [
              CustomTextInputField(
                controller: inputFieldControllers[item],
                inputText: data[item].label,
                hintText: data[item].label,
                isValid: data[item].required,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(
                    int.parse(data[item].validation.max.toString()),
                  ),
                ],
                icon: '',
              ).paddingOnly(bottom: Dimensions.marginSizeVertical * 0.75),
            ],
          ),
        );
      }
    }

    //-------------------------- Process inputs end --------------------------
    Routes.sendRemittanceManualPaymentScreen.toNamed;
  }

  updateImageData(String fieldName, String imagePath) {
    if (listFieldName.contains(fieldName)) {
      int itemIndex = listFieldName.indexOf(fieldName);
      listImagePath[itemIndex] = imagePath;
    } else {
      listFieldName.add(fieldName);
      listImagePath.add(imagePath);
    }
    update();
  }

  String? getImagePath(String fieldName) {
    if (listFieldName.contains(fieldName)) {
      int itemIndex = listFieldName.indexOf(fieldName);
      return listImagePath[itemIndex];
    }
    return null;
  }

  // ---------------------------- Manual Payment Process -------------------------
  final _isConfirmLoading = false.obs;
  bool get isConfirmLoading => _isConfirmLoading.value;
  late RemittanceSendSuccessModel _manualPaymentConfirmModel;
  RemittanceSendSuccessModel get manualPaymentConfirmModel =>
      _manualPaymentConfirmModel;

  Future<RemittanceSendSuccessModel> manualPaymentProcess() async {
    _isConfirmLoading.value = true;
    Map<String, String> inputBody = {
      'track': manualPaymentModel.data.paymentInformations.trx,
    };

    final data = manualPaymentModel.data.inputFields;

    for (int i = 0; i < data.length; i += 1) {
      if (data[i].type != 'file') {
        inputBody[data[i].name] = inputFieldControllers[i].text;
      }
    }

    await manualPaymentConfirmApi(
      body: inputBody,
      fieldList: listFieldName,
      pathList: listImagePath,
    ).then((value) {
      _manualPaymentConfirmModel = value!;

      Get.to(
        () => DownloadPdfScreen(),
      );
      _isConfirmLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isConfirmLoading.value = false;
    update();
    return _manualPaymentConfirmModel;
  }

  /// Pdf download
  final _isDownloadLoading = false.obs;
  bool get isDownloadLoading => _isDownloadLoading.value;
  Future<void> downloadPdf() async {
    _isDownloadLoading.value = true;
    try {
      final response = await http
          .get(Uri.parse(manualPaymentConfirmModel.data.downloadLink));
      if (response.statusCode == 200) {
        final directory = await getApplicationDocumentsDirectory();
        final filePath = '${directory.path}/sample.pdf';
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        _isDownloadLoading.value = false;
        CustomSnackBar.success('Receipt pdf download successfully');
      } else {
        throw Exception('Failed to download PDF');
      }
    } catch (e) {
      debugPrint('Error downloading PDF: $e');
    }
  }
}
