import 'package:dio/dio.dart';

class ResponseModel<Model> {
  Model? data;
  bool? isSuccess;
  String? message;
  int? statusCode;
  DioException? dioException;

  ResponseModel({
    this.data,
    this.isSuccess,
    this.message,
    this.statusCode,
    this.dioException,
  });
}
