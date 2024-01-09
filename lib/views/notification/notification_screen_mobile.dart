import 'package:intl/intl.dart';
import 'package:xremitpro/backend/utils/custom_loading_api.dart';

import '/widgets/notification/notification_card.dart';
import '../../controller/notification/notification_controller.dart';
import '../../utils/basic_screen_imports.dart';

class NotificationScreenMobile extends StatelessWidget {
  const NotificationScreenMobile({Key? key, required this.controller})
      : super(key: key);
  final NotificationController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => controller.isLoading
            ? const CustomLoadingAPI()
            : _bodyWidget(context),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    var day = DateFormat('dd');
    var month = DateFormat('MMM');
    return RefreshIndicator(
      color: CustomColor.primaryLightColor,
      onRefresh: () async {
        controller.getNotificationApiProcess();
      },
      child: controller.notificationInfoModel.data.notification.isEmpty
          ? Center(
              child: TitleHeading2Widget(
                text: Strings.noNotification,
                color: CustomColor.primaryLightColor,
                fontSize: Dimensions.headingTextSize2 * 0.8,
                opacity: 0.8,
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.only(
                left: Dimensions.paddingSize * 0.7,
                right: Dimensions.paddingSize * 0.7,
                top: Dimensions.paddingSize * 1.136,
              ),
              itemCount:
                  controller.notificationInfoModel.data.notification.length,
              itemBuilder: (BuildContext context, int index) {
                var data =
                    controller.notificationInfoModel.data.notification[index];
                return NotificationCardWidget(
                  title: data.message,
                  title2: controller.notificationInfoModel.type,
                  day: day.format(data.createdAt),
                  month: month.format(data.createdAt),
                );
              },
            ),
    );
  }
}
