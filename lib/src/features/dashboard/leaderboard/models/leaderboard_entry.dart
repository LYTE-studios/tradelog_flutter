// import 'dart:ffi';

// import 'package:intl/intl.dart';

class LeaderboardEntry {
  final String name;
  final int rank;
  final int points;

  LeaderboardEntry({
    required this.name,
    required this.rank,
    required this.points,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LeaderboardEntry &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          rank == other.rank;

  @override
  int get hashCode => name.hashCode ^ rank.hashCode;
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

  LeaderboardTradeActivity({
    required this.name,
    required this.currencyPair,
    required this.exchangeRate,
    required this.moment,
  });
}
