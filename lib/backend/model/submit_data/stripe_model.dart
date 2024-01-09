import 'dart:convert';

StripeModel stripeModelFromJson(String str) =>
    StripeModel.fromJson(json.decode(str));

String stripeModelToJson(StripeModel data) => json.encode(data.toJson());

class StripeModel {
  Message message;
  Data data;
  String type;

  StripeModel({
    required this.message,
    required this.data,
    required this.type,
  });

  factory StripeModel.fromJson(Map<String, dynamic> json) => StripeModel(
        message: Message.fromJson(json["message"]),
        data: Data.fromJson(json["data"]),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "message": message.toJson(),
        "data": data.toJson(),
        "type": type,
      };
}

class Data {
  String gategayType;
  String gatewayCurrencyName;
  String alias;
  String identify;
  PaymentInformations paymentInformations;
  String url;
  String method;

  Data({
    required this.gategayType,
    required this.gatewayCurrencyName,
    required this.alias,
    required this.identify,
    required this.paymentInformations,
    required this.url,
    required this.method,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        gategayType: json["gategay_type"],
        gatewayCurrencyName: json["gateway_currency_name"],
        alias: json["alias"],
        identify: json["identify"],
        paymentInformations:
            PaymentInformations.fromJson(json["payment_informations"]),
        url: json["url"],
        method: json["method"],
      );

  Map<String, dynamic> toJson() => {
        "gategay_type": gategayType,
        "gateway_currency_name": gatewayCurrencyName,
        "alias": alias,
        "identify": identify,
        "payment_informations": paymentInformations.toJson(),
        "url": url,
        "method": method,
      };
}

class PaymentInformations {
  String trx;
  String gatewayCurrencyName;
  String requestAmount;
  String exchangeRate;
  String totalCharge;
  String willGet;
  String payableAmount;

  PaymentInformations({
    required this.trx,
    required this.gatewayCurrencyName,
    required this.requestAmount,
    required this.exchangeRate,
    required this.totalCharge,
    required this.willGet,
    required this.payableAmount,
  });

  factory PaymentInformations.fromJson(Map<String, dynamic> json) =>
      PaymentInformations(
        trx: json["trx"],
        gatewayCurrencyName: json["gateway_currency_name"],
        requestAmount: json["request_amount"],
        exchangeRate: json["exchange_rate"],
        totalCharge: json["total_charge"],
        willGet: json["will_get"],
        payableAmount: json["payable_amount"],
      );

  Map<String, dynamic> toJson() => {
        "trx": trx,
        "gateway_currency_name": gatewayCurrencyName,
        "request_amount": requestAmount,
        "exchange_rate": exchangeRate,
        "total_charge": totalCharge,
        "will_get": willGet,
        "payable_amount": payableAmount,
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
