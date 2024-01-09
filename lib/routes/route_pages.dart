import 'package:get/get.dart';

import '../../routes/routes.dart';
import '../../views/auth/2fa_verification/twofa_verification.dart';
import '../../views/auth/congratulation_screen/congratulation_screen.dart';
import '../../views/auth/kyc_information/kyc_information.dart';
import '../../views/auth/sign_up_screen/sign_up_failure_screen/sign_up_failure_screen_mobile.dart';
import '../../views/auth/sign_up_screen/sign_up_otp_verification/sign_up_otp_verification_screen.dart';
import '../../views/bottom_nav_bar/bottom_nav_bar.dart';
import '../../views/drawer_screens/profile_screen/profile_screen.dart';
import '../../views/drawer_screens/transfer_log_screen/transfer_log_screen.dart';
import '../../views/onboard_screen/onboard_screen.dart';
import '../../views/payment_information/payment_information.dart';
import '../../views/payment_preview/payment_preview.dart';
import '../../views/track_your_transaction/track_your_transaction_screen.dart';
import '../bindings/splash_screen_binding.dart';
import '../views/add_new_recipient/add_new_recipient.dart';
import '../views/auth/2fa_verification/two_fa_verification_screen.dart';
import '../views/auth/sign_in_screen/otp_verification/otp_verification_screen.dart';
import '../views/auth/sign_in_screen/reset_password/reset_password_screen.dart';
import '../views/auth/sign_in_screen/sign_in_screen_folder/sign_in_screen.dart';
import '../views/auth/sign_up_screen/sign_up_screen_folder/sign_up_screen.dart';
import '../views/dashboard/beneficiaries/beneficiaries_screen.dart';
import '../views/drawer_screens/change_password_screen/change_password_screen.dart';
import '../views/drawer_screens/edit_beneficairy/add_or_edit_beneficiary_screen.dart';
import '../views/drawer_screens/saved_beneficairy/saved_beneficiary.dart';
import '../views/drawer_screens/settings/settings_screen.dart';
import '../views/money_transfer/money_transfer_screen.dart';
import '../views/payment_information/send_remittance_manual_payment_screen.dart';
import '../views/recipient_information/recipient_information.dart';
import '../views/splash_screen/splash_screen.dart';
import '../views/transfer_calculator/transfer_calculator_screen.dart';

class RoutePageList {
  static var list = [
    GetPage(
      name: Routes.splashScreen,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.onBoardScreen,
      page: () => const OnboardScreen(),
    ),
    GetPage(
      name: Routes.trackYourTransaction,
      page: () => const TrackYourTransactionScreen(),
    ),
    GetPage(
      name: Routes.signInScreen,
      page: () => const SignInScreen(),
    ),
    GetPage(
      name: Routes.otpVerification,
      page: () => const OtpVerificationScreen(),
    ),
    GetPage(
      name: Routes.resetPasswordScreen,
      page: () => const ResetPasswordScreen(),
    ),
    GetPage(
      name: Routes.congratulationScreen,
      page: () => const CongratulationScreen(),
    ),
    GetPage(
      name: Routes.signUpScreen,
      page: () => const SignUpScreen(),
    ),
    GetPage(
      name: Routes.signUpOtpVerificationScreen,
      page: () => const SignUpOtpVerificationScreen(),
    ),
    GetPage(
      name: Routes.moneyTransferScreen,
      page: () => const TransferMoneyScreen(),
    ),
    GetPage(
      name: Routes.profileScreen,
      page: () => const ProfileScreen(),
    ),
    GetPage(
      name: Routes.transferLogScreen,
      page: () => const TransferLogScreen(),
    ),
    GetPage(
      name: Routes.savedRecipients,
      page: () => const SavedBeneficiaryScreen(),
    ),
    GetPage(
      name: Routes.recipientInformationScreen,
      page: () => const RecipientInformationScreen(),
    ),
    GetPage(
      name: Routes.paymentInformationScreen,
      page: () => const PaymentInformationScreen(),
    ),
    GetPage(
      name: Routes.addNewRecipientScreen,
      page: () => const AddNewRecipientScreen(),
    ),
    GetPage(
      name: Routes.paymentPreviewScreen,
      page: () => const PaymentPreview(),
    ),
    GetPage(
      name: Routes.transferCalculatorScreen,
      page: () => const TransferCalculatorScreen(),
    ),
    GetPage(
      name: Routes.changePasswordScreen,
      page: () => const ChangePasswordScreen(),
    ),
    GetPage(
      name: Routes.signUpFailureScreen,
      page: () => const SignUpFailureScreen(),
    ),
    GetPage(
      name: Routes.bottomNavBar,
      page: () => const BottomNavBar(),
    ),
    GetPage(
      name: Routes.kycInformation,
      page: () => const KycInformationScreen(),
    ),
    GetPage(
      name: Routes.twoFAVerification,
      page: () => const TwoFAVerificationScreen(),
    ),
    GetPage(
      name: Routes.beneficiariesScreen,
      page: () => const BeneficiariesScreen(),
    ),
    GetPage(
      name: Routes.twoFaOtpVerificationScreen,
      page: () => TwoFaOtpVerificationScreen(),
    ),
    GetPage(
      name: Routes.addOrEditBeneficiaryScreen,
      page: () => AddOrEditBeneficiaryScreen(),
    ),
    GetPage(
      name: Routes.sendRemittanceManualPaymentScreen,
      page: () => SendRemittanceManualPaymentScreen(),
    ),
    GetPage(
      name: Routes.settingsScreen,
      page: () => SettingsScreen(),
    ),
  ];
}
