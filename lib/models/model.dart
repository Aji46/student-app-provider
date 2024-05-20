import 'package:hive/hive.dart';

part 'model.g.dart'; 



@HiveType(typeId: 0)
class Person {
  @HiveField(0)
  late String name;
  @HiveField(1)
  late int age;
  @HiveField(2)
  late String place;
  @HiveField(3)
  late String number; 
  @HiveField(4)
  late String profile; 

  Person({
    required this.name,
    required this.age,
    required this.place,
    required this.number,
    required this.profile,
  });
}


