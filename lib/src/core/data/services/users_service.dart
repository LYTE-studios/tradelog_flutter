import 'dart:io';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:tradelog_flutter/secrets.dart';
import 'package:tradelog_flutter/src/core/data/models/dto/users/account_login_credentials_dto.dart';
import 'package:tradelog_flutter/src/core/data/models/dto/users/overview_statistics_dto.dart';
import 'package:tradelog_flutter/src/core/data/models/dto/users/trade_list_dto.dart';
import 'package:tradelog_flutter/src/core/data/models/dto/users/trade_note_dto.dart';
import 'package:tradelog_flutter/src/core/data/models/dto/users/trading_account_list_dto.dart';
import 'package:tradelog_flutter/src/core/data/models/dto/users/user_profile_dto.dart';
import 'package:tradelog_flutter/src/core/data/services/api_service.dart';

class UsersService extends ApiService {
  UsersService({
    super.baseUrl = '${apiUrl}users/',
  });

  Future<void> unlinkAccount(int id) async {
    Response response = await delete(
      'delete/$id',
    );

    if (response.statusCode == 200) {
      return;
    }

    throw Exception('Could not unlink account');
  }

  Future<bool> authenticateAccount(AccountLoginCredentialsDto dto) async {
    Response response = await post(
      'add-account/',
      body: dto.toJson(),
    );

    if (response.statusCode == 200) {
      return true;
    }

    return false;
  }

  Future<Map<DateTime, double>> getAccountBalanceChart(
      {DateTime? from, DateTime? to}) async {
    dynamic response = await get('account-balance/', // Use dynamic temporarily
        queryParameters: from != null && to != null
            ? {
                'from': DateFormat('yyyy-MM-dd').format(from),
                'to': DateFormat('yyyy-MM-dd').format(to),
              }
            : {});

    if (response.statusCode == 200) {
      return (response.data as Map)
          .map((key, value) => MapEntry<DateTime, double>(
                DateTime.parse(key),
                value,
              ));
    }

    throw Exception('Could not fetch account chart');
  }

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

  Future<UserProfileDto> getUserProfile() async {
    Response response = await get('profile/');

    if (response.statusCode == 200) {
      return UserProfileDto.fromJson(response.data);
    }

    throw Exception('Could not fetch User Profile');
  }

  Future<void> updateUserProfile(UserProfileDto profile) async {
    Response response = await put(
      'profile/',
      body: profile.toJson(),
    );

    if (response.statusCode == 200) {
      return;
    }

    throw Exception('Could not update User Profile');
  }

  Future<OverviewStatisticsDto> getAccountStatistics({
    DateTime? from,
    DateTime? to,
  }) async {
    Response response = await get(
      'statistics/',
      queryParameters: from != null && to != null
          ? {
              'from': DateFormat('yyyy-MM-dd').format(from),
              'to': DateFormat('yyyy-MM-dd').format(to),
            }
          : {},
    );

    if (response.statusCode == 200) {
      return OverviewStatisticsDto.fromJson(response.data);
    }

    throw Exception('Could not fetch Statistics');
  }

  Future<String> uploadFile({
    required List<int> file,
    required String name,
  }) async {
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromBytes(
        file,
        filename: name,
      ),
    });

    Response response = await post(
      'upload-file/',
      isMultiform: true,
      body: formData,
    );

    if (response.statusCode == 201) {
      return response.data['url'];
    }

    throw Exception('Could not upload file');
  }
}
