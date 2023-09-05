import 'package:hive/hive.dart';
part 'money.g.dart';

@HiveType(typeId: 0)
class Money {
  @HiveField(1)
  final int id;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final String date;
  @HiveField(4)
  final String price;
  @HiveField(5)
  final bool isRecived;
  @HiveField(6)
  String toman;

  Money({
    required this.toman,
    required this.id,
    required this.title,
    required this.date,
    required this.price,
    required this.isRecived,
  });
}
