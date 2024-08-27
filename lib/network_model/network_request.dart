import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

class ApiClient {
  static const url = 'https://api.openai.com/v1/chat/completions';

  static Future<dynamic> postRequest({required String message}) async {
    print("API request is being made...");
    const apikey = '';

    try {
      final response = await post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${dotenv.env['API_KEY']}'
        },
        body: jsonEncode({
          "model": "gpt-4o-mini",
          "messages": [
            {
              "role": "system",
              "content": "You are a helpful assistant."
            },
            {
              "role": "user",
              "content": "Hello!"
            }
          ]
        })
      );
      print(response.body);
      print("API request completed.");

      if (response.statusCode == 200) {
        print(response.body);
        final data = jsonDecode(response.body);
        print(data['choices'][0]['message']['content']);
        return data['choices'][0]['message']['content'];
      } else {
        print('Failed to load data: ${response.statusCode}');
        return null;
      }
    } on HttpException catch (e) {
      print('HttpException: ${e.message}');
      return null;
    } catch (e) {
      print('Exception: ${e.toString()}');
      return null;
    }
  }
}
