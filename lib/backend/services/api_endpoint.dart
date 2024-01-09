import '../../extensions/custom_extensions.dart';

class ApiEndpoint {
  static const String mainDomain = "https://capitelcltd.com";
  static const String baseUrl = "$mainDomain/api/v1";

  //-> Login
  static String loginURL = '/login'.addBaseURl();

  //-> Forgot Password
  static String forgotPasswordSendOtpURL =
      '/password/forgot/find/user'.addBaseURl();
  static String forgotOtpVerifyURL =
      '/password/forgot/verify/code'.addBaseURl();
  static String resendCodeURL =
      '/password/forgot/resend/code?token='.addBaseURl();
  static String resetPasswordURL = '/password/forgot/reset'.addBaseURl();

  //-> Register
  static String registerURL = '/register'.addBaseURl();
  static String registerOtpVerifyURL = '/user/verify/code'.addBaseURl();
  static String registerOtpResendURL = '/user/resend/code'.addBaseURl();
  static String registerSmsCodeVerifyURL = '/user/sms/otp/verify'.addBaseURl();
  static String registerSmsCodeResendURL = '/user/sms/resend/code'.addBaseURl();
  static String logOutURL = '/user/logout'.addBaseURl();

  //-> Profile
  static String profileInfoGetURL = '/user/profile/info'.addBaseURl();
  static String profileUpdateURL = '/user/profile/info/update'.addBaseURl();
  static String passwordUpdateURL =
      '/user/profile/password/update'.addBaseURl();
  static String deleteAccountURL = '/user/profile/delete-account'.addBaseURl();

  //-> Change password
  static String changePasswordURL =
      '/user/profile/password/update'.addBaseURl();

  //-> Kyc
  static String kycInfoURL = '/user/profile/kyc/input-fields'.addBaseURl();
  static String kycSubmitURL = '/user/profile/kyc/submit'.addBaseURl();
// \p
  //-> About Us
  static String aboutUsURL = '/user/sections/about-us?language=en'.addBaseURl();

  //-> Two Facator
  static String twoFactorStatusURL = '/user/2fa/status'.addBaseURl();
  static String twoFactorSubmitURL = '/user/2fa/submit'.addBaseURl();
  static String twoFactorVerifyURL = '/user/2fa/verify'.addBaseURl();
  static String twoFactorResendURL = '/user/2fa/resend'.addBaseURl();
  static String twoFactorDisabledURL = '/user/2fa/disabled'.addBaseURl();

  /// Two fa
  static String twoFaGetURL = '/user/profile/google-2fa'.addBaseURl();
  static String twoFaSubmitURL =
      '/user/profile/google-2fa/status/update'.addBaseURl();
  static String twoFaOtoVerifyURL = '/user/google-2fa/otp/verify'.addBaseURl();

  /// >> notification
  static String notificationURL = '/user/notification'.addBaseURl();
  static String transactionURL = '/user/transaction/index'.addBaseURl();
  static String allTransactionURL = '/all/transaction'.addBaseURl();

  /// >> Send Remittance
  ///
  static String getTransactionTypeUrl = '/send-remittance/index'.addBaseURl();
  static String sendRemittanceUrl = '/user/send-remittance/store'.addBaseURl();
  static String beneficiaryListUrl =
      '/user/send-remittance/beneficiary?identifier='.addBaseURl();
  static String selectBeneficiaryUrl =
      '/user/send-remittance/beneficiary-send'.addBaseURl();
  static String beneficiaryStoreUrl =
      '/user/send-remittance/beneficiary-store'.addBaseURl();
  static String sendingPurposeInfoUrl =
      '/user/send-remittance/receipt-payment?identifier='.addBaseURl();

  static String banksAndMobileMethodURL =
      '/user/send-remittance/beneficiary-add'.addBaseURl();

  static String receiptPaymentStoreURL =
      '/user/send-remittance/receipt-payment-store'.addBaseURl();
  static String submitDataUrl =
      '/user/send-remittance/submit-data'.addBaseURl();
  static String manualPaymentConfirmUrl =
      '/user/send-remittance/manual/payment/confirmed'.addBaseURl();
  static String stripePaymentConfirmUrl =
      '/user/send-remittance/stripe/payment/confirm'.addBaseURl();

  /// Beneficiary
  static String beneficiaryIndexUrl = '/user/beneficiary/index'.addBaseURl();
  static String beneficiaryStoreMainUrl =
      '/user/beneficiary/store'.addBaseURl();
  static String beneficiaryUpdateURL = '/user/beneficiary/update'.addBaseURl();
  static String beneficiaryDeleteURL = '/user/beneficiary/delete'.addBaseURl();

  // Settings
  static String basicSettingsURL = '/settings/basic-settings'.addBaseURl();

  // Transfer Calculator
  static String transferCalculatorUrl =
      '/send-remittance/send-money'.addBaseURl();
  // Languages
  static String languagesURL = '/settings/language'.addBaseURl();
}
