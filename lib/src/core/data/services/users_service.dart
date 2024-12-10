import 'package:dio/dio.dart';
import 'package:tradelog_flutter/secrets.dart';
import 'package:tradelog_flutter/src/core/data/services/api_service.dart';

class UsersService extends ApiService {
  UsersService({
    super.baseUrl = '${apiUrl}users/',
  });

  Future<bool> isAuthenticated() async {
    try {
      Response response = await get(
        'hello-there/',
      );
      if (response.statusCode == 200) {
        return true;
      }

      return false;
    } on DioException catch (e) {
      return false;
    }
  }
}
