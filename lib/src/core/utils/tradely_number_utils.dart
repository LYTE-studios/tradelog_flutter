class TradelyNumberUtils {
  static String formatValuta(double value) {
    return value.toStringAsFixed(2).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }

  static String formatNullableValuta(
    double? value, {
    bool showCurrency = true,
  }) {
    if (value == null) {
      return '-';
    }

    return "${value < 0 ? "- " : ""}${showCurrency ? "\$" : ""}${value.abs().toStringAsFixed(2).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        )}";
  }
}
