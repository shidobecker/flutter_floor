import 'package:floor/floor.dart';

@entity
class Person {
  @primaryKey
  final String id;

  final String name;

  Person(this.id, this.name);

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
