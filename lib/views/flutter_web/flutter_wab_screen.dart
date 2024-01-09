// ignore_for_file: must_be_immutable
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:xremitpro/extensions/custom_extensions.dart';

import '../../../backend/utils/custom_loading_api.dart';
import '../../routes/routes.dart';
import '../../utils/basic_screen_imports.dart';
import '../../widgets/appbar/back_button.dart';
import '../congratulation/congratulation_screen.dart';

class FlutterWebScreen extends StatelessWidget {
  FlutterWebScreen({super.key, required this.title, required this.paymentUrl});
  final String title, paymentUrl;

  late InAppWebViewController webViewController;
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(Routes.bottomNavBar);
        return false;
      },
      child: Scaffold(
        appBar: PrimaryAppBar(
          leading: BackButtonWidget(onTap: () {
            Get.back();
          }),
          appBar: AppBar(),
          title: TitleHeading2Widget(
            text: title,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          autoLeading: true,
          appbarColor: Colors.transparent,
          action: [
            InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              onTap: () {
                Routes.bottomNavBar.offAllNamed;
              },
              child: Icon(
                Icons.home_rounded,
                color: Get.isDarkMode
                    ? CustomColor.whiteColor
                    : CustomColor.blackColor,
              ).paddingOnly(right: Dimensions.paddingSize),
            ),
          ],
        ),
        body: _bodyWidget(context),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return Stack(
      children: [
        InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(paymentUrl)),
          onWebViewCreated: (controller) {
            webViewController = controller;
            controller.addJavaScriptHandler(
              handlerName: 'jsHandler',
              callback: (args) {
                // Handle JavaScript messages from WebView
              },
            );
          },
          onLoadStart: (controller, url) {
            isLoading.value = true;
          },
          onLoadStop: (controller, url) {
            isLoading.value = false;
            if (url.toString().contains('success/response') ||
                url.toString().contains('sslcommerz/success') ||
                url.toString().contains('stripe/payment/success/')) {
              Get.to(
                () => const CongratulationScreen(
                  title: Strings.congratulation,
                  subTitle: Strings.moneyTransferMsg,
                  route: Routes.bottomNavBar,
                ),
              );
            }
          },
        ),
        ValueListenableBuilder<bool>(
          valueListenable: isLoading,
          builder: (context, isLoading, _) {
            return isLoading
                ? const Center(child: CustomLoadingAPI())
                : const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
