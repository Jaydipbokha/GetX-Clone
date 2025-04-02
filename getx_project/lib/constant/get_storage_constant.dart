class GetStorageConstant {
  static final GetStorageConstant _instance = GetStorageConstant._internal();

  factory GetStorageConstant() {
    return _instance;
  }

  GetStorageConstant._internal();

  static String token = "token";
}