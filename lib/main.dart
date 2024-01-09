import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../routes/routes.dart';
import '../../utils/theme.dart';
import 'backend/utils/network_check/dependency_injection.dart';
import 'controller/basic_settings/basic_settings_controller.dart';
import 'language/english.dart';
import 'language/language_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  InternetCheckDependencyInjection.init();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  GetStorage.init();

  runApp(MyApp());
}

class MyApp extends GetView<BasicSettingsController> {
  MyApp({Key? key}) : super(key: key);
  @override
  final controller = Get.put(BasicSettingsController());

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(414, 896),
      builder: (_, child) => GetMaterialApp(
        title: Strings.appName,
        debugShowCheckedModeBanner: false,
        theme: Themes.light,
        darkTheme: Themes.dark,
        themeMode: Themes().theme,
        navigatorKey: Get.key,
        initialRoute: Routes.splashScreen,
        getPages: Routes.list,
        initialBinding: BindingsBuilder(
          () {
            Get.put(LanguageController());
          },
        ),
        builder: (context, widget) {
          ScreenUtil.init(context);

          return Obx(
            () => MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: Directionality(
                textDirection: Get.find<LanguageController>().isLoading
                    ? TextDirection.ltr
                    : Get.find<LanguageController>().languageDirection,
                child: widget!,
              ),
            ),
          );
        },
      ),
    );
  }
}
