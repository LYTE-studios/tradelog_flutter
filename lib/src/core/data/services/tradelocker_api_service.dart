import 'package:dio/dio.dart';
import 'package:tradelog_flutter/secrets.dart';
import 'package:tradelog_flutter/src/core/data/models/dto/tradelocker/tradelocker_credentials_dto.dart';
import 'package:tradelog_flutter/src/core/data/services/api_service.dart';

class TradelockerApiService extends ApiService {
  TradelockerApiService({
    super.baseUrl = '${apiUrl}trade_locker/',
  });

  Future<bool> authenticate(TradelockerCredentialsDto dto) async {
    Response response = await post(
      'login/',
      body: dto.toJson(),
    );

    if (response.statusCode == 200) {
      return true;
    }

    return false;
  }
}
