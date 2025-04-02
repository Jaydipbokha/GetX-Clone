class AppConstant {
  static final AppConstant _instance = AppConstant._internal();

  factory AppConstant() {
    return _instance;
  }

  AppConstant._internal();

  static String rubik = "Rubik";
  static String android = "ANDROID";
  static String  ios= "IOS";
  static String  appName= "Restaurant POS";
}
