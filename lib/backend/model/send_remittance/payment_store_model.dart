import 'dart:convert';

ReceiptPaymentStoredModel receiptPaymentStoredModelFromJson(String str) =>
    ReceiptPaymentStoredModel.fromJson(json.decode(str));

String receiptPaymentStoredModelToJson(ReceiptPaymentStoredModel data) =>
    json.encode(data.toJson());

class ReceiptPaymentStoredModel {
  Message message;
  ReceiptPaymentStoredModelData data;
  String type;

  ReceiptPaymentStoredModel({
    required this.message,
    required this.data,
    required this.type,
  });

  factory ReceiptPaymentStoredModel.fromJson(Map<String, dynamic> json) =>
      ReceiptPaymentStoredModel(
        message: Message.fromJson(json["message"]),
        data: ReceiptPaymentStoredModelData.fromJson(json["data"]),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "message": message.toJson(),
        "data": data.toJson(),
        "type": type,
      };
}

class ReceiptPaymentStoredModelData {
  TemporaryData temporaryData;

  ReceiptPaymentStoredModelData({
    required this.temporaryData,
  });

  factory ReceiptPaymentStoredModelData.fromJson(Map<String, dynamic> json) =>
      ReceiptPaymentStoredModelData(
        temporaryData: TemporaryData.fromJson(json["temporary_data"]),
      );

  Map<String, dynamic> toJson() => {
        "temporary_data": temporaryData.toJson(),
      };
}

class TemporaryData {
  int id;
  String type;
  String identifier;
  dynamic gatewayCode;
  dynamic currencyCode;
  TemporaryDataData data;
  DateTime createdAt;
  DateTime updatedAt;

  TemporaryData({
    required this.id,
    required this.type,
    required this.identifier,
    required this.gatewayCode,
    required this.currencyCode,
    required this.data,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TemporaryData.fromJson(Map<String, dynamic> json) => TemporaryData(
        id: json["id"],
        type: json["type"],
        identifier: json["identifier"],
        gatewayCode: json["gateway_code"],
        currencyCode: json["currency_code"],
        data: TemporaryDataData.fromJson(json["data"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "identifier": identifier,
        "gateway_code": gatewayCode,
        "currency_code": currencyCode,
        "data": data.toJson(),
        "created_at":
            "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
        "updated_at":
            "${updatedAt.year.toString().padLeft(4, '0')}-${updatedAt.month.toString().padLeft(2, '0')}-${updatedAt.day.toString().padLeft(2, '0')}",
      };
}

class TemporaryDataData {
  String senderName;
  String senderEmail;
  String firstName;
  String middleName;
  String lastName;
  String email;
  dynamic country;
  String city;
  String state;
  String zipCode;
  String phone;
  String methodName;
  String accountNumber;
  String address;
  String documentType;
  SendingPurpose sendingPurpose;
  SendingPurpose source;
  dynamic remark;
  Currency currency;
  String senderCurrency;
  String receiverCurrency;
  dynamic receiverExRate;
  String paymentGateway;
  String frontImage;
  String backImage;
  int sendMoney;
  double fees;
  int convertAmount;
  double payableAmount;
  double receiveMoney;

  TemporaryDataData({
    required this.senderName,
    required this.senderEmail,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.email,
    this.country,
    this.receiverExRate,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.phone,
    required this.methodName,
    required this.accountNumber,
    required this.address,
    required this.documentType,
    required this.sendingPurpose,
    required this.source,
    required this.remark,
    required this.currency,
    required this.senderCurrency,
    required this.receiverCurrency,
    required this.paymentGateway,
    required this.frontImage,
    required this.backImage,
    required this.sendMoney,
    required this.fees,
    required this.convertAmount,
    required this.payableAmount,
    required this.receiveMoney,
  });

  factory TemporaryDataData.fromJson(Map<String, dynamic> json) =>
      TemporaryDataData(
        senderName: json["sender_name"],
        senderEmail: json["sender_email"],
        firstName: json["first_name"],
        middleName: json["middle_name"],
        lastName: json["last_name"],
        email: json["email"],
        country: json["country"] ?? '',
        city: json["city"],
        state: json["state"],
        zipCode: json["zip_code"],
        phone: json["phone"],
        methodName: json["method_name"],
        accountNumber: json["account_number"],
        address: json["address"],
        documentType: json["document_type"],
        sendingPurpose: SendingPurpose.fromJson(json["sending_purpose"]),
        source: SendingPurpose.fromJson(json["source"]),
        remark: json["remark"],
        currency: Currency.fromJson(json["currency"]),
        senderCurrency: json["sender_currency"],
        receiverCurrency: json["receiver_currency"],
        paymentGateway: json["payment_gateway"],
        frontImage: json["front_image"],
        backImage: json["back_image"],
        sendMoney: json["send_money"],
        fees: json["fees"]?.toDouble(),
        convertAmount: json["convert_amount"],
        payableAmount: json["payable_amount"]?.toDouble(),
        receiveMoney: json["receive_money"]?.toDouble(),
        receiverExRate: json["receiver_ex_rate"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "sender_name": senderName,
        "sender_email": senderEmail,
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "email": email,
        "country": country,
        "city": city,
        "state": state,
        "zip_code": zipCode,
        "phone": phone,
        "method_name": methodName,
        "account_number": accountNumber,
        "address": address,
        "document_type": documentType,
        "sending_purpose": sendingPurpose.toJson(),
        "source": source.toJson(),
        "remark": remark,
        "currency": currency.toJson(),
        "sender_currency": senderCurrency,
        "receiver_currency": receiverCurrency,
        "payment_gateway": paymentGateway,
        "front_image": frontImage,
        "back_image": backImage,
        "send_money": sendMoney,
        "fees": fees,
        "convert_amount": convertAmount,
        "payable_amount": payableAmount,
        "receive_money": receiveMoney,
        "receiverExRate": receiverExRate,
      };
}

class Currency {
  int id;
  String name;
  String code;
  String alias;
  String rate;

  Currency({
    required this.id,
    required this.name,
    required this.code,
    required this.alias,
    required this.rate,
  });

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        alias: json["alias"],
        rate: json["rate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "alias": alias,
        "rate": rate,
      };
}

class ErCurrency {
  String rate;
  String code;

  ErCurrency({
    required this.rate,
    required this.code,
  });

  factory ErCurrency.fromJson(Map<String, dynamic> json) => ErCurrency(
        rate: json["rate"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "rate": rate,
        "code": code,
      };
}

class SendingPurpose {
  int id;
  String name;

  SendingPurpose({
    required this.id,
    required this.name,
  });

  factory SendingPurpose.fromJson(Map<String, dynamic> json) => SendingPurpose(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
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
