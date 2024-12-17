import 'dart:math';

class OverviewStatisticsDto {
  final OverallStatisticsDto overallStatistics;
  final List<SymbolPerformanceDto> symbolPerformances;
  final List<MonthlySummaryDto> monthlySummaries;
  final Map<String, double> weekDistribution;

  const OverviewStatisticsDto({
    required this.overallStatistics,
    required this.symbolPerformances,
    required this.monthlySummaries,
    required this.weekDistribution,
  });

  static Map<String, double> getDefaultSymbolChartMap() {
    return {
      " ": 0,
      "  ": 0,
      "   ": 0,
    };
  }

  Map<String, double> toSymbolChartMap() {
    double highestValue =
        symbolPerformances.map((e) => e.totalTrades).reduce(max).toDouble();

    if (highestValue == 0) {
      return OverviewStatisticsDto.getDefaultSymbolChartMap();
    }

    Map<String, double> map = Map.fromEntries(
      symbolPerformances.map(
        (SymbolPerformanceDto symbol) => MapEntry(
          symbol.symbol,
          symbol.totalTrades.toDouble() / highestValue,
        ),
      ),
    );

    void removeSmallest() {
      MapEntry<String, double>? minEntry;

      for (MapEntry<String, double> entry in map.entries) {
        if (minEntry == null || minEntry.value > entry.value) {
          minEntry = entry;
        }
      }

      map.remove(minEntry?.key);
    }

    while (map.length > 7) {
      removeSmallest();
    }

    if (map.length < 5) {
      map.addAll(OverviewStatisticsDto.getDefaultSymbolChartMap());
    }

    return map;
  }

  OverviewStatisticsDto.fromJson(Map<String, dynamic> json)
      : overallStatistics =
            OverallStatisticsDto.fromJson(json['overall_statistics']),
        symbolPerformances = (json['symbol_performances'] as List)
            .map((performance) => SymbolPerformanceDto.fromJson(performance))
            .toList(),
        monthlySummaries = (json['monthly_summary'] as List)
            .map((summary) => MonthlySummaryDto.fromJson(summary))
            .toList(),
        weekDistribution = (json['day_of_week_analysis']['distribution'] as Map)
            .map((key, value) => MapEntry(key as String, value as double));
}

class OverallStatisticsDto {
  final int totalTrades;

  final double totalProfit;

  final double totalInvested;

  final double winRate;

  const OverallStatisticsDto({
    required this.totalTrades,
    required this.totalProfit,
    required this.totalInvested,
    required this.winRate,
  });

  OverallStatisticsDto.fromJson(Map<String, dynamic> json)
      : totalTrades = json['total_trades'],
        totalProfit = json['total_profit'],
        totalInvested = json['total_invested'],
        winRate = json['win_rate'];
}

class MonthlySummaryDto {
  final int totalTrades;
  final double totalProfit;
  final double totalInvested;

  const MonthlySummaryDto({
    required this.totalTrades,
    required this.totalProfit,
    required this.totalInvested,
  });

  MonthlySummaryDto.fromJson(Map<String, dynamic> json)
      : totalTrades = json['total_trades'],
        totalProfit = json['total_profit'],
        totalInvested = json['total_invested'];
}

class SymbolPerformanceDto {
  final String symbol;

  final int totalTrades;
  final double totalProfit;
  final double totalInvested;

  const SymbolPerformanceDto({
    required this.symbol,
    required this.totalTrades,
    required this.totalProfit,
    required this.totalInvested,
  });

  SymbolPerformanceDto.fromJson(Map<String, dynamic> json)
      : symbol = json['symbol'],
        totalTrades = json['total_trades'],
        totalProfit = json['total_profit'],
        totalInvested = json['total_invested'];
}
