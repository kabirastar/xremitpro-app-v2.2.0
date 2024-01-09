import 'package:xremitpro/backend/model/common/common_success_model.dart';
import 'package:xremitpro/backend/model/send_remittance/beneficiarie_list_model.dart';
import 'package:xremitpro/backend/model/submit_data/flutter_wave_model.dart';
import 'package:xremitpro/backend/model/submit_data/manual_payment_model.dart';
import 'package:xremitpro/backend/model/submit_data/stripe_model.dart';

import '../../model/send_remittance/bank_and_mobile_method_model.dart';
import '../../model/send_remittance/get_transaction_type_model.dart';
import '../../model/send_remittance/payment_store_model.dart';
import '../../model/send_remittance/remittance_send_success_model.dart';
import '../../model/send_remittance/send_remittance_model.dart';
import '../../model/send_remittance/sending_purpose_info_model.dart';
import '../../model/submit_data/paypal_model.dart';
import '../../model/submit_data/ssl_model.dart';
import '../../utils/api_method.dart';
import '../../utils/custom_snackbar.dart';
import '../api_endpoint.dart';

mixin SendRemittanceApiServices {
  ///* Get transaction type info process api
  Future<GetTransactionTypeModel?> getTransactionTypeApiProcess() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: true).get(
        ApiEndpoint.getTransactionTypeUrl,
        code: 200,
        showResult: true,
      );
      if (mapResponse != null) {
        GetTransactionTypeModel result =
            GetTransactionTypeModel.fromJson(mapResponse);

        return result;
      }
    } catch (e) {
      log.e(
          '🐞🐞🐞 err from  Get transaction type info process api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error(
          'Something went Wrong! in Get Transaction Type Model');
      return null;
    }
    return null;
  }

  ///* Send remittance api process
  Future<SendRemittanceModel?> sendRemittanceApiProcess(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.sendRemittanceUrl,
        body,
        code: 200,
      );
      SendRemittanceModel result = SendRemittanceModel.fromJson(mapResponse!);
      return result;
    } catch (e) {
      log.e('🐞🐞🐞 err from Send remittance api service ==> $e 🐞🐞🐞');
      //CustomSnackBar.error('Something went Wrong! in SendRemittanceModel');
      return null;
    }
  }

  ///* Get beneficiaries list process api
  Future<BeneficiariesListModel?> getBeneficiariesListApiProcess(
      {required String identifier}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        "${ApiEndpoint.beneficiaryListUrl}$identifier",
        code: 200,
        showResult: true,
      );
      if (mapResponse != null) {
        BeneficiariesListModel result =
            BeneficiariesListModel.fromJson(mapResponse);
        return result;
      }
    } catch (e) {
      log.e(
          '🐞🐞🐞 err from  Get beneficiaries list process api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong! in BeneficiariesListModel');
      return null;
    }
    return null;
  }

  ///* Send Beneficiary api process
  Future<CommonSuccessModel?> sendBeneficiaryApiProcess(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.selectBeneficiaryUrl,
        body,
        code: 200,
      );
      CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse!);
      return result;
    } catch (e) {
      log.e('🐞🐞🐞 err from Send Beneficiary api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
  }

  ///* Beneficiary store api process
  Future<CommonSuccessModel?> beneficiaryStoreApiProcess(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.beneficiaryStoreUrl,
        body,
        code: 200,
      );
      CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse!);
      CustomSnackBar.success(result.message.success.first);
      return result;
    } catch (e) {
      log.e('🐞🐞🐞 err from Beneficiary store api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
  }

  ///* Get sending purpose info process api
  Future<SendingPurposeInfoModel?> getSendingPurposeApiProcess(
      {required String identifier}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        "${ApiEndpoint.sendingPurposeInfoUrl}$identifier",
        code: 200,
        showResult: true,
      );
      if (mapResponse != null) {
        SendingPurposeInfoModel result =
            SendingPurposeInfoModel.fromJson(mapResponse);
        return result;
      }
    } catch (e) {
      log.e(
          '🐞🐞🐞 err from  Get sending purpose info process api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong! in SendingPurposeInfoModel');
      return null;
    }
    return null;
  }

  ///* Get banks and mobile method info process api
  Future<BanksAndMobileMethodModel?> getBanksAndMobileMethodApiProcess() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        ApiEndpoint.banksAndMobileMethodURL,
        code: 200,
        showResult: true,
      );
      if (mapResponse != null) {
        BanksAndMobileMethodModel result =
            BanksAndMobileMethodModel.fromJson(mapResponse);
        return result;
      }
    } catch (e) {
      log.e(
          '🐞🐞🐞 err from  Get banks and mobile method info process api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error(
          'Something went Wrong! in BanksAndMobileMethodModel');
      return null;
    }
    return null;
  }

  ///* Receipt payment store api process
  Future<ReceiptPaymentStoredModel?> receiptPaymentStoreApiProcess(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.receiptPaymentStoreURL,
        body,
        code: 200,
      );
      ReceiptPaymentStoredModel result =
          ReceiptPaymentStoredModel.fromJson(mapResponse!);
      return result;
    } catch (e) {
      log.e('🐞🐞🐞 err from Receipt payment store api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong! in SendRemittanceModel');
      return null;
    }
  }

  /// Paypal submit data process api
  Future<PaypalModel?> paypalSubmitDataProcessApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.submitDataUrl,
        body,
        code: 200,
      );
      PaypalModel result = PaypalModel.fromJson(mapResponse!);
      return result;
    } catch (e) {
      log.e(
          '🐞🐞🐞 err from Paypal submit data process api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong! in PaypalModel');
      return null;
    }
  }

  /// Flutter wave submit data process api
  Future<FlutterWaveModel?> flutterWaveSubmitDataProcessApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.submitDataUrl,
        body,
        code: 200,
      );
      FlutterWaveModel result = FlutterWaveModel.fromJson(mapResponse!);
      return result;
    } catch (e) {
      log.e(
          '🐞🐞🐞 err from Flutter wave submit data process api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong! in PaypalModel');
      return null;
    }
  }

  /// Stripe submit data process api
  Future<StripeModel?> stripSubmitDataProcessApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.submitDataUrl,
        body,
        code: 200,
      );
      StripeModel result = StripeModel.fromJson(mapResponse!);
      return result;
    } catch (e) {
      log.e(
          '🐞🐞🐞 err from Stripe submit data process api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong! in StripeModel');
      return null;
    }
  }

  /// Sslcommerz Model submit data process api
  Future<SslcommerzModel?> sslSubmitDataProcessApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.submitDataUrl,
        body,
        code: 200,
      );
      SslcommerzModel result = SslcommerzModel.fromJson(mapResponse!);
      return result;
    } catch (e) {
      log.e(
          '🐞🐞🐞 err from Sslcommerz submit data process api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong! in SslcommerzModel');
      return null;
    }
  }

  /// Manual data process api
  Future<ManualPaymentModel?> manualSubmitDataProcessApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.submitDataUrl,
        body,
        code: 200,
      );
      ManualPaymentModel result = ManualPaymentModel.fromJson(mapResponse!);
      return result;
    } catch (e) {
      log.e('🐞🐞🐞 err from Manual data process api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong! in ManualPaymentModel');
      return null;
    }
  }

  ///* Transfer calculator api process
  Future<SendRemittanceModel?> transferCalculatorApiProcess(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.sendRemittanceUrl,
        body,
        code: 200,
      );
      SendRemittanceModel result = SendRemittanceModel.fromJson(mapResponse!);
      return result;
    } catch (e) {
      log.e('🐞🐞🐞 err from Send remittance api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong! in SendRemittanceModel');
      return null;
    }
  }

  ///* manual payment confirm process api
  Future<RemittanceSendSuccessModel?> manualPaymentConfirmApi({
    required Map<String, String> body,
    required List<String> pathList,
    required List<String> fieldList,
  }) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).multipartMultiFile(
        ApiEndpoint.manualPaymentConfirmUrl,
        body,
        fieldList: fieldList,
        pathList: pathList,
        code: 200,
      );

      if (mapResponse != null) {
        RemittanceSendSuccessModel result =
            RemittanceSendSuccessModel.fromJson(mapResponse);
        return result;
      }
    } catch (e) {
      log.e('err from manual payment confirm process api service ==> $e');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* stripe confirm process api
  Future<CommonSuccessModel?> stripeConfirmApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false)
          .post(ApiEndpoint.stripePaymentConfirmUrl, body, code: 200);
      if (mapResponse != null) {
        CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);
        return result;
      }
    } catch (e) {
      log.e('err from stripe confirm process api service ==> $e');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }
}
