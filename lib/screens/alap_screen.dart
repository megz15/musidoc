import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musi_doc/components/components.dart';
import 'package:musi_doc/models/notes_screen_state_manager.dart';

class AlapScreen extends ConsumerStatefulWidget {
  const AlapScreen({Key? key}) : super(key: key);

  @override
  _AlapScreenState createState() => _AlapScreenState();
}

class _AlapScreenState extends ConsumerState<AlapScreen>
    with AutomaticKeepAliveClientMixin {

  /*int dropDownValue = 5;
  List<String> listOfAlapNotes = List.filled(20, '', growable: true);
  List<int> listOfAlapSeparationIndices = [];*/

  //double width = MediaQuery.of(context).size.width;
  //Offset bottomBarPosition = const Offset(20, 20);

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final appStateNotifier = ref.watch(appStateProvider);

    List<Widget> notesWidgets = List.generate(
      appStateNotifier.listOfAlapNotes.length,
      (index) => Padding(
        padding: const EdgeInsets.only(top: 8, left: 4),
        child: InkResponse(
          radius: 30,
          child: CircleButton(
            radius: 40,
            color: Colors.grey[300]!,
            text: appStateNotifier.listOfAlapNotes[index],
          ),
          onLongPress: () {
            showDialog(
                context: context,
                builder: (BuildContext buildContext) {
                  return SimpleDialog(title: const Text('Note Options'), children: [
                    SimpleDialogOption(
                        child: const Text('Play from here'), onPressed: () {}),
                    SimpleDialogOption(
                        child: const Text('Clear note'),
                        onPressed: () {
                          setState(() {
                            appStateNotifier.listOfAlapNotes[index] = '';
                            Navigator.pop(buildContext);
                          });
                        }),
                    SimpleDialogOption(
                        child: const Text('Make Seperator'),
                        onPressed: () {
                          setState(() {
                            appStateNotifier.listOfAlapSeparationIndices.add(index);
                            Navigator.pop(buildContext);
                          });
                        }),
                  ]);
                });
          },
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext buildContext) => CirclePicker(
                radius: 220,
                widgets: List.generate(
                  12,
                  (pickerIndex) => InkResponse(
                    radius: 30,
                    child: CircleButton(
                      radius: 55,
                      color: Colors.grey[200]!,
                      text: appStateNotifier.notes[pickerIndex],
                    ),
                    onTap: () {
                      setState(() {
                        appStateNotifier.listOfAlapNotes[index] = appStateNotifier.notes[pickerIndex];
                        Navigator.pop(buildContext);
                      });
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );

    for (var indexToInsertSeparator in appStateNotifier.listOfAlapSeparationIndices) {
      if (indexToInsertSeparator < appStateNotifier.listOfAlapNotes.length) {
        notesWidgets.insert(
          indexToInsertSeparator,
          Row(
            children: [
              Expanded(child: Container()),
            ],
          ),
        );
      }
    }

    return Scrollbar(
      child: Padding(
        padding: const EdgeInsets.only(right: 4),
        child: SingleChildScrollView(
          child: Wrap(
            children: notesWidgets,
          ),
        ),
      ),
    );
  }
}
