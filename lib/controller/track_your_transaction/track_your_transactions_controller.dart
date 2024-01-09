import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../backend/model/transaction/transaction_info_model.dart';
import '../../backend/services/notification/notification_api_services.dart';
import '../../backend/utils/api_method.dart';

class TransactionController extends GetxController
    with NotificationApiServices {
  RxBool visible = false.obs;

  void getVisible() {
    visible.value = true;
  }

  @override
  void onInit() {
    getTransactionApiProcess();
    super.onInit();
  }

  /// >> set loading process & Transaction Info Model
  final _isLoading = false.obs;
  late TransactionInfoModel _transactionInfoModel;

  /// >> get loading process & Transaction Info Model
  bool get isLoading => _isLoading.value;
  TransactionInfoModel get transactionInfoModel => _transactionInfoModel;

  ///* Get transaction info api process
  Future<TransactionInfoModel> getTransactionApiProcess() async {
    _isLoading.value = true;
    update();
    await transactionGetApiProcess().then((value) {
      _transactionInfoModel = value!;
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isLoading.value = false;
    update();
    return _transactionInfoModel;
  }
}

class TrackYourTransactionController extends GetxController
    with NotificationApiServices {
  final mtcnNumberController = TextEditingController();

  @override
  void dispose() {
    mtcnNumberController.dispose();

    super.dispose();
  }

  RxBool visible = false.obs;

  void getVisible() {
    visible.value = true;
  }

  @override
  void onInit() {
    getAllTransactionApiProcess();
    super.onInit();
  }

  /// >> set loading process & Transaction Info Model
  final _isLoading = false.obs;
  late TransactionInfoModel _transactionInfoModel;

  /// >> get loading process & Transaction Info Model
  bool get isLoading => _isLoading.value;
  TransactionInfoModel get transactionInfoModel => _transactionInfoModel;

  ///* Get transaction info api process
  Future<TransactionInfoModel> getAllTransactionApiProcess() async {
    _isLoading.value = true;
    update();
    await getAllTransactionProcess().then((value) {
      _transactionInfoModel = value!;
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isLoading.value = false;
    update();
    return _transactionInfoModel;
  }

  Rx<List<Transaction>> foundChapter = Rx<List<Transaction>>([]);

  @override
  void onClose() {}
  void filterTransaction(String? value) {
    List<Transaction> results = [];
    if (value!.isEmpty) {
      results = transactionInfoModel.data.transaction;
    } else {
      results = transactionInfoModel.data.transaction
          .where(
            (element) => element.trxId
                .toString()
                .toLowerCase()
                .contains(value.toLowerCase()),
          )
          .toList();
    }
    foundChapter.value = results;
  }
}
