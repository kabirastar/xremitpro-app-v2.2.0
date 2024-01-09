import '../../utils/basic_screen_imports.dart';
import '../transfer_log/transfer_log_card.dart';

class RecipientInformationCardWidget extends StatelessWidget {
  const RecipientInformationCardWidget({
    super.key,
    required this.secondaryCustomColor,
    required this.text,
    required this.subText,
    required this.onEdit,
    required this.onDelete,
    required this.beneficiaries,
  });

  final Color secondaryCustomColor;
  final String text;
  final String subText;
  final VoidCallback onEdit, onDelete;
  final dynamic beneficiaries;

  @override
  Widget build(BuildContext context) {
    var name =
        "${beneficiaries.firstName} ${beneficiaries.middleName} ${beneficiaries.lastName}";
    return Card(
      color: Theme.of(context).colorScheme.background,
      surfaceTintColor: Theme.of(context).colorScheme.background,
      shadowColor: CustomColor.blackColor,
      child: Padding(
        padding: EdgeInsets.only(
          top: Dimensions.paddingSize * 0.42,
          bottom: Dimensions.paddingSize * 0.42,
        ),
        child: Theme(
          data: ThemeData(
            dividerColor: Colors.transparent,
          ),
          child: ExpansionTile(
            leading: CircleAvatar(
              backgroundColor: CustomColor.primaryLightColor,
              radius: Dimensions.radius * 2.3,
              child: const Icon(
                Icons.arrow_upward_rounded,
                color: CustomColor.whiteColor,
              ),
            ),
            title: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: crossStart,
                    mainAxisAlignment: mainSpaceBet,
                    children: [
                      TitleHeading2Widget(
                        text: text,
                        fontSize: Dimensions.headingTextSize2 * 0.85,
                        fontWeight: FontWeight.w600,
                        color: secondaryCustomColor,
                        maxLines: 1,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                      TitleHeading4Widget(
                        text: subText,
                        fontWeight: FontWeight.w500,
                        color: secondaryCustomColor.withOpacity(0.60),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            trailing: Row(
              mainAxisSize: mainMin,
              mainAxisAlignment: mainSpaceBet,
              children: [
                GestureDetector(
                  onTap: onEdit,
                  child: Icon(
                    Icons.edit_outlined,
                    color: CustomColor.primaryDarkColor,
                  ),
                ),
                horizontalSpace(Dimensions.marginSizeHorizontal * 0.5),
                GestureDetector(
                  onTap: onDelete,
                  child: const Icon(
                    Icons.delete_outline_rounded,
                    color: CustomColor.redColor,
                  ),
                )
              ],
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
                      title: Strings.name,
                      value: name,
                    ),
                    LabelWidget(
                      title: Strings.email,
                      value: beneficiaries.email,
                    ),
                    LabelWidget(
                      title: Strings.country,
                      value: beneficiaries.country,
                    ),
                    LabelWidget(
                      title: Strings.cityAndState,
                      value: beneficiaries.state,
                    ),
                    LabelWidget(
                      title: Strings.phone,
                      value: beneficiaries.phone,
                    ),
                    LabelWidget(
                      title: Strings.methodName,
                      value: beneficiaries.method,
                    ),
                    LabelWidget(
                      title: Strings.accountNumber,
                      value: beneficiaries.accountNumber,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
