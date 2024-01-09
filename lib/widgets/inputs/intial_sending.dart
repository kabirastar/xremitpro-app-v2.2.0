// import 'package:appdevs_app_ui_template/utils/basic_widget_imports.dart';
//
//
// class InitialSendingDropdown extends StatelessWidget {
//
//
//   const InitialSendingDropdown({
//
//     Key? key,
//
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: Dimensions.inputBoxHeight * 0.8,
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: CustomColor.primaryLightTextColor.withOpacity(0.1),
//           width: 2,
//         ),
//         borderRadius: BorderRadius.circular(Dimensions.radius * 0.7),
//       ),
//       child: DropdownButtonHideUnderline(
//         child: Padding(
//           padding: const EdgeInsets.only(left: 5, right: 10),
//           child: DropdownButton2(
//             hint: Padding(
//               padding: EdgeInsets.only(left: Dimensions.paddingSize * 0.7),
//               child: Text(
//                 Strings.selectCurrency,
//                 style: GoogleFonts.inter(
//                   fontSize: Dimensions.headingTextSize3 + 2,
//                   fontWeight: FontWeight.w400,
//                   color: CustomColor.primaryLightTextColor.withOpacity(0.2),
//                 ),
//               ),
//             ),
//             iconStyleData: IconStyleData(
//               icon: Padding(
//                 padding: const EdgeInsets.only(right: 8.0),
//                 child: Icon(
//                   Icons.arrow_drop_down,
//                   color: CustomColor.primaryLightTextColor.withOpacity(0.2),
//                 ),
//               ),
//             ),
//             dropdownStyleData: DropdownStyleData(
//               maxHeight: 200,
//               width: MediaQuery.of(context).size.width*0.9,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(14),
//                 color: Colors.white,
//               ),
//               elevation: 0,
//               scrollbarTheme: ScrollbarThemeData(
//                 radius: const  Radius.circular(40),
//                 thickness: MaterialStateProperty.all<double>(6),
//                 thumbVisibility: MaterialStateProperty.all<bool>(true),
//               ),
//             ),
//             menuItemStyleData: const MenuItemStyleData(
//               height: 44,
//               padding: EdgeInsets.only(left: 14, right: 14),
//             ),
//             isExpanded: true,
//             underline: Container(),
//             items: itemsList.map<DropdownMenuItem<SendMoneyModel>>((value) {
//               return DropdownMenuItem<SendMoneyModel>(
//                 value: value,
//                 child: Row(
//                   mainAxisAlignment: mainSpaceBet,
//                   children: [
//                     Row(
//                       children: [
//                         CircleAvatar(
//                           radius: 17,
//                           backgroundColor: Colors.transparent,
//                           backgroundImage: AssetImage(value.img),
//                         ),
//                         horizontalSpace(Dimensions.widthSize),
//                         TitleHeading3Widget(
//                           text: value.subTitle,
//                           color: CustomColor.primaryLightTextColor,
//                           fontSize: Dimensions.headingTextSize4 + 2,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ],
//                     ),
//                     horizontalSpace(Dimensions.widthSize),
//                     TitleHeading4Widget(
//                       text: value.title,
//                       color: CustomColor.primaryLightTextColor,
//                       fontSize: Dimensions.headingTextSize5,
//                     ),
//                   ],
//                 ),
//               );
//             }).toList(),
//             onChanged: onChanged,
//           ),
//         ),
//       ),
//     );
//   }
// }
