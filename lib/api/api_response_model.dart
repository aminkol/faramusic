class ApiResponseModel{
  String status = 'ok';
  String? error = '';
  dynamic data;

  ApiResponseModel({this.status = 'ok', this.error, this.data});


}