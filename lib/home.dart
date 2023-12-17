import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_count/components/members_list.dart';
import 'package:meal_count/components/side_drawer.dart';
import 'package:meal_count/models/member_model.dart';
import 'package:meal_count/providers/members_provider.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  late Future<void> _memberFuture;

  @override
  void initState() {
    super.initState();
    _memberFuture = ref.read(memberProvider.notifier).getAllMembers();
  }

  void _copyToClipboard() async {
    await ref.read(memberProvider.notifier).copyMealCount();
  }

  @override
  Widget build(BuildContext context) {
    final List<MemberModel> messMembers = ref.watch(memberProvider);
    final List<MealCount> mealCounts = ref.read(memberProvider.notifier).calculateMealCount();

    return Scaffold(
      drawer: const SideDrawer(),
      appBar: AppBar(
        title: const Text("Mess Meal Count"),
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: _memberFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return MembersList(members: messMembers);
              }
            },
          ),
          Container(
            padding: const EdgeInsets.only(top: 7, bottom: 5),
            decoration: const BoxDecoration(color: Color.fromARGB(255, 107, 188, 255)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton.icon(
                  onPressed: _copyToClipboard,
                  icon: const Icon(
                    Icons.copy,
                    color: Colors.white,
                  ),
                  label: const Text(
                    "Copy Meal Count",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(Colors.blue),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Day - ${mealCounts[0].count}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "Night - ${mealCounts[1].count}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
