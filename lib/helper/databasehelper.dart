import 'dart:convert';

import 'package:http/http.dart' as http;

class DBHelper {
  var status;
  loginData(String email, String password) async {
    String myUrl = 'https://backendapilaravel-app.herokuapp.com/api/login';
    final response = await http.post(Uri.parse(myUrl), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    }, body: {
      'email': "$email",
      'password': "$password"
    });
    status = response.body.contains('error');
    var res = json.decode(response.body);
    if (response.statusCode == 200) {
      // savePref(res['data']['name'], res['user']['name']);
      print('data : ${res['error']}');
      // return response.body;
    } else {
      // return json.decode(response.body);
    }
  }

  // Get Data
  Future<List> getData() async {
    String myUrl = 'https://backendapilaravel-app.herokuapp.com/api/product';
    http.Response response = await http
        .get(Uri.parse(myUrl), headers: {'Accept': 'application/json'});

    return json.decode(response.body)['data'];
  }

  void deleteData(int id) async {
    String myUrl =
        'https://backendapilaravel-app.herokuapp.com/api/product/$id';
    http.delete(
      Uri.parse(myUrl),
      headers: {'Accept': 'application/json'},
    ).then((response) {
      print('delete data: ' + response.body);
    });
  }
}
