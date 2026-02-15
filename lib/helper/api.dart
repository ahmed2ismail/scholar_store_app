import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class Api {
  final String _baseUrl = 'https://fakestoreapi.com';

  Future<dynamic> getRequest({
    String? endpoint,
    Map<String, String>? headers,
    String? token,
    // token دي اللي هي ال authorization token اللي بتبعتها في ال headers عشان تقدر توصل لل api لو كانت محمية ب token
    // وال toke دي زي مثلا token بتاع ال user اللي عامل login في التطبيق عشان يقدر يوصل لل api ويجيب بياناته الشخصية او يعمل اي حاجة محتاجة authentication
  }) async {
    if (token != null) {
      // headers!['Authorization'] = 'Bearer $token';
      headers!.addAll({'Authorization': 'Bearer $token'});
    }
    log('url: $_baseUrl$endpoint, headers: $headers, token: $token');
    final response = await http.get(Uri.parse('$_baseUrl$endpoint'));
    if (response.statusCode == 200 || response.statusCode == 201) {
      dynamic data = jsonDecode(response.body); // Changed to dynamic
      return data;
    } else {
      throw Exception(
        'Failed to load data ... Status Code: ${response.statusCode} with body: ${jsonDecode(response.body)}',
      );
    }
  }

  Future<dynamic> postRequest({
    String? endpoint,
    Map<String, String>? body,
    Map<String, String>? headers,
    String? token,
  }) async {
    if (token != null) {
      // headers!['Authorization'] = 'Bearer $token';
      headers!.addAll({'Authorization': 'Bearer $token'});
    }
    log(
      'url: $_baseUrl$endpoint, body: $body, headers: $headers, token: $token',
    );
    final response = await http.post(
      Uri.parse('$_baseUrl$endpoint'),
      body: body,
      headers: headers,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      dynamic data = jsonDecode(response.body); // Changed to dynamic
      return data;
    } else {
      throw Exception(
        'Failed to post data ... Status Code: ${response.statusCode} with body: ${jsonDecode(response.body)}',
      );
    }
  }

  // ال putRequest بتستخدم عشان تعدل بيانات موجودة بالفعل في ال api وغالبا بتبقى محتاجة id عشان تعرف تعدل على ايه ونوع البيانات اللي بتبعتها بيبقى شبه ال postRequest بس الفرق ان ال method بتاعتها بتبقى put مش post ونوع البيانات اللي بتبعتها بيبقى غالبا x-www-formurlencoded اللي هو عبارة عن json مش form-data
  // putRequest is used to update existing data in the API. It usually requires an ID to specify which data to update. The data type sent is similar to postRequest, but the method is 'PUT' instead of 'POST', and the content type is often 'x-www-form-urlencoded', which is like JSON rather than form-data.
  Future<dynamic> putRequest({
    String? endpoint,
    Map<String, String>? body,
    Map<String, String>? headers,
    String? token,
  }) async {
    if (token != null) {
      headers!.addAll({
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/x-www-form-urlencoded',
      });
    }
    log(
      'url: $_baseUrl$endpoint, body: $body, headers: $headers, token: $token',
    );
    final response = await http.put(
      Uri.parse('$_baseUrl$endpoint'),
      body: body,
      headers: headers,
    );
    if (response.statusCode == 200) {
      dynamic data = jsonDecode(response.body); // Changed to dynamic
      return data;
    } else {
      throw Exception(
        'Failed to put data ... Status Code: ${response.statusCode} with body: ${jsonDecode(response.body)}',
      );
    }
  }

  Future<dynamic> deleteRequest({
    String? endpoint,
    Map<String, String>? headers,
    String? token,
  }) async {
    if (token != null) {
      headers!.addAll({'Authorization': 'Bearer $token'});
    }
    log('url: $_baseUrl$endpoint, headers: $headers, token: $token');
    final response = await http.delete(
      Uri.parse('$_baseUrl$endpoint'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      dynamic data = jsonDecode(response.body); // Changed to dynamic
      return data;
    } else {
      throw Exception(
        'Failed to delete data ... Status Code: ${response.statusCode} with body: ${jsonDecode(response.body)}',
      );
    }
  }
}



/*
          // ال post man عبارة عن request بستخدمه عشان اضيف بيانات جديدة في ال api بياخد مني 
          // 1- url ال api اللي انا عايز ابعتله البيانات
          // 2- body ال data اللي انا عايز ابعتها في ال api
          // 3- headers شوية بيانات عن ال request اللي انا بعمله زي نوع ال content اللي انا ببعته وبستقبل بيانات ايه وعندي Authorization ولا لا في حالة ال api محمية ب token
          // ال post request في معظم الاوقات بتكون من نوع form-data يعني ال body بتاعتها عبارة عن خريطة مش json

          http.Response? response = await http.post(
            Uri.parse('https://fakestoreapi.com/products'),
            // ال body بتاعت ال post request دي بتبعت البيانات اللي انا عايز اضيفها في ال api يعني عن طريقها اقدر ابعت بيانات المنتج الجديد اللي انا عايز اضيفه
            body: {
              'title': 'test product',
              'price': '13.5',
              'description': 'lorem ipsum set',
              'image': 'https://i.pravatar.cc',
              'category': 'electronic',
            },
            // ال headers بتاعت ال post بيتبعت فيها شوية بيانات عن ال post request اللي انا بعمله زي نوع ال content اللي انا ببعته
            headers: {
              // هنحط هنا نوع البيانات اللي انا ببعتها في ال body ونوع البيانات اللي انا عايز استقبلها من ال api
              // هنا بقول لل api ان البيانات اللي انا بعتها دي من نوع json
              // انا هنا بقولوا ان البيانات اللي انا بعتها دي من نوع multipart/form-data عشان كده ال body بتاعتي عبارة عن خريطة مش json
              'Accept': 'application/json',
              'Content-Type': 'application/x-www-form-urlencoded',
              'Authorization': 'Bearer ............. token ',
            },
          );
          print(response.body);
*/