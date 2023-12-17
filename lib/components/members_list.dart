import 'package:flutter/material.dart';
import 'package:meal_count/components/member.dart';
import 'package:meal_count/models/member_model.dart';

class MembersList extends StatelessWidget {
  const MembersList({super.key, required this.members});

  final List<MemberModel> members;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView.builder(
          itemCount: members.length,
          itemBuilder: (context, index) {
            return Member(
              id: members[index].id,
              name: members[index].name,
              day: members[index].day,
              night: members[index].night,
              index: index,
            );
          },
        ),
      ),
    );
  }
}
