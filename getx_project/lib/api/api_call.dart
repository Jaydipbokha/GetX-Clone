import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constant/constant.dart';
import '../constant/get_storage_constant.dart';
import '../constant/package_info_constant.dart';
import '../main.dart';
import '../presentation/login/controller/login_controller.dart';
import '../widget/custom_functions.dart';
import '../widget/snack_bar.dart';
import 'api_constant.dart';
import 'apis.dart';

class ApiCall {
  static final ApiCall _instance = ApiCall._internal();
  static int isLogout = 0;
  static LoginController loginController = Get.put(LoginController());

  factory() {
    return _instance;
  }

  ApiCall._internal();

  static final dio.Dio _dio = dio.Dio(
    dio.BaseOptions(
      baseUrl: Apis.baseUrl,

      // Replace with your API URL
    ),
  );

  static postApiCall(
      {@required String? endPoint,
      Map<String, dynamic>? params,
      bool isLoader = false,
      bool isLogin = true,
      bool isFormData = false,
      String? token,
      bool isHeader = true,
      bool showSuccess = false}) async {
    Map<String, String> header = {};
    if (isHeader) {
      header = {
        "Authorization": token != null
            ? 'Bearer $token'
            : "Bearer ${localData.read(GetStorageConstant.token)}",
      };
    }

    if (params != null) {
      params.addAll({
        ApiConstant.appsource:
            (Platform.isAndroid) ? AppConstant.android : AppConstant.ios,
        ApiConstant.appversion: PackageInformation.version
      });
    }

    if (!isFormData) {
      log('params  ${jsonEncode(params)}');
    } else {
      log('params  ${(params)}');
    }

    try {
      dio.Response response;
      log("api.... ${Apis.baseUrl}$endPoint");
      if (isFormData) {
        dio.FormData formData = dio.FormData.fromMap(params!);
        response = await _dio.post(endPoint!,
            data: formData, options: dio.Options(headers: header));
      } else {
        response = await _dio.post(endPoint!,
            data: params, options: dio.Options(headers: header));
      }

      log('response........ ${jsonEncode(response.data)}');
      if (response.statusCode == 200) {
        if (isLoader) {
          hideLoader();
        }
        if (showSuccess) {
          showSnakBar(0, msg: response.data['msg']);
        }
        return response.data;
      } else {
        if (isLoader) {
          hideLoader();
        }

        showSnakBar(1, msg: response.data[ApiConstant.msg]);
        return response.data;
      }
    } on dio.DioException catch (e) {
      if (isLoader) {
        hideLoader();
      }
      log("error url........ ${Apis.baseUrl}$endPoint");
      log("error data........ ${e.response!.data}");
      log('error params........ $params');
      _handleDioError(e);
    }
  }

  static getApiCall({
    @required String? endPoint,
    Map<String, dynamic>? params,
    bool isLoader = false,
    bool isFormData = false,
    String? token,
    bool isHeader = true,
    bool showSuccess = false,
  }) async {
    params ??= {};

    Map<String, String> header = {};

    if (isHeader) {
      header = {
        "Authorization": token != null
            ? 'Bearer $token'
            : "Bearer ${localData.read(GetStorageConstant.token)}",
      };
    }
    log("header -=-> $header");
    params.addAll({
      ApiConstant.appsource:
          (Platform.isAndroid) ? AppConstant.android : AppConstant.ios,
      ApiConstant.appversion: PackageInformation.version
    });
    log("params ---> $params");
    try {
      dio.Response response;
      if (isFormData) {
        dio.FormData formData = dio.FormData.fromMap(params);
        print('form data.... ${formData.fields}');
        response = await _dio.get(endPoint!,
            data: formData, options: dio.Options(headers: header));
      } else {
        response = await _dio.get(endPoint!,
            queryParameters: params, options: dio.Options(headers: header));
      }
/*
      var response = await _dio.get(endPoint!, queryParameters: data);
      print('response...  ${response}');
*/
      if (response.statusCode == 200) {
        if (isLoader) {
          hideLoader();
        }
        if (showSuccess) {
          showSnakBar(0, msg: response.data['msg']);
        }
        return response.data;
      } else {
        print('response........2 $response');
        if (isLoader) {
          hideLoader();
        }
        print('response... ${response.data}');
        print('message....${response.statusMessage}');
        showSnakBar(1, msg: response.data[ApiConstant.msg]);
        return response.data;
      }
    } on dio.DioException catch (e) {
      if (isLoader) {
        hideLoader();
      }
      log("error url........ ${Apis.baseUrl}$endPoint");
      // log("error data........ ${e.response!.data}");
      log('error params........ $params');
      _handleDioError(e);
    }
  }

  static String _handleDioError(dio.DioException error) {
    log('error messgae exception ${error.response!}');
    if (error.response != null && error.response!.data != null) {
      // Handle "Please Update Your App" error
      showSnakBar(1, msg: error.response!.data[ApiConstant.msg]);
    }

    // showSnakBar(1, msg: error.response!.data[ApiConstant.msg]);
    switch (error.type) {
      case dio.DioExceptionType.connectionTimeout:
        return "Connection timeout. Please try again.";
      case dio.DioExceptionType.sendTimeout:
        return "Request send timeout. Please try again.";
      case dio.DioExceptionType.receiveTimeout:
        return "Response timeout. Please try again.";
      case dio.DioExceptionType.badResponse:
        return "Received invalid status code: ${error.response!.data[ApiConstant.msg]}";
      case dio.DioExceptionType.cancel:
        return "Request to the server was cancelled.";
      case dio.DioExceptionType.connectionError:
        return "No Internet connection.";
      default:
        return "Something went wrong. Please try again.";
    }
  }
}
