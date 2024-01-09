import 'dart:convert';

BasicSettingsInfoModel basicSettingsInfoModelFromJson(String str) =>
    BasicSettingsInfoModel.fromJson(json.decode(str));

String basicSettingsInfoModelToJson(BasicSettingsInfoModel data) =>
    json.encode(data.toJson());

class BasicSettingsInfoModel {
  Message message;
  Data data;
  String type;

  BasicSettingsInfoModel({
    required this.message,
    required this.data,
    required this.type,
  });

  factory BasicSettingsInfoModel.fromJson(Map<String, dynamic> json) =>
      BasicSettingsInfoModel(
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
  List<BasicSetting> basicSettings;
  List<SplashScreen> splashScreen;
  List<OnboardScreen> onboardScreen;
  List<WebLink> webLinks;
  AppImagePath basicSeetingsImagePaths;
  AppImagePath appImagePath;

  Data({
    required this.basicSettings,
    required this.splashScreen,
    required this.onboardScreen,
    required this.webLinks,
    required this.basicSeetingsImagePaths,
    required this.appImagePath,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        basicSettings: List<BasicSetting>.from(
            json["basic_settings"].map((x) => BasicSetting.fromJson(x))),
        splashScreen: List<SplashScreen>.from(
            json["splash_screen"].map((x) => SplashScreen.fromJson(x))),
        onboardScreen: List<OnboardScreen>.from(
            json["onboard_screen"].map((x) => OnboardScreen.fromJson(x))),
        webLinks: List<WebLink>.from(
            json["web_links"].map((x) => WebLink.fromJson(x))),
        basicSeetingsImagePaths:
            AppImagePath.fromJson(json["basic_seetings_image_paths"]),
        appImagePath: AppImagePath.fromJson(json["app_image_path"]),
      );

  Map<String, dynamic> toJson() => {
        "basic_settings":
            List<dynamic>.from(basicSettings.map((x) => x.toJson())),
        "splash_screen":
            List<dynamic>.from(splashScreen.map((x) => x.toJson())),
        "onboard_screen":
            List<dynamic>.from(onboardScreen.map((x) => x.toJson())),
        "web_links": List<dynamic>.from(webLinks.map((x) => x.toJson())),
        "basic_seetings_image_paths": basicSeetingsImagePaths.toJson(),
        "app_image_path": appImagePath.toJson(),
      };
}

class AppImagePath {
  String baseUrl;
  String pathLocation;
  String defaultImage;

  AppImagePath({
    required this.baseUrl,
    required this.pathLocation,
    required this.defaultImage,
  });

  factory AppImagePath.fromJson(Map<String, dynamic> json) => AppImagePath(
        baseUrl: json["base_url"],
        pathLocation: json["path_location"],
        defaultImage: json["default_image"],
      );

  Map<String, dynamic> toJson() => {
        "base_url": baseUrl,
        "path_location": pathLocation,
        "default_image": defaultImage,
      };
}

class BasicSetting {
  int id;
  String siteName;
  String baseColor;
  dynamic siteLogoDark;
  dynamic siteLogo;
  String siteFavDark;
  String siteFav;
  bool emailVerification;
  DateTime createdAt;

  BasicSetting({
    required this.id,
    required this.siteName,
    required this.baseColor,
    this.siteLogoDark,
    this.siteLogo,
    required this.siteFavDark,
    required this.emailVerification,
    required this.siteFav,
    required this.createdAt,
  });

  factory BasicSetting.fromJson(Map<String, dynamic> json) => BasicSetting(
        id: json["id"],
        siteName: json["site_name"],
        baseColor: json["base_color"],
        siteLogoDark: json["site_logo_dark"] ?? '',
        siteLogo: json["site_logo"] ?? '',
        siteFavDark: json["site_fav_dark"],
        siteFav: json["site_fav"],
        emailVerification: json["email_verification"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "site_name": siteName,
        "base_color": baseColor,
        "site_logo_dark": siteLogoDark,
        "site_logo": siteLogo,
        "site_fav_dark": siteFavDark,
        "site_fav": siteFav,
        "email_verification": emailVerification,
        "created_at": createdAt.toIso8601String(),
      };
}

class OnboardScreen {
  int id;
  dynamic title;
  dynamic subTitle;
  dynamic image;

  OnboardScreen({
    required this.id,
    this.title,
    this.subTitle,
    this.image,
  });

  factory OnboardScreen.fromJson(Map<String, dynamic> json) => OnboardScreen(
        id: json["id"],
        title: json["title"] ?? '',
        subTitle: json["sub_title"] ?? '',
        image: json["image"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "sub_title": subTitle,
        "image": image,
      };
}

class SplashScreen {
  int id;
  String version;
  dynamic splashScreenImage;

  SplashScreen({
    required this.id,
    required this.version,
    this.splashScreenImage,
  });

  factory SplashScreen.fromJson(Map<String, dynamic> json) => SplashScreen(
        id: json["id"],
        version: json["version"],
        splashScreenImage: json["splash_screen_image"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "version": version,
        "splash_screen_image": splashScreenImage,
      };
}

class WebLink {
  String name;
  String link;

  WebLink({
    required this.name,
    required this.link,
  });

  factory WebLink.fromJson(Map<String, dynamic> json) => WebLink(
        name: json["name"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "link": link,
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
