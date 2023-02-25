import 'package:hive/hive.dart';
part 'todo.g.dart';

@HiveType(typeId: 0)
class listModel {
  
  @HiveField(0)
  String text;

  @HiveField(1)
  bool isChecked;

  listModel({
    required this.text,
    this.isChecked = false,
  });

  
}
