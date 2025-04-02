class AppStrings {
  static final AppStrings _instance = AppStrings._internal();

  factory AppStrings() {
    return _instance;
  }

  AppStrings._internal();


  /// Drawer
  static String drawerTable = "Table";
  static String drawerBill = "Bill";
  static String drawerOrder = "Order";
  static String drawerReport = "Report";
  static String drawerAnalytics = "Analytics";
  static String drawerLogout = "Logout";

  /// Model Layout

  static String cancel = 'Cancel';
  static String submit = 'Submit';

  /// Login page
  static String isRequired = "is required";
  static String userName = "User Name";
  static String password = "Password";
  static String logIn = "Log In";
  static String welcomeBackToRestaurantPos = 'Welcome Back to Restaurant Pos ';
  static String rememberMe = 'Remember me';
  static String forgotPassword = 'Forgot password?';

  /// Forgot Password Screen

  static String smallHintsForForgotPassword = "No Worries, we'll send you rest instruction";

  /// Otp Verify

  static String otpVerify = 'Verification';
  static String otpVerifyHintText = 'We Send you a code to verify Your ';
  static String stContinue = 'Continue';

  /// Reset Password

  static String restPassword = 'Reset Password';
  static String restPasswordHitText = 'At least 9 characters, with uppercase and lowercase letters';
  static String newPassword = 'New Password';
  static String confirmPassword = 'Confirm Password';
  static String passwordDoseNotMatch = 'New Password And Confirm Password Is Not Matched.';


  /// Analytics Page

  static String analytics = "Analytics";

  /// Bill Preview Page

  static String billPreview = "Bill Preview";
  static String billOrderNo = "Order No. :";
  static String billDate = "Date :";
  static String billName = "Name :";
  static String billMobile = "Mobile :";
  static String Item = "Item";
  static String Qty = "Qty";
  static String Amount = "Amount";
  static String SubTotal = "Sub Total";
  static String CGST = "CGST";
  static String SGST = "SGST";
  static String Discount = "Discount";
  static String RoundUp = "RoundUp";
  static String Total = "Total";
  static String ThankYouForVisiting  = "🙏 Thank you for visiting 🙏";
  static String PrintBill  = "Print Bill";


  /// KOT Preview Page

  static String kotPreview = "KOT Preview";
  static String date = "Date : ";
  static String printKOT = "Print KOT";


  /// Order Page

  static String allItems = "All Items";
  static String added = "Added";
  static String setDiscount = "Set Discount";
  static String discountType = "Discount Type";
  static String discount = "Discount";
  static String tax = "Tax";
  static String save = "Save";
  static String KOT = "KOT";
  static String Notes = "Notes";
  static String addedItem = "Added Item";
  static String addNotes = "Add Notes";
  static String noItemFound = "No Item Found";
  static String delete = "Delete";
  static String deleteItem = "Are you sure you want to delete this item?";
  static String yesDeleteItem = "Yes, delete it!";
  static String cancelItem = "Cancel";
  static String pricingSummary = "Pricing Summary";
  static String Subtotal = "Subtotal";
  static String clearTable = "Clear Table";
  static String order = "Order";


  /// Payment Screen

  static String payment = 'Payment';
  static String quickCash = 'Quick Cash';
  static String paymentType = 'Payment Type';
  static String customerName = 'Customer Name';
  static String mobileNo = 'Mobile No';
  static String cashAmount = 'Cash Amount';
  static String bankAmount = 'Bank Amount';
  static String totalItems = 'Total Items';
  static String discountWithSign = 'Discount(-)';
  static String cgstSgst = '(cgst + sgst)';
  static String gst = 'Gst:';
  static String roundUP = 'RoundUP:';
  static String totalPayable = 'Total Payable:';
  static String totalPaying = 'Total Paying';
  static String balance = 'Balance';
  static String changeReturn = 'Change Return:';
  static String savePrint = 'Save & Print';


  /// Report Screen

  static String report = "Report";
  static String view = "View";


  /// Table Screen

  static String table = "Table";

  /// Bill Screen

}