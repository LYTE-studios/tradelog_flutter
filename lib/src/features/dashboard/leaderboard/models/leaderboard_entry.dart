// import 'dart:ffi';

// import 'package:intl/intl.dart';

class LeaderboardEntry {
  final String name;
  final int rank;
  final int points;
  final String avatarUrl;

  LeaderboardEntry({
    required this.name,
    required this.rank,
    required this.points,
    required this.avatarUrl,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LeaderboardEntry &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          rank == other.rank &&
          avatarUrl == other.avatarUrl;

  @override
  int get hashCode => name.hashCode ^ rank.hashCode ^ avatarUrl.hashCode;
}

class LeaderboardCurrency {
  final String currencyPair;
  final double exchangeRate;

  LeaderboardCurrency({
    required this.currencyPair,
    required this.exchangeRate,
  });
}

class LeaderboardTradeActivity {
  final String name;
  final String currencyPair;
  final double exchangeRate;
  final int moment;
  final String avatarUrl;

  LeaderboardTradeActivity(
      {required this.name,
      required this.currencyPair,
      required this.exchangeRate,
      required this.moment,
      required this.avatarUrl});
}
