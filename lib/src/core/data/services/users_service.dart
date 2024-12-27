import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:tradelog_flutter/secrets.dart';
import 'package:tradelog_flutter/src/core/data/models/dto/users/overview_statistics_dto.dart';
import 'package:tradelog_flutter/src/core/data/models/dto/users/trade_list_dto.dart';
import 'package:tradelog_flutter/src/core/data/models/dto/users/trade_note_dto.dart';
import 'package:tradelog_flutter/src/core/data/models/dto/users/trading_account_list_dto.dart';
import 'package:tradelog_flutter/src/core/data/services/api_service.dart';

class UsersService extends ApiService {
  UsersService({
    super.baseUrl = '${apiUrl}users/',
  });

  Future<TradeNoteDto> getTradeNote(DateTime date) async {
    Response response = await get('trade-notes/', queryParameters: {
      'date': DateFormat('yyyy-MM-dd').format(date),
    });

    if (response.statusCode == 200) {
      if (response.data.isEmpty) return TradeNoteDto(note: '', date: date);

      return TradeNoteDto.fromJson(response.data[0]);
    }

    throw Exception('Could not fetch note');
  }

  Future<void> updateTradeNote({
    required TradeNoteDto note,
  }) async {
    Response response = await post(
      'trade-notes/',
      body: note.toJson(),
    );

    if (response.statusCode == 200) {
      return;
    }

    throw Exception('Could not update note');
  }

  Future<TradingAccountListDto> fetchAllAccounts() async {
    Response response = await get('get_all_accounts/');

    if (response.statusCode == 200) {
      return TradingAccountListDto.fromJson(response.data);
    }

    throw Exception('Could not fetch Accounts');
  }

  Future<TradeListDto> fetchTrades({DateTime? from, DateTime? to}) async {
    Response response = await get(
      'get_all_trades/',
      queryParameters: from != null && to != null
          ? {
              'from': DateFormat('yyyy-MM-dd').format(from),
              'to': DateFormat('yyyy-MM-dd').format(to),
            }
          : {},
    );

    if (response.statusCode == 200) {
      return TradeListDto.fromJson(response.data);
    }

    throw Exception('Could not fetch Trades');
  }

  Future<void> refreshAccount({
    bool forceRefresh = true,
  }) async {
    await post('refresh-account/', body: {
      'force_refresh': forceRefresh,
    });
  }

  Future<OverviewStatisticsDto> getAccountStatistics() async {
    Response response = await get('statistics/');

    if (response.statusCode == 200) {
      return OverviewStatisticsDto.fromJson(response.data);
    }

    throw Exception('Could not fetch Statistics');
  }
}
