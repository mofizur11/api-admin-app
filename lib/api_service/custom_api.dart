import 'dart:convert';

import 'package:admin_app/model/order_model.dart';
import 'package:admin_app/widget/const.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CustomHttp {
  static const Map<String, String> defaultHeader = {
    "Accept": "application/json",
  };

  static Future<Map<String, String>> getHeaderWithToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var header = {
      "Accept": "application/json",
      "Authorization": "bearer ${sharedPreferences.getString("token")}",
    };
    print("user token isssss ${sharedPreferences.getString("token")}");
    return header;
  }

  static Future<String> login(String email, String password) async {
    try {
      var link = "${baseUrl}api/admin/sign-in";
      var map = <String, dynamic>{};
      map["email"] = email;
      map["password"] = password;
      final response = await http.post(
        Uri.parse(link),
        body: map,
        // headers: defaultHeader,
      );
      if (response.statusCode == 200) {
        showInToast("Login Successfully");
        return response.body;
      } else {
        showInToast("Invalid email or password");
        print("something is wrong");
        return "something is wrong";
      }
    } catch (e) {
      return "something is wrong$e";
    }
  }

    Future<List<OrderModel>> fetchOrder() async {
    List<OrderModel> orderList = [];
    try {
      var link = "${baseUrl}api/admin/all/orders";
      var response = await http.get(
          Uri.parse(
            link,
          ),
          headers: await getHeaderWithToken());

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        OrderModel orderModel;
        for (var i in data) {
          orderModel = OrderModel.fromJson(i);
          orderList.add(orderModel);
        }
        print("Order Data is $data");
        return orderList;
      } else {
        showInToast("Something is wrong bro!");
        return orderList;
      }
    } catch (e) {
      print("Errorrrrrrrrrrrrrr $e");
      return orderList;
    }
  }
}
