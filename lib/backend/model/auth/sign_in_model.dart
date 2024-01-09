class SignInModel {
  // Message message;/
  Data data;
  String type;

  SignInModel({
    // required this.message,
    required this.data,
    required this.type,
  });

  factory SignInModel.fromJson(Map<String, dynamic> json) => SignInModel(
        // message: Message.fromJson(json["message"]),
        data: Data.fromJson(json["data"]),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        // "message": message.toJson(),
        "data": data.toJson(),
        "type": type,
      };
}

class Data {
  String token;
  String imagePath;
  String defaultImage;
  User user;

  Data({
    required this.token,
    required this.imagePath,
    required this.defaultImage,
    required this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        imagePath: json["image_path"],
        defaultImage: json["default_image"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "image_path": imagePath,
        "default_image": defaultImage,
        "user": user.toJson(),
      };
}

class User {
  int id;
  String firstName;
  String lastName;
  String username;
  int status;
  String email;
  dynamic image;
  dynamic verCode;
  dynamic verCodeSendAt;
  dynamic emailVerifiedAt;
  int emailVerified;
  int smsVerified;
  int kycVerified;
  int twoFactorStatus;
  int twoFactorVerified;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.status,
    required this.email,
    required this.image,
    required this.verCode,
    required this.verCodeSendAt,
    required this.emailVerifiedAt,
    required this.emailVerified,
    required this.smsVerified,
    required this.kycVerified,
    required this.twoFactorStatus,
    required this.twoFactorVerified,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        username: json["username"],
        status: json["status"],
        email: json["email"],
        image: json["image"],
        verCode: json["ver_code"],
        verCodeSendAt: json["ver_code_send_at"],
        emailVerifiedAt: json["email_verified_at"],
        emailVerified: json["email_verified"],
        smsVerified: json["sms_verified"],
        kycVerified: json["kyc_verified"],
        twoFactorStatus: json["two_factor_status"],
        twoFactorVerified: json["two_factor_verified"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "username": username,
        "status": status,
        "email": email,
        "image": image,
        "ver_code": verCode,
        "ver_code_send_at": verCodeSendAt,
        "email_verified_at": emailVerifiedAt,
        "email_verified": emailVerified,
        "sms_verified": smsVerified,
        "kyc_verified": kycVerified,
        "two_factor_status": twoFactorStatus,
        "two_factor_verified": twoFactorVerified,
      };
}
