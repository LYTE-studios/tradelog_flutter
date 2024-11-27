import 'package:tradelog_client/tradelog_client.dart';
import 'package:tradelog_flutter/src/core/data/client.dart';

class TradelyApiManager {
  bool isInitialized = false;

  bool loadingTrades = false;

  List<TradeDto> trades = [];

  TradelyApiManager();

  void initialize() {
    if (isInitialized) {
      return;
    }

    isInitialized = true;

    loadCachedTrades();
    loadCachedAccounts();
  }

  Future<List<TradeDto>> loadCachedTrades() async {
    Future<void> load() async {
      loadingTrades = true;

      trades = await client.global.getTrades();

      loadingTrades = false;
    }

    if (loadingTrades == true) {
      return trades;
    }

    if (trades.isEmpty) {
      await load();

      return trades;
    }

    load();

    return trades;
  }

  Future<List<LinkedAccountDto>> loadCachedAccounts() async {
    return await client.account.fetchAccounts();
  }
}
