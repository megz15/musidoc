import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musi_doc/components/bottom_options.dart';
import 'package:musi_doc/models/notes_screen_state_manager.dart';
import 'screens.dart';

class NotesScreen extends ConsumerWidget {
  NotesScreen({Key? key}) : super(key: key);

  final List<Widget> _pages = [
    AlapScreen(),
    SthayiScreen(),
    TaanScreen(),
    Container(color: Colors.yellow),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStateNotifier = ref.watch(appStateProvider);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('MusiDoc'),
          actions: [
            if (appStateNotifier.selectedTab == 0)
              BottomOptions(
                dropDownValue: appStateNotifier.dropDownValue,
                onDropdownChange: (newValue) =>
                    appStateNotifier.changeDropdownValue(newValue),
                onMinusTap: () => appStateNotifier.changeAlapNotes("rem"),
                onPlusTap: () => appStateNotifier.changeAlapNotes("add"),
              )
            else
              BottomOptions(
                dropDownValue: appStateNotifier.dropDownValue,
                listOfDropDownValues: const [1, 2, 3, 4, 5],
                onDropdownChange: (newValue) =>
                    appStateNotifier.changeDropdownValue(newValue),
                onMinusTap: () {
                  appStateNotifier.changeNotes("rem", appStateNotifier.selectedTab);
                },
                onPlusTap: () => appStateNotifier.changeNotes("add", appStateNotifier.selectedTab),
              )
          ],
          bottom: TabBar(
            onTap: appStateNotifier.onTapNavBar,
            tabs: const [
              Tab(text: 'Alap'),
              Tab(text: 'Sthayi'),
              Tab(text: 'Taan'),
              Tab(text: 'Jhala'),
            ],
          ),
        ),
        body: _pages[appStateNotifier.selectedTab],
      ),
    );
  }
}
