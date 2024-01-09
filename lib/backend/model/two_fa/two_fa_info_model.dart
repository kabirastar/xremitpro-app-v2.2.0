import 'dart:convert';

TwoFaInfoModel twoFaInfoModelFromJson(String str) =>
    TwoFaInfoModel.fromJson(json.decode(str));

String twoFaInfoModelToJson(TwoFaInfoModel data) => json.encode(data.toJson());

class TwoFaInfoModel {
  Data data;

  TwoFaInfoModel({
    required this.data,
  });

  factory TwoFaInfoModel.fromJson(Map<String, dynamic> json) => TwoFaInfoModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  String qrCode;
  String qrSecrete;
  int qrStatus;
  String alert;

  Data({
    required this.qrCode,
    required this.qrSecrete,
    required this.qrStatus,
    required this.alert,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        qrCode: json["qr_code"],
        qrSecrete: json["qr_secrete"],
        qrStatus: json["qr_status"],
        alert: json["alert"],
      );

  Map<String, dynamic> toJson() => {
        "qr_code": qrCode,
        "qr_secrete": qrSecrete,
        "qr_status": qrStatus,
        "alert": alert,
      };
}
