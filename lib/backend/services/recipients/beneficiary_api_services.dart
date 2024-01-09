import '../../model/beneficiary/beneficiary_info_model.dart';
import '../../model/common/common_success_model.dart';
import '../../utils/api_method.dart';
import '../../utils/custom_snackbar.dart';
import '../api_endpoint.dart';

mixin BeneficiariesApiServices {
  ///* Beneficiary info get process api
  Future<BeneficiaryInfoModel?> beneficiaryGetApiProcess(int id,
      {required bool isEditMode}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        isEditMode
            ? "${ApiEndpoint.beneficiaryIndexUrl}?id=$id"
            : ApiEndpoint.beneficiaryIndexUrl,
        code: 200,
      );
      if (mapResponse != null) {
        BeneficiaryInfoModel result =
            BeneficiaryInfoModel.fromJson(mapResponse);

        return result;
      }
    } catch (e) {
      log.e(
          '🐞🐞🐞 err from Beneficiary info get process api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong! in BeneficiaryInfoModel');
      return null;
    }
    return null;
  }

  ///* store beneficiary process api
  Future<CommonSuccessModel?> storeBeneficiaryProcessApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false)
          .post(ApiEndpoint.beneficiaryStoreUrl, body, code: 200);
      if (mapResponse != null) {
        CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);
        CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e('err from update store beneficiary process api service ==> $e');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* store beneficiary process api
  Future<CommonSuccessModel?> storeBeneficiaryProcessApiWithImage({
    required Map<String, String> body,
    required List<String> pathList,
    required List<String> fieldList,
  }) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).multipartMultiFile(
        ApiEndpoint.beneficiaryStoreUrl,
        body,
        code: 200,
        pathList: pathList,
        fieldList: fieldList,
      );
      if (mapResponse != null) {
        CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);
        CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e('err from update store beneficiary process api service ==> $e');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* update beneficiary process api
  Future<CommonSuccessModel?> updateBeneficiaryProcessApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false)
          .post(ApiEndpoint.beneficiaryUpdateURL, body, code: 200);
      if (mapResponse != null) {
        CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);
        CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e('err from update update beneficiary process api service ==> $e');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* update beneficiary process api
  Future<CommonSuccessModel?> updateBeneficiaryProcessWithImageApi({
    required Map<String, String> body,
    required List<String> pathList,
    required List<String> fieldList,
  }) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).multipartMultiFile(
        ApiEndpoint.beneficiaryUpdateURL,
        body,
        code: 200,
        pathList: pathList,
        fieldList: fieldList,
      );
      if (mapResponse != null) {
        CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);
        CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e('err from update update beneficiary process api service ==> $e');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* delete beneficiary process api
  Future<CommonSuccessModel?> deleteBeneficiaryProcessApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false)
          .post(ApiEndpoint.beneficiaryDeleteURL, body, code: 200);
      if (mapResponse != null) {
        CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);
        CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e('err from update delete beneficiary process api service ==> $e');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }
}
