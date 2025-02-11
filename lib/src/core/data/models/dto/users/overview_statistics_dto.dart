import 'dart:math';

class OverviewStatisticsDto {
  final OverallStatisticsDto overallStatistics;
  final List<SymbolPerformanceDto> symbolPerformances;
  final List<MonthlySummaryDto> monthlySummaries;
  final WeekDistributionDto weekDistribution;
  final SessionDistributionDto sessionDistribution;
  final Map<String, DayPerformanceDto> dayPerformances;

  const OverviewStatisticsDto({
    required this.overallStatistics,
    required this.symbolPerformances,
    required this.monthlySummaries,
    required this.weekDistribution,
    required this.sessionDistribution,
    required this.dayPerformances,
  });

  double? getBestMonthProfit() {
    double? bestMonthProfit;

    for (MonthlySummaryDto summaryDto in monthlySummaries) {
      bestMonthProfit ??= summaryDto.totalProfit;
      if (summaryDto.totalProfit > bestMonthProfit) {
        bestMonthProfit = summaryDto.totalProfit;
      }
    }

    return bestMonthProfit;
  }

  double? getWorstMonthProfit() {
    double? bestMonthProfit;

    for (MonthlySummaryDto summaryDto in monthlySummaries) {
      bestMonthProfit ??= summaryDto.totalProfit;
      if (summaryDto.totalProfit < bestMonthProfit) {
        bestMonthProfit = summaryDto.totalProfit;
      }
    }

    return bestMonthProfit;
  }

  double? getAverageMonthProfit() {
    if (monthlySummaries.isEmpty) {
      return null;
    }

    double total = 0;

    for (MonthlySummaryDto summaryDto in monthlySummaries) {
      total += summaryDto.totalProfit;
    }

    return total / monthlySummaries.length;
  }

  static Map<String, double> getDefaultSymbolChartMap() {
    return {
      " ": 0,
      "  ": 0,
      "   ": 0,
    };
  }

