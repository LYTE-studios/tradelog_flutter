class TradelyDateTimeUtils {
  static String toReadableTime(
    DateTime? dateTime,
    bool passDate,
  ) {
    if (dateTime == null) {
      return '';
    }

    return '${passDate ? '${dateTime.day}/${dateTime.month}/${dateTime.year} ' : ''}${dateTime.hour}:${dateTime.minute}';
  }
}
