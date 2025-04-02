class Apis {
  static final Apis _instance = Apis._internal();

  factory Apis() {
    return _instance;
  }

  Apis._internal();

  static String baseUrl = "https://pos.axoneit.com/api/";



  /// Login
  static String login = "login";

  /// Logout
  static String logout = "logout";

  /// Profile
  static String profile = "profile";

  /// Forgot Password
  static String sendOtp = "send-otp";

  /// Verification OTP
  static String verifyOtp = "verify-otp";

  /// Reset Password

  static String changePassword = "changepassword";

  /// Table

  static String tableList = 'table-list';

  /// All Item Screen

  static String categoryList = 'category-list';
  static String getItem = 'get-item';
  static String addItem = 'add-item';
  static String removeItem = 'delete-item';
  static String deleteAllItems = 'delete-all-items';
  static String applyOrderDiscount = 'apply-order-discount';


  /// Bill
  static String printBill = 'print-bill';
  static String orderItemPreview = 'order-item-preview';


  /// Kot
  static String kotItemPreview = 'kot-item-preview';
  static String kotItemDelete = 'kot-item-delete';
  static String createKot = 'create-kot';

  /// Payment
  static String orderPayment = 'order-payment';

  /// Report
  static String reportData = 'report-data';
}
