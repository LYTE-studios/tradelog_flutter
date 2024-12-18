import 'package:dio/dio.dart';
import 'package:tradelog_flutter/secrets.dart';
import 'package:tradelog_flutter/src/core/data/models/dto/c_trader/c_trader_credentials_dto.dart';
import 'package:tradelog_flutter/src/core/data/services/api_service.dart';

class CTraderApiService extends ApiService {
  CTraderApiService({
    super.baseUrl = '${apiUrl}c_trader/',
  });

  Future<bool> authenticate(CTraderCredentialsDto dto) async {
    Response response = await post(
      'login/',
      body: dto.toJson(),
    );

    if (response.statusCode == 200) {
      return true;
    }

    return false;
  }

  Future<bool> disconnect(int id) async {
    Response response = await delete(
      'delete/$id/',
    );

    if (response.statusCode == 200) {
      return true;
    }

    return false;
  }
}
