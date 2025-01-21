class TradelyDateTimeUtils {
  static String toReadableTime(
    DateTime? dateTime,
    bool passDate,
  ) {
    if (dateTime == null) {
      return '-';
    }

    return '${passDate ? '${dateTime.day}/${dateTime.month}/${dateTime.year} ' : ''}${dateTime.hour < 10 ? "0" : ""}${dateTime.hour}:${dateTime.minute < 10 ? "0" : ""}${dateTime.minute}';
  }
}
