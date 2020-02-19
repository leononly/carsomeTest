import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class API {
  Dio dio = Dio();

  Future<dynamic> getButton1API(index) async {
    try {
      var response = await dio.get(
          'https://jsonplaceholder.typicode.com/photos?albumId=${index + 1}');

      print(response);
      return response.data;
    } catch (error) {
      debugPrint(error.toString());
      throw error.toString();
    }
  }
}
