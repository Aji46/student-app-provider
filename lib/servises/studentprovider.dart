import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:testt2/models/model.dart';

class PersonProvider extends ChangeNotifier {
  late Box<Person> _personBox;

  PersonProvider() {
    _personBox = Hive.box<Person>('people');
  }

  List<Person> get peopleList {
    return _personBox.values.toList();
  }

  void addPerson(Person person) {
    _personBox.add(person);
    notifyListeners();
  }

  void deletePerson(int index) {
    _personBox.deleteAt(index);
    notifyListeners();
  }

  void updatePerson(int index, Person updatedPerson) {
    _personBox.putAt(index, updatedPerson);
    notifyListeners();
  }
}
