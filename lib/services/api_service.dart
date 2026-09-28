import 'package:dio/dio.dart';
import '../models/user_model.dart';

class ApiService {
  final Dio _dio = Dio();

  // Mengambil daftar pengguna dari REST API Reqres.in
  Future<List<UserModel>> fetchUsers({String? token}) async {
    try {
      final response = await _dio.get(
        'https://reqres.in/api/users',
        queryParameters: {
          'page': 1,
        },
        options: Options(
          headers: {
            'x-api-key': 'reqres-free-v1',
          },
        ),
      );

      // Mengambil array data dari response JSON
      final List data = response.data['data'];

      // Mengubah JSON menjadi List<UserModel>
      return data
          .map((json) => UserModel.fromJson(json))
          .toList();
    } catch (e) {
      // Error handling
      throw Exception(_handleError(e));
    }
  }

  // Helper method untuk error handling
  String _handleError(dynamic error) {
    if (error is DioException) {
      if (error.response != null) {
        return 'Error ${error.response?.statusCode}: '
            '${error.response?.statusMessage}';
      }

      return 'Terjadi kesalahan koneksi ke server.';
    }

    return 'Terjadi kesalahan: $error';
  }
}