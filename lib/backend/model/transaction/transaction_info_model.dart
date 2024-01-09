import 'dart:convert';

TransactionInfoModel transactionInfoModelFromJson(String str) =>
    TransactionInfoModel.fromJson(json.decode(str));

String transactionInfoModelToJson(TransactionInfoModel data) =>
    json.encode(data.toJson());

class TransactionInfoModel {
  Data data;

  TransactionInfoModel({
    required this.data,
  });

  factory TransactionInfoModel.fromJson(Map<String, dynamic> json) =>
      TransactionInfoModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  List<Transaction> transaction;

  Data({
    required this.transaction,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        transaction: List<Transaction>.from(
            json["transaction"].map((x) => Transaction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "transaction": List<dynamic>.from(transaction.map((x) => x.toJson())),
      };
}

class Transaction {
  String trxId;
  RemittanceData remittanceData;
  dynamic requestAmount;
  dynamic exchangeRate;
  double payable;
  double fees;
  dynamic convertAmount;
  dynamic willGetAmount;
  String remark;
  String details;
  int status;
  String attribute;
  DateTime createdAt;
  String shareLink;
  String downloadLink;

  Transaction({
    required this.trxId,
    required this.remittanceData,
    this.requestAmount,
    this.exchangeRate,
    required this.payable,
    required this.fees,
    this.convertAmount,
    this.willGetAmount,
    required this.remark,
    required this.details,
    required this.status,
    required this.attribute,
    required this.createdAt,
    required this.shareLink,
    required this.downloadLink,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        trxId: json["trx_id"],
        remittanceData: RemittanceData.fromJson(json["remittance_data"]),
        requestAmount: json["request_amount"]?.toDouble() ?? 0.0,
        exchangeRate: json["exchange_rate"]?.toDouble() ?? 0.0,
        payable: json["payable"]?.toDouble(),
        fees: json["fees"]?.toDouble(),
        convertAmount: json["convert_amount"]?.toDouble() ?? 0.0,
        willGetAmount: json["will_get_amount"]?.toDouble() ?? 0.0,
        remark: json["remark"],
        details: json["details"],
        status: json["status"],
        attribute: json["attribute"],
        createdAt: DateTime.parse(json["created_at"]),
        shareLink: json["share_link"] ?? "",
        downloadLink: json["download_link"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "trx_id": trxId,
        "remittance_data": remittanceData.toJson(),
        "request_amount": requestAmount,
        "exchange_rate": exchangeRate,
        "payable": payable,
        "fees": fees,
        "convert_amount": convertAmount,
        "will_get_amount": willGetAmount,
        "remark": remark,
        "details": details,
        "status": status,
        "attribute": attribute,
        "created_at": createdAt.toIso8601String(),
        "share_link": shareLink,
        "download_link": downloadLink,
      };
}

class RemittanceData {
  String senderEmail;
  String firstName;
  String middleName;
  String lastName;
  String email;
  Currency currency;
  String type;
  String accountNumber;
  String methodName;
  String sendingPurpose;
  String senderCurrency;
  String receiverCurrency;
  String source;
  dynamic sendMoney;
  dynamic senderExRate;
  dynamic receiverExRate;

  RemittanceData({
    required this.senderEmail,
    required this.firstName,
    required this.email,
    required this.middleName,
    required this.lastName,
    required this.currency,
    required this.type,
    required this.accountNumber,
    required this.methodName,
    required this.sendingPurpose,
    required this.source,
    required this.senderCurrency,
    required this.receiverCurrency,
    this.senderExRate,
    this.receiverExRate,
    this.sendMoney,
  });

  factory RemittanceData.fromJson(Map<String, dynamic> json) => RemittanceData(
        senderEmail: json["sender_email"],
        firstName: json["first_name"],
        middleName: json["middle_name"],
        lastName: json["last_name"],
        email: json["email"],
        currency: Currency.fromJson(json["currency"]),
        type: json["type"],
        accountNumber: json["account_number"],
        methodName: json["method_name"],
        sendMoney: json["send_money"],
        sendingPurpose: json["sending_purpose"],
        source: json["source"],
        senderCurrency: json["sender_currency"] ?? '',
        receiverCurrency: json["receiver_currency"] ?? '',
        senderExRate: json["sender_ex_rate"],
        receiverExRate: json["receiver_ex_rate"],
      );

  Map<String, dynamic> toJson() => {
        "sender_email": senderEmail,
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "email": email,
        "currency": currency,
        "type": type,
        "account_number": accountNumber,
        "method_name": methodName,
        "send_money": sendMoney,
        "sending_purpose": sendingPurpose,
        "source": source,
        "sender_currency": senderCurrency,
        "receiver_currency": receiverCurrency,
        "sender_ex_rate": senderExRate,
        "receiver_ex_rate": receiverExRate,
      };
}

class Currency {
  String name;
  String code;

  Currency({
    required this.name,
    required this.code,
  });

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        name: json["name"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "code": code,
      };
}

class Message {
  List<String> success;

  Message({
    required this.success,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        success: List<String>.from(json["success"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "success": List<dynamic>.from(success.map((x) => x)),
      };
}
