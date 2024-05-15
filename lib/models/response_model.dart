class ResponseModel<T> {
  late bool status;
  T? data;
  String? message;

  ResponseModel({required this.status, this.data, this.message});
}