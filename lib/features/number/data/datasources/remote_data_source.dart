import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/errors/exceptions.dart';

abstract class RemoteDataSource {
  Future<int> getRandomNumber();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client;

  RemoteDataSourceImpl({required this.client});

  @override
  Future<int> getRandomNumber() async {
    try {
      final response = await client.get(
        Uri.parse('https://www.randomnumberapi.com/api/v1.0/random'),
      );

      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);

        if (decoded is List && decoded.isNotEmpty) {
          final number = decoded[0];

          if (number is int) {
            return number;
          } else {
            print("Unexpected format: First item is not an int");
            throw ServerException();
          }
        } else {
          print("Unexpected format: Response is not a non-empty list");
          throw ServerException();
        }
      } else {
        print("Request failed with status: ${response.statusCode}");
        throw ServerException();
      }
    } catch (e) {
      print("Exception caught: $e");
      throw ServerException();
    }
  }
}
