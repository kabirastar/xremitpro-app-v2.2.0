import 'package:xremitpro/utils/basic_screen_imports.dart';
import '../../backend/model/beneficiary/beneficiary_info_model.dart';
import '../../backend/services/recipients/beneficiary_api_services.dart';
import '../../backend/utils/api_method.dart';

class SavedBeneficiaryController extends GetxController
    with BeneficiariesApiServices {
  RxInt beneficiaryId = 0.obs;
  @override
  void onInit() {
    getBeneficiaryApiProcess();
    super.onInit();
  }

  /// >> set loading process & Beneficiary Info Model
  final _isLoading = false.obs;
  late BeneficiaryInfoModel _beneficiaryInfoModel;

  /// >> get loading process & Beneficiary Info Model
  bool get isLoading => _isLoading.value;
  BeneficiaryInfoModel get beneficiaryInfoModel => _beneficiaryInfoModel;

  ///* Get beneficiary info api process
  Future<BeneficiaryInfoModel> getBeneficiaryApiProcess() async {
    _isLoading.value = true;
    update();
    await beneficiaryGetApiProcess(
      beneficiaryId.value,
      isEditMode: false,
    ).then((value) {
      _beneficiaryInfoModel = value!;

      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isLoading.value = false;
    update();
    return _beneficiaryInfoModel;
  }
}
