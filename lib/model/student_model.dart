class Student {
  final String id;
  final String name;
  bool charger = false;
  //a charger will return true if a student
  //has requested one from me after the school year starts

  Student({
    required this.id,
    required this.name,
    required this.charger,
  });
}
