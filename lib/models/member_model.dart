class MemberModel {
  MemberModel({
    required this.id,
    required this.name,
    required this.day,
    required this.night,
  });

  final String id;
  final String name;
  final bool day;
  final bool night;
}

class MealCount {
  MealCount({required this.count, required this.names});

  final int count;
  final String names;
}
