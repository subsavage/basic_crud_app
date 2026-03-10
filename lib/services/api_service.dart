import 'package:dio/dio.dart';
import '../models/models.dart';

class ApiService {
  late final Dio _dio;

  ApiService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://jsonplaceholder.typicode.com',
        connectTimeout: Duration(seconds: 10),
        receiveTimeout: Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        validateStatus: (status) {
          return status != null && status < 500;
        },
      ),
    );
  }

  Future<List<Users>> fetchUsers() async {
    try {
      final response = await _dio.get('/users');
      
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => Users.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load users: ${response.statusCode} - ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Error fetching users: $e');
    }
  }
}