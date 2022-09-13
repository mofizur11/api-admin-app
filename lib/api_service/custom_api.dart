import 'package:admin_app/widget/const.dart';
import 'package:http/http.dart' as http;

class CustomHttp {
  static const Map<String, String> defaultHeader = {
    "Accept": "application/json",
  };

  static Future<String> login(String email, String password) async {
    try {
      var link = "${baseUrl}api/admin/sign-in";
      var map = <String, dynamic>{};
      map["email"] = email;
      map["password"] = password;
      final response = await http.post(
        Uri.parse(link),
        body: map,
        headers: defaultHeader,
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
}
