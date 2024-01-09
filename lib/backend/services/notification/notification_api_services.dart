import 'package:xremitpro/backend/model/transaction/transaction_info_model.dart';

import '../../model/notification/notification_info_model.dart';
import '../../utils/api_method.dart';
import '../../utils/custom_snackbar.dart';
import '../api_endpoint.dart';

mixin NotificationApiServices {
  ///* Notification get process api
  Future<NotificationInfoModel?> notificationGetApiProcess() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        ApiEndpoint.notificationURL,
        code: 200,
      );
      if (mapResponse != null) {
        NotificationInfoModel result =
            NotificationInfoModel.fromJson(mapResponse);

        return result;
      }
    } catch (e) {
      log.e(
          '🐞🐞🐞 err from Notification get process api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong! in NotificationInfoModel');
      return null;
    }
    return null;
  }

  ///* Transaction get process api
  Future<TransactionInfoModel?> transactionGetApiProcess() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        ApiEndpoint.transactionURL,
        code: 200,
      );
      if (mapResponse != null) {
        TransactionInfoModel result =
            TransactionInfoModel.fromJson(mapResponse);

        return result;
      }
    } catch (e) {
      log.e(
          '🐞🐞🐞 err from transaction get process api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong! in TransactionInfoModel');
      return null;
    }
    return null;
  }

  ///* Transaction get process api
  Future<TransactionInfoModel?> getAllTransactionProcess() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: true).get(
        ApiEndpoint.allTransactionURL,
        code: 200,
      );
      if (mapResponse != null) {
        TransactionInfoModel result =
            TransactionInfoModel.fromJson(mapResponse);

        return result;
      }
    } catch (e) {
      log.e(
          '🐞🐞🐞 err from all transaction get process api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong! in TransactionInfoModel');
      return null;
    }
    return null;
  }
}
