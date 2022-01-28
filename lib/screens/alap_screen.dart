import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musi_doc/components/components.dart';
import 'package:musi_doc/models/notes_screen_state_manager.dart';

class AlapScreen extends ConsumerStatefulWidget {
  const AlapScreen({Key? key}) : super(key: key);

  @override
  _AlapScreenState createState() => _AlapScreenState();
}

class _AlapScreenState extends ConsumerState<AlapScreen> {
  int dropDownValue = 5;
  Offset bottomBarPosition = const Offset(20, 70);
  /*List<String> listOfAlapNotes = List.filled(20, '', growable: true);
  List<int> listOfAlapSeparationIndices = [];*/

  @override
  Widget build(BuildContext context) {
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
                    SimpleDialogOption(child: const Text('Play from here'), onPressed: () {}),
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

    return Stack(
      children: [
        Positioned.fill(
          child: Scrollbar(
            child: Padding(
              padding: const EdgeInsets.only(right: 4),
              child: SingleChildScrollView(
                child: Wrap(
                  children: notesWidgets,
                ),
              ),
            ),
          ),
        ),
        //Expanded(child: Container(color: Color.fromRGBO(250, 10, 10, 0.3))),
        Positioned(
          bottom: bottomBarPosition.dy - 50,
          left: bottomBarPosition.dx,
          child: Draggable(
            feedback: Material(child: BottomOptions()),
            childWhenDragging: Opacity(child: BottomOptions(), opacity: 0.3),
            child: BottomOptions(
              dropDownValue: dropDownValue,
              listOfDropDownValues: [20, 10, 7, 5, 3, 2, 1],
              onDropdownChange: (int? changedValue) => setState(() => dropDownValue = changedValue!),
              onPlusTap: () => appStateNotifier.changeNotes('add', 1, dropDownValue),
              onMinusTap: () => appStateNotifier.changeNotes('rem', 1, dropDownValue),
            ),
            onDragEnd: (details) {
              setState(() {
                bottomBarPosition = Offset(details.offset.dx, MediaQuery.of(context).size.height - details.offset.dy);
              });
            },
          ),
        )
      ],
    );
  }
}
