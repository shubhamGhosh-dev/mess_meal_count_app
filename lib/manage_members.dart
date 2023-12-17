import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_count/components/add_member_modal.dart';
import 'package:meal_count/components/member_item.dart';
import 'package:meal_count/providers/members_provider.dart';

class ManageMembers extends ConsumerWidget {
  const ManageMembers({Key? key}) : super(key: key);

  void _onAddBtnPress(context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return const AddMemberModal();
        },
        shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.zero)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final membersList = ref.watch(memberProvider);

    return Scaffold(
        appBar: AppBar(
          title: Text("Mess Members (${membersList.length})"),
          actions: [
            IconButton(
              onPressed: () {
                _onAddBtnPress(context);
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: membersList.length,
          itemBuilder: (context, index) {
            return MemberItem(
              member: membersList[index],
              index: index,
            );
          },
        ));
  }
}
