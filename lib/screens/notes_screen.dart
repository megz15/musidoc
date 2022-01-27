import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
        appBar: AppBar(title: const Text('MusiDoc')),
        drawer: Drawer(
          child: Column(
            children: [
              ListView(
                children: [
                  ListTile(leading: Icon(Icons.looks_one), title: Text('Alap'), onTap: (){
                    Navigator.pop(context);
                    appStateNotifier.onTapDrawer(0);
                  },),
                  ListTile(leading: Icon(Icons.looks_two), title: Text('Sthayi'), onTap: (){
                    Navigator.pop(context);
                    appStateNotifier.onTapDrawer(1);
                  },),
                  ListTile(leading: Icon(Icons.looks_3), title: Text('Taan'), onTap: (){
                    Navigator.pop(context);
                    appStateNotifier.onTapDrawer(2);
                  },),
                  ListTile(leading: Icon(Icons.looks_4), title: Text('Jhala'), onTap: (){
                    Navigator.pop(context);
                    appStateNotifier.onTapDrawer(3);
                  },),
                ],
              ),
              Expanded(child: Container()),
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Drawer Footer',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              )
            ],
          ),
        ),
        body: _pages[appStateNotifier.selectedTab],
      ),
    );
  }
}
