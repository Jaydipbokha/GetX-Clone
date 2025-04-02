class ApiConstant {
  static final ApiConstant _instance = ApiConstant._internal();

  factory () {
    return _instance;
  }

  ApiConstant._internal();

  static String appsource = 'app_source';
  static String appversion = 'app_version';

  static String status = 'status';
  static String statuscode = 'status_code';
  static String msg = 'msg';


  /// login

  static String email = 'email';
  static String password = 'password';
  static String loginType = 'login_type';

  static String token = "Token";
  static String source = "Source";
  static String version = "Version";


  /// Otp Verification

  static String oneTimePassword = 'one_time_password';

  /// Reset Password

  static String newPassword = 'new_password';
  static String confirmPassword = 'confirm_password';
  static String isForget = 'is_forget';


  /// All Items Screen

  static String tableId = 'table_id';
  static String q = 'q';
  static String itemId = 'item_id';
  static String orderId = 'order_id';
  static String itemQty = 'item_qty';
  static String counterId = 'counter_id';
  static String itemRemark = 'item_remark';
  static String discountType = 'discount_type';
  static String discountInput = 'discount_input';
  static String kotNo = 'kot_no';

  /// Payment Screen

  static String paymentType = 'payment_type';
  static String customerName = 'customer_name';
  static String mobileNo = 'mobile_no';
  static String cashAmount = 'cash_amount';
  static String onlineAmount = 'online_amount';
  static String returnAmount = 'return_amount';
  static String totalPayable = 'total_payable';
  static String discountPer = 'discount_per';
  static String discountAmt = 'discount_amt';

  /// Report Screen

  static String type = 'type';
  static String fromDate = 'from_date';
  static String toDate = 'to_date';
}