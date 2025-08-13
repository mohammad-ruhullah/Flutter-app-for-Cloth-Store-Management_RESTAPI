import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Style/style.dart';

var mobile = "http://10.0.2.2:8000";
var browser = "http://127.0.0.1:8000";

var device = mobile;

Future<Map> AllProductGet() async {
  var URL = Uri.parse("${device}/api/allproducts"); // api endpoint link
  var header = {"Content-Type" : "application/json"}; // make header for api call
  var response = await http.get(URL, headers: header); //api call
  var responseCode = response.statusCode; // this will get the response code of the api request
  var responseBody = json.decode(response.body); // json data will decode in usable list data

  if(responseCode == 200){
    return responseBody;
  }else{
    return {};
  }

}

Future<bool> ProductCrationReq(valuesForm) async{
  var URL = Uri.parse("${device}/api/products");
  var PostBody = json.encode(valuesForm); // this convert map data in jason data
  var PostHeader = {"Content-Type" : "application/json"};
  var response = await http.post(URL, headers: PostHeader, body: PostBody);
  var ResultCode = response.statusCode;

  if(ResultCode == 200){
    return true;
  }
  else{
    return false;
  }

}

Future<bool> ProductDelete(id) async {
  var URL = Uri.parse("${device}/api/delete/${id}");
  var response = await http.delete(URL);
  var responseStatusCode = response.statusCode;
  print("Delete URL: $URL");


  if(responseStatusCode == 200){
    return true;
  }else{
    return false;
  }
}

Future<bool> ProductUpdateReq(valuesForm, id) async{
  var URL = Uri.parse("${device}/api/update/${id}" );
  var PostBody = json.encode(valuesForm);
  var PostHeader = {"Content-Type" : "application/json"};
  var response = await http.post(URL, headers: PostHeader, body: PostBody);
  var ResultCode = response.statusCode;

  if(ResultCode == 200){
    return true;
  }
  else{
    return false;
  }

}