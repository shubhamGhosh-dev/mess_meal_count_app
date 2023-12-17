import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_count/models/member_model.dart';
import 'package:meal_count/providers/members_provider.dart';

class MemberItem extends ConsumerWidget {
  const MemberItem({super.key, required this.member, required this.index});

  final MemberModel member;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${index + 1}) ${member.name}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          IconButton(
            onPressed: () {
              ref.read(memberProvider.notifier).deleteMember(member.id);
            },
            icon: const Icon(
              Icons.delete,
              color: Color.fromARGB(255, 157, 10, 0),
            ),
          )
        ],
      ),
    );
  }
}
