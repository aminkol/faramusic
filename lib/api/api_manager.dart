import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'api_response_model.dart';


class ApiManager{
  Future<ApiResponseModel> get(String url) async{
    ApiResponseModel responseModel = ApiResponseModel();
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body);
        var status = jsonResponse["status"];
        var data = jsonResponse["data"];
        if (status == "ok") {

          responseModel.data = data;

        } else {
          responseModel.status = 'error';
          responseModel.error = data;
        }
      } else {
        responseModel.status = 'error';
        responseModel.error = 'خطا در ارتباط با سرور';
      }
    } catch (e) {
      responseModel.status = 'error';
      responseModel.error = 'خطا در ارتباط با سرور';
      print(e.toString());
    }

    return responseModel;
  }

  Future<ApiResponseModel> post(String url, data) async{
    ApiResponseModel responseModel = ApiResponseModel();
    try {
      var response = await http.post(Uri.parse(url), body: data,
          headers: {
          "Accept": "application/json",
          "Access-Control-Allow-Origin": "*",
          'Accept': '*/*'
          });

      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body);
        var status = jsonResponse["status"];
        var data = jsonResponse["data"];
        if (status == "ok") {

          responseModel.data = data;

        } else {
          responseModel.status = 'error';
          responseModel.error = data;
        }
      } else {
        responseModel.status = 'error';
        responseModel.error = 'خطا در ارتباط با سرور';
      }
    } catch (e) {
      responseModel.status = 'error';
      responseModel.error = 'خطا در ارتباط با سرور';
      print(e.toString());
    }

    return responseModel;
  }
}