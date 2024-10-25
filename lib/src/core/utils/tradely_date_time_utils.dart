class TradelyDateTimeUtils {
  static String toReadableTime(DateTime? dateTime) {
    if (dateTime == null) {
      return '';
    }

    return '${dateTime.hour}:${dateTime.minute}:${dateTime.second}';
  }
}
