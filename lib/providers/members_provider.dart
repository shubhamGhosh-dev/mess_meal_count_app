import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_count/models/member_model.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import '../models/query.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

Future<sql.Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();

  final sql.Database database = await sql.openDatabase(
    path.join(dbPath, 'meal_count.db'),
    onCreate: (db, version) async {
      await db.execute(createTableSQL);
      await db.execute(insertMembersSQL);
    },
    version: 1,
  );
  return database;
}

class MembersNofifier extends StateNotifier<List<MemberModel>> {
  MembersNofifier() : super(const []);

  Future<void> getAllMembers() async {
    final database = await _getDatabase();
    final data = await database.query('members');
    final members = data
        .map((e) => MemberModel(
              id: e["id"] as String,
              name: e['name'] as String,
              day: e['day'] == 0 ? false : true,
              night: e['night'] == 0 ? false : true,
            ))
        .toList();

    state = members;
  }

  void updateMealStatus({required String id, required bool day, required bool night}) async {
    String query = getMealStatusSQL(id: id, day: day, night: night);
    final database = await _getDatabase();

    await database.execute(query);

    await getAllMembers();
  }

  List<MealCount> calculateMealCount() {
    List<MemberModel> latestData = state;

    int dayCount = 0;
    int nightCount = 0;

    String dayMealOffNames = '';
    String nightMealOffNames = '';

    for (int i = 0; i < latestData.length; i++) {
      latestData[i].day
          ? dayCount = dayCount + 1
          : dayMealOffNames = '$dayMealOffNames${latestData[i].name}, ';
      latestData[i].night
          ? nightCount = nightCount + 1
          : nightMealOffNames = '$nightMealOffNames${latestData[i].name}, ';
    }

    return [
      MealCount(count: dayCount, names: dayMealOffNames),
      MealCount(count: nightCount, names: nightMealOffNames)
    ];
  }

  Future<String> copyMealCount() async {
    final mealCounts = calculateMealCount();

    int dayCount = mealCounts[0].count;
    int nightCount = mealCounts[1].count;

    String dayMealOffNames = mealCounts[0].names;
    String nightMealOffNames = mealCounts[1].names;

    String mealCountText = '';

    mealCountText =
        "Night - $nightCount\n($nightMealOffNames)\n\nDay - $dayCount\n($dayMealOffNames)";

    Clipboard.setData(ClipboardData(text: mealCountText));

    return mealCountText;
  }

  void insertMember(String name) async {
    if (name.isEmpty) {
      return;
    }

    final database = await _getDatabase();

    MemberModel newMember = MemberModel(
      id: uuid.v4().replaceAll(RegExp(r'-'), ''),
      name: name,
      day: false,
      night: false,
    );

    await database.insert("members", {
      "id": newMember.id,
      "name": newMember.name,
      "day": 0,
      "night": 0,
    });

    state = [
      ...state,
      newMember,
    ];
  }

  void deleteMember(String id) async {
    final database = await _getDatabase();

    await database.delete("members", where: "id = ?", whereArgs: [id]);

    await getAllMembers();
  }
}

final memberProvider = StateNotifierProvider<MembersNofifier, List<MemberModel>>((ref) {
  return MembersNofifier();
});
