import 'package:dio/dio.dart';
import 'package:tradelog_flutter/secrets.dart';
import 'package:tradelog_flutter/src/core/data/models/dto/users/trading_account_list_dto.dart';
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

  Future<TradingAccountListDto> fetchAllAccounts() async {
    Response response = await get('get_all_accounts/');

    if (response.statusCode == 200) {
      return TradingAccountListDto.fromJson(response.data);
    }

    throw Exception('Could not fetch Accounts');
  }

  Future<void> fetchTrades() async {
    Response response = await get('get_all_trades/');
  }
}
