import 'package:intl/intl.dart';

class TradeNoteDto {
  final String note;
  final DateTime date;

  const TradeNoteDto({
    required this.note,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
        'trade_note': note,
        'note_date': DateFormat('yyyy-MM-dd').format(date),
      };

  TradeNoteDto.fromJson(Map<String, dynamic> json)
      : note = (json['trade_note'] as String?) ?? '',
        date = DateFormat('yyyy-MM-dd').parse(json['note_date'] as String);
}
