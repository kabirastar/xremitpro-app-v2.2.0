import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:xremitpro/backend/utils/custom_snackbar.dart';

import '../../backend/model/transaction/transaction_info_model.dart';
import '../../controller/download/pdf_download_controller.dart';
import '../../utils/basic_screen_imports.dart';

class TransferLogCard extends StatelessWidget {
  TransferLogCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  final bgColor = Get.isDarkMode
      ? CustomColor.primaryDarkScaffoldBackgroundColor
      : CustomColor.primaryLightScaffoldBackgroundColor;

  final stateColor =
      Get.isDarkMode ? CustomColor.whiteColor : CustomColor.stateColor;

  final Color customColor = Get.isDarkMode
      ? CustomColor.whiteColor
      : CustomColor.secondaryLightTextColor;

  final Transaction data;

  @override
  Widget build(BuildContext context) {
    var day = DateFormat('dd');
    var month = DateFormat('MMM');

    return Card(
      surfaceTintColor: Theme.of(context).colorScheme.background,
      color: Theme.of(context).colorScheme.background,
      child: Theme(
        data: ThemeData(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: EdgeInsets.all(Dimensions.paddingSize * 0.1),
          title: Row(
            children: [
              Padding(
                padding: EdgeInsets.all(Dimensions.paddingSize * 0.5),
                child: Column(
                  children: [
                    TitleHeading1Widget(
                      text: day.format(data.createdAt),
                      fontWeight: FontWeight.w600,
                      color: customColor,
                    ),
                    TitleHeading4Widget(
                      text: month.format(data.createdAt),
                      fontWeight: FontWeight.w500,
                      color: customColor,
                    ),
                  ],
                ),
              ),
              Container(
                height: Dimensions.heightSize * 3.5,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: customColor.withOpacity(.30),
                    width: 1,
                  ),
                ),
              ),
              horizontalSpace(Dimensions.paddingSize * 0.625),
              Expanded(
                child: Column(
                  crossAxisAlignment: crossStart,
                  children: [
                    TitleHeading1Widget(
                      text:
                          '${data.remittanceData.firstName} ${data.remittanceData.middleName} ${data.remittanceData.lastName}',
                      fontSize: Dimensions.headingTextSize3,
                      color: customColor,
                      maxLines: 1,
                    ),
                    verticalSpace(Dimensions.heightSize * 0.5),
                    TitleHeading1Widget(
                      text: data.remittanceData.type,
                      fontSize: Dimensions.headingTextSize3,
                      color: customColor,
                      maxLines: 1,
                    ),
                  ],
                ),
              )
            ],
          ),
          trailing: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.marginSizeHorizontal * 0.1,
            ),
            child: Column(
              crossAxisAlignment: crossEnd,
              mainAxisAlignment: mainCenter,
              mainAxisSize: mainMin,
              children: [
                _statusSwitch(data.status),
                verticalSpace(Dimensions.heightSize * 0.5),
                TitleHeading4Widget(
                  text: data.convertAmount.toStringAsFixed(2) +
                      " " +
                      data.remittanceData.senderCurrency,
                  fontWeight: FontWeight.w600,
                  color: customColor,
                  maxLines: 1,
                ),
              ],
            ),
          ),
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: Dimensions.marginSizeHorizontal * 0.7,
                vertical: Dimensions.marginSizeVertical * 0.7,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.marginSizeHorizontal * 0.7,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius * 0.8),
                color: Colors.grey.withOpacity(0.1),
              ),
              child: Column(
                children: [
                  LabelWidget(
                    title: Strings.mtcnNumber,
                    value: data.trxId,
                  ),
                  LabelWidget(
                    title: Strings.transactionType,
                    value: data.remittanceData.type,
                  ),
                  LabelWidget(
                    title: Strings.methodName,
                    value: data.remittanceData.methodName,
                  ),
                  LabelWidget(
                    title: Strings.accountNumber,
                    value: data.remittanceData.accountNumber,
                  ),
                  LabelWidget(
                    title: Strings.senderAmount,
                    value: data.remittanceData.sendMoney.toString(),
                  ),
                  LabelWidget(
                    title: Strings.exchangeRate,
                    value:
                        "${data.remittanceData.senderExRate} ${data.remittanceData.senderCurrency} = ${data.remittanceData.receiverExRate} ${data.remittanceData.receiverCurrency}",
                  ),
                  LabelWidget(
                    title: Strings.feesAndCharge,
                    value: data.fees.toStringAsFixed(2),
                  ),
                  LabelWidget(
                    title: Strings.sendingPurpose,
                    value: data.remittanceData.sendingPurpose,
                  ),
                  LabelWidget(
                    title: Strings.sourceOfFund,
                    value: data.remittanceData.source,
                  ),
                  LabelWidget(
                    title: Strings.paymentMethod,
                    value: data.remittanceData.currency.name,
                  ),
                  LabelWidget(
                    title: Strings.payableAmount,
                    value: data.payable.toStringAsFixed(2) +
                        ' ' +
                        data.remittanceData.currency.code,
                  ),
                  _copyLinkWidget(context, data),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _copyLinkWidget(BuildContext context, Transaction data) {
    final controller = Get.put(PdfDownloadController());
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Dimensions.marginSizeVertical * 0.5,
      ),
      child: Row(
        mainAxisAlignment: mainCenter,
        children: [
          InkWell(
            onTap: () {
              controller.downloadPdf(url: data.downloadLink, trx: data.trxId);
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.marginSizeHorizontal * 0.4,
                vertical: Dimensions.marginSizeVertical * 0.15,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(Dimensions.radius * 1.5),
              ),
              child: TitleHeading4Widget(
                text: Strings.downloadReceipt,
                color: CustomColor.whiteColor,
              ),
            ),
          ),
          horizontalSpace(Dimensions.widthSize),
          InkWell(
            onTap: () {
              Clipboard.setData(ClipboardData(text: data.shareLink)).then(
                (_) {
                  CustomSnackBar.success(Strings.copyUrl);
                },
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.marginSizeHorizontal * 0.4,
                vertical: Dimensions.marginSizeVertical * 0.15,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(Dimensions.radius * 1.5),
              ),
              child: TitleHeading4Widget(
                text: Strings.copyLink,
                color: CustomColor.whiteColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _statusSwitch(status) {
    switch (status) {
      case 1:
        return _statusWidget(
            color: CustomColor.yellowColor, text: 'Review Payment');
      case 2:
        return _statusWidget(color: CustomColor.yellowColor, text: 'Pending');
      case 3:
        return _statusWidget(
            color: CustomColor.greenColor, text: 'Confirm Payment');
      case 4:
        return _statusWidget(color: CustomColor.currencyColor, text: 'On Hold');
      case 5:
        return _statusWidget(color: CustomColor.thirdColor, text: 'Settled');
      case 6:
        return _statusWidget(color: CustomColor.greenColor, text: 'Completed');
      case 7:
        return _statusWidget(color: CustomColor.redColor, text: 'Canceled');
      case 8:
        return _statusWidget(color: CustomColor.redColor, text: 'Failed');
      case 9:
        return _statusWidget(color: CustomColor.redColor, text: 'Refunded');
      case 10:
        return _statusWidget(color: CustomColor.redColor, text: 'Delayed');
    }
  }

  _statusWidget({required Color color, required String text}) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.marginSizeHorizontal * 0.3,
        vertical: Dimensions.marginSizeVertical * 0.1,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
        color: color.withOpacity(0.2),
      ),
      child: TitleHeading4Widget(
        text: text,
        color: color,
      ),
    );
  }
}

class LabelWidget extends StatelessWidget {
  final String title, value;
  final bool showDivider;
  const LabelWidget({
    super.key,
    required this.title,
    required this.value,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(
            vertical: Dimensions.marginSizeVertical * 0.35,
          ),
          child: Row(
            mainAxisAlignment: mainSpaceBet,
            children: [
              TitleHeading3Widget(
                text: title,
                maxLines: 1,
                fontWeight: FontWeight.w400,
              ),
              Expanded(
                child: TitleHeading4Widget(
                  text: value,
                  maxLines: 2,
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: showDivider,
          child: Container(
            height: 1,
            color: CustomColor.blackColor.withOpacity(0.2),
          ),
        )
      ],
    );
  }
}
