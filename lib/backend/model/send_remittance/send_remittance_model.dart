import 'dart:convert';

SendRemittanceModel sendRemittanceModelFromJson(String str) =>
    SendRemittanceModel.fromJson(json.decode(str));

String sendRemittanceModelToJson(SendRemittanceModel data) =>
    json.encode(data.toJson());

class SendRemittanceModel {
  final Message message;
  final SendRemittanceModelData data;

  SendRemittanceModel({
    required this.message,
    required this.data,
  });

  factory SendRemittanceModel.fromJson(Map<String, dynamic> json) =>
      SendRemittanceModel(
        message: Message.fromJson(json["message"]),
        data: SendRemittanceModelData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message.toJson(),
        "data": data.toJson(),
      };
}

class SendRemittanceModelData {
  final TemporaryData temporaryData;

  SendRemittanceModelData({
    required this.temporaryData,
  });

  factory SendRemittanceModelData.fromJson(Map<String, dynamic> json) =>
      SendRemittanceModelData(
        temporaryData: TemporaryData.fromJson(json["temporary_data"]),
      );

  Map<String, dynamic> toJson() => {
        "temporary_data": temporaryData.toJson(),
      };
}

class TemporaryData {
  final String type;
  final String identifier;
  final TemporaryDataData data;

  TemporaryData({
    required this.type,
    required this.identifier,
    required this.data,
  });

  factory TemporaryData.fromJson(Map<String, dynamic> json) => TemporaryData(
        type: json["type"],
        identifier: json["identifier"],
        data: TemporaryDataData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "identifier": identifier,
        "data": data.toJson(),
      };
}

class TemporaryDataData {
  final dynamic fees;
  final dynamic convertAmount;
  final dynamic payableAmount;
  final dynamic receiveMoney;
  final dynamic couponId;

  TemporaryDataData({
    this.fees,
    this.convertAmount,
    this.payableAmount,
    this.receiveMoney,
    this.couponId,
  });

  factory TemporaryDataData.fromJson(Map<String, dynamic> json) =>
      TemporaryDataData(
        fees: json["fees"]?.toDouble() ?? 0.0,
        convertAmount: json["convert_amount"]?.toDouble() ?? 0.0,
        payableAmount: json["payable_amount"]?.toDouble() ?? 0.0,
        receiveMoney: json["receive_money"]?.toDouble() ?? 0.0,
        couponId: json["coupon_id"]?.toDouble() ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
        "fees": fees,
        "convert_amount": convertAmount,
        "payable_amount": payableAmount,
        "receive_money": receiveMoney,
        "coupon_id": couponId,
      };
}

class Message {
  final List<String> success;

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