  Map<String, double> toSymbolChartMap() {
    if (symbolPerformances.isEmpty) {
      return OverviewStatisticsDto.getDefaultSymbolChartMap();
    }
    double highestValue =
        symbolPerformances.map((e) => e.totalTrades).reduce(max).toDouble();

    if (highestValue == 0) {
      return OverviewStatisticsDto.getDefaultSymbolChartMap();
    }

    Map<String, double> map = Map.fromEntries(
      symbolPerformances.map(
        (SymbolPerformanceDto symbol) => MapEntry(
          symbol.symbol,
          symbol.totalTrades.toDouble(),
        ),
      ),
    );

    if (map.length > 7) {
      List<String> keys = map.keys.toList();

      keys.sort((a, b) => map[b]!.compareTo(map[a]!));

      for (int i = 1; i < map.length - 6; i++) {
        map.remove(keys[map.length - i]);
      }
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
        weekDistribution = WeekDistributionDto.fromJson(
          (json['day_of_week_analysis'] ?? {})['distribution'] ?? {},
        ),
        sessionDistribution = SessionDistributionDto.fromJson(
          (json['session_analysis'] ?? {})['distribution'] ?? {},
        ),
        dayPerformances =
            ((json['day_performances'] ?? {}) as Map<String, dynamic>)
                .map((key, value) => MapEntry<String, DayPerformanceDto>(
                      key,
                      DayPerformanceDto.fromJson(value as Map<String, dynamic>),
                    ));
}

class DayPerformanceDto {
  final int? totalTrades;
  final double? totalProfit;
  final double? totalWon;
  final double? totalLoss;
  final double? totalInvested;

  const DayPerformanceDto({
    required this.totalTrades,
    required this.totalProfit,
    required this.totalWon,
    required this.totalLoss,
    required this.totalInvested,
  });

  DayPerformanceDto.fromJson(Map<String, dynamic> json)
      : totalLoss = json['total_loss'] as double?,
        totalWon = json['total_won'] as double?,
        totalProfit = json['total_profit'] as double?,
        totalTrades = json['total_trades'] as int?,
        totalInvested = json['total_invested'] as double?;
}

class WeekDistributionDto {
  final double? monday;
  final double? tuesday;
  final double? wednesday;
  final double? thursday;
  final double? friday;
  final double? saturday;
  final double? sunday;

  const WeekDistributionDto({
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
    required this.sunday,
  });

  Map<String, double> toJson() {
    return {
      'Monday': monday ?? 0,
      'Tuesday': tuesday ?? 0,
      'Wednesday': wednesday ?? 0,
      'Thursday': thursday ?? 0,
      'Friday': friday ?? 0,
      'Saturday': saturday ?? 0,
      'Sunday': sunday ?? 0,
    };
  }

  WeekDistributionDto.fromJson(Map<String, dynamic> json)
      : monday = json['Monday'] as double?,
        tuesday = json['Tuesday'] as double?,
        wednesday = json['Wednesday'] as double?,
        thursday = json['Thursday'] as double?,
        friday = json['Friday'] as double?,
        saturday = json['Saturday'] as double?,
        sunday = json['Sunday'] as double?;
}

class SessionDistributionDto {
  final double? london;
  final double? asia;
  final double? pacific;
  final double? newYork;

  const SessionDistributionDto({
    required this.london,
    required this.asia,
    required this.pacific,
    required this.newYork,
  });

  Map<String, double> toJson() {
    return {
      'London': london ?? 0,
      'New York': newYork ?? 0,
      'Asia': asia ?? 0,
      'Pacific': pacific ?? 0,
    };
  }

  SessionDistributionDto.fromJson(Map<String, dynamic> json)
      : london = json['london'] as double?,
        asia = json['asia'] as double?,
        pacific = json['pacific'] as double?,
        newYork = json['new-york'] as double?;
}

class OverallStatisticsDto {
  final double balance;

  final int totalTrades;

  final double totalProfit;

  final double totalInvested;

  final double winRate;

  final int long;

  final int short;

  final double bestWin;

  final double worstLoss;

  final double averageWin;

  final double averageLoss;

  final double profitFactor;

  final double totalWon;
  final double totalLost;

  final int breakEvenTrades;

  final int winningDays;
  final int losingDays;
  final int breakEvenDays;

  final double holdingTimeMinutes;

  final double maxDrawdown;
  final double maxDrawdownPercent;
  final double averageDrawdown;
  final double averageDrawdownPercent;

  const OverallStatisticsDto({
    required this.balance,
    required this.totalTrades,
    required this.totalProfit,
    required this.totalInvested,
    required this.winRate,
    required this.long,
    required this.short,
    required this.bestWin,
    required this.worstLoss,
    required this.averageWin,
    required this.averageLoss,
    required this.profitFactor,
    required this.totalWon,
    required this.totalLost,
    required this.holdingTimeMinutes,
    required this.maxDrawdown,
    required this.maxDrawdownPercent,
    required this.averageDrawdown,
    required this.averageDrawdownPercent,
    required this.breakEvenTrades,
    required this.winningDays,
    required this.losingDays,
    required this.breakEvenDays,
  });

  OverallStatisticsDto.fromJson(Map<String, dynamic> json)
      : balance = json['balance'],
        totalTrades = json['total_trades'],
        totalProfit = json['total_profit'],
        totalInvested = json['total_invested'],
        winRate = json['win_rate'],
        long = json['long'],
        short = json['short'],
        bestWin = json['best_win'],
        worstLoss = json['worst_loss'],
        averageWin = json['average_win'],
        averageLoss = json['average_loss'],
        profitFactor = json['profit_factor'],
        totalWon = json['total_won'],
        totalLost = json['total_lost'],
        holdingTimeMinutes = json['average_holding_time_minutes'],
        maxDrawdown = json['max_drawdown'],
        maxDrawdownPercent = json['max_drawdown_percent'],
        averageDrawdown = json['average_drawdown'],
        averageDrawdownPercent = json['average_drawdown_percent'],
        breakEvenTrades = json['breakeven_trades'],
        winningDays = json['winning_days'],
        losingDays = json['losing_days'],
        breakEvenDays = json['breakeven_days'];
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
