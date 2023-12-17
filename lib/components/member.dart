import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_count/providers/members_provider.dart';

class Member extends ConsumerStatefulWidget {
  const Member(
      {super.key,
      required this.id,
      required this.name,
      required this.day,
      required this.night,
      required this.index});

  final String id;
  final String name;
  final bool day;
  final bool night;
  final int index;

  @override
  ConsumerState<Member> createState() => _MemberState();
}

class _MemberState extends ConsumerState<Member> {
  late List<bool> _selectedPeriod;

  @override
  void initState() {
    _selectedPeriod = <bool>[widget.night, widget.day];

    super.initState();
  }

  void onPeriodSelect(int index) {
    if (index == 0) {
      ref.read(memberProvider.notifier).updateMealStatus(
            id: widget.id,
            day: widget.day,
            night: !widget.night,
          );
    } else {
      ref.read(memberProvider.notifier).updateMealStatus(
            id: widget.id,
            day: !widget.day,
            night: widget.night,
          );
    }

    setState(() {
      _selectedPeriod[index] = !_selectedPeriod[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "${widget.index + 1}) ${widget.name}",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        ToggleButtons(
          onPressed: onPeriodSelect,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          selectedBorderColor: Colors.green[700],
          selectedColor: Colors.white,
          fillColor: Colors.green[200],
          color: Colors.green[400],
          constraints: const BoxConstraints(
            minHeight: 40.0,
            minWidth: 60.0,
          ),
          isSelected: _selectedPeriod,
          children: const <Widget>[
            Text("Night"),
            Text("Day"),
          ],
        )
      ],
    );
  }
}
