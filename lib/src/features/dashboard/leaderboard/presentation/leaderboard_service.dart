import '../models/leaderboard_entry.dart';

class LeaderboardService {
  static List<LeaderboardEntry> fetchLeaderboard() {
    return [
      LeaderboardEntry(
        name: 'SHENO',
        rank: 1,
        points: 3,
      ),
      LeaderboardEntry(
        name: 'SHENO',
        rank: 2,
        points: 3,
      ),
      LeaderboardEntry(
        name: 'SHENO',
        rank: 3,
        points: 3,
      ),
      LeaderboardEntry(
        name: 'SHENO',
        rank: 4,
        points: -3,
      ),
      LeaderboardEntry(
        name: 'SHENO',
        rank: 5,
        points: 3,
      ),
      LeaderboardEntry(
        name: 'SHENO',
        rank: 6,
        points: 3,
      ),
      LeaderboardEntry(
        name: 'SHENO',
        rank: 7,
        points: -3,
      ),
      LeaderboardEntry(
        name: 'SHENO',
        rank: 8,
        points: 3,
      ),
      LeaderboardEntry(
        name: 'SHENO',
        rank: 9,
        points: 3,
      ),
      LeaderboardEntry(
        name: 'SHENO',
        rank: 10,
        points: 3,
      ),
      LeaderboardEntry(
        name: 'SHENO',
        rank: 11,
        points: 3,
      ),
      LeaderboardEntry(
        name: 'SHENO',
        rank: 12,
        points: 3,
      ),
      LeaderboardEntry(
        name: 'SHENO',
        rank: 13,
        points: -3,
      ),
      LeaderboardEntry(
        name: 'SHENO',
        rank: 14,
        points: 3,
      ),
      LeaderboardEntry(
        name: 'SHENO',
        rank: 15,
        points: 3,
      ),
      LeaderboardEntry(
        name: 'SHENO',
        rank: 16,
        points: 3,
      ),
      LeaderboardEntry(
        name: 'SHENO',
        rank: 17,
        points: 3,
      ),
      // Add more entries as needed
    ];
  }
}

class LeaderboardCurrencyItems {
  static List<LeaderboardCurrency> fetchLeaderboardCurrency() {
    return [
      LeaderboardCurrency(currencyPair: 'GBP/USD', exchangeRate: 234.02),
      LeaderboardCurrency(currencyPair: 'USD/JPY', exchangeRate: -234.02),
      LeaderboardCurrency(currencyPair: 'EUR/USD', exchangeRate: 234.02),
      LeaderboardCurrency(currencyPair: 'AUD/USD', exchangeRate: 234.02),
      LeaderboardCurrency(currencyPair: 'USD/CHF', exchangeRate: -234.02),
      LeaderboardCurrency(currencyPair: 'USD/CAD', exchangeRate: 234.02),
    ];
  }
}

class TradeActivityItems {
  static List<LeaderboardTradeActivity> fetchTradeActivityItems() {
    return [
      LeaderboardTradeActivity(
          name: "Stef",
          currencyPair: "USD/EUR",
          exchangeRate: 234.02,
          moment: 120),
      LeaderboardTradeActivity(
          name: "Stef",
          currencyPair: "USD/EUR",
          exchangeRate: -234.02,
          moment: 120),
      LeaderboardTradeActivity(
          name: "Stef",
          currencyPair: "USD/EUR",
          exchangeRate: 234.02,
          moment: 120),
      LeaderboardTradeActivity(
          name: "Stef",
          currencyPair: "USD/EUR",
          exchangeRate: 234.02,
          moment: 120),
      LeaderboardTradeActivity(
          name: "Stef",
          currencyPair: "USD/EUR",
          exchangeRate: -234.02,
          moment: 120),
      LeaderboardTradeActivity(
          name: "Stef",
          currencyPair: "USD/EUR",
          exchangeRate: 234.02,
          moment: 120),
      LeaderboardTradeActivity(
          name: "Stef",
          currencyPair: "USD/EUR",
          exchangeRate: -234.02,
          moment: 120),
    ];
  }
}
