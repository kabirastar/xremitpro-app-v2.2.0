import 'package:xremitpro/backend/local_storage/local_storage.dart';
import 'package:xremitpro/backend/model/common/common_success_model.dart';
import 'package:xremitpro/backend/services/send_remittance/send_remittance_api_services.dart';
import 'package:xremitpro/extensions/custom_extensions.dart';
import 'package:xremitpro/routes/routes.dart';
import 'package:xremitpro/utils/basic_widget_imports.dart';

import '../../backend/model/send_remittance/beneficiarie_list_model.dart';
import '../../backend/utils/api_method.dart';

class BeneficiariesController extends GetxController
    with SendRemittanceApiServices {
  RxInt selectBeneficiary = 0.obs;
  RxBool isNext = false.obs;

  @override
  void onInit() {
    getBeneficiariesListProcess();
    super.onInit();
  }

  // Process >>
  get onSendBeneficiary => sendBeneficiaryProcess();

  // Route
  get onNext => Routes.paymentInformationScreen.toNamed;

  /// <*> Get beneficiaries list api process <*>¨
  ///
  /// >> set loading process & Beneficiaries List Model
  final _isLoading = false.obs;
  late BeneficiariesListModel _beneficiariesListModel;

  /// >> get loading process & Beneficiaries List Model
  bool get isLoading => _isLoading.value;
  BeneficiariesListModel get beneficiariesListModel => _beneficiariesListModel;

  ///* Get beneficiaries list api process
  Future<BeneficiariesListModel> getBeneficiariesListProcess() async {
    _isLoading.value = true;
    update();
    await getBeneficiariesListApiProcess(
      identifier: LocalStorage.getIdentifierKey(),
    ).then((value) {
      _beneficiariesListModel = value!;
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _beneficiariesListModel;
  }

  /// <*> Send beneficiary process api <*>
  ///
  /// >> set loading process & Send Beneficiary Model
  final _isSendBeneficiaryLoading = false.obs;
  late CommonSuccessModel _sendBeneficiaryModel;

  /// >> get loading process & Send Beneficiary Model
  bool get isSendBeneficiaryLoading => _isSendBeneficiaryLoading.value;
  CommonSuccessModel get sendBeneficiaryModel => _sendBeneficiaryModel;

  Future<CommonSuccessModel> sendBeneficiaryProcess() async {
    _isSendBeneficiaryLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {
      'beneficiary_id': selectBeneficiary.value,
      'identifier': LocalStorage.getIdentifierKey(),
    };

    await sendBeneficiaryApiProcess(body: inputBody).then((value) {
      _sendBeneficiaryModel = value!;

      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isSendBeneficiaryLoading.value = false;
    update();
    return _sendBeneficiaryModel;
  }
}
