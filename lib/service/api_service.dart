import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

const baseUrl = "https://newsapi.org/v2";
const apiKey = "e42aafe8d1fa461fb0e3be69b756cb29";
// const apiKey = "0f755d44c1514d15bfe9721c0aeb3444";
const pageSize = 5;

enum ApiState { initial, loading, success, error }

enum ErrorState {
  notFound, //404
  serverError, //500
  networkError, // 
  badRequest,
  unknown, 
  tooManyReq, //429
} 

class RespObj {
  ApiState apiState;
  ErrorState? errorState;
  dynamic data;
  RespObj(this.apiState, this.data, {this.errorState});
}

class InfiniteObject {
  ApiState apiState;
  ErrorState? errorState;
  List<dynamic> data;

  InfiniteObject(this.apiState, this.data, {this.errorState});
}

class ApiService {
  final Dio dio = Dio();
  Future<RespObj> getData(String category, int page) async {
    RespObj respObj;
    try {
      final response = await dio.get(
        "$baseUrl/top-headlines",
        queryParameters: {
          "country": "us",
          "category": category,
          "pageSize": pageSize,
          "page": page,
          "apiKey": apiKey,
        },
      );
      debugPrint("Status Code in try : ${response.statusCode}");
      if (response.statusCode == 200) {
        respObj = RespObj(ApiState.success, response.data);
      } 
      else {
        respObj = RespObj(ApiState.error, "Something went Wrong",
            errorState: ErrorState.unknown);
      }
      return respObj;
    } on DioException catch (e) {
      RespObj respObj;
      if (e.response != null) {
        final statusCode = e.response!.statusCode;
        if (statusCode == 404) {
          respObj = RespObj(ApiState.error, "Page Not found",
              errorState: ErrorState.notFound);
        } else if (statusCode == 500) {
          respObj = RespObj(ApiState.error, "Server error",
              errorState: ErrorState.serverError);
        } else if (statusCode == 429) {
          respObj = RespObj(ApiState.error, "Too Many Requests",
              errorState: ErrorState.tooManyReq);
        } else {
          respObj = RespObj(ApiState.error, "Unknown error",
              errorState: ErrorState.unknown);
        }
        return respObj;
      }
      throw Exception(e.error.toString());
    }
  }
}
