import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musi_doc/components/components.dart';
import 'package:musi_doc/models/notes_screen_state_manager.dart';

class SthayiScreen extends ConsumerStatefulWidget {
  const SthayiScreen({Key? key}) : super(key: key);

  @override
  _SthayiScreenState createState() => _SthayiScreenState();
}

class _SthayiScreenState extends ConsumerState<SthayiScreen> {
  int dropDownValue = 5;
  Offset bottomBarPosition = const Offset(20, 70);

  @override
  Widget build(BuildContext context) {
    final appStateNotifier = ref.watch(appStateProvider);

    List<List<Widget>> notesWidgets = List.generate(
      appStateNotifier.listOfSthayiNotes.length,
      (avartanIndex) => List.generate(
        appStateNotifier.listOfSthayiNotes.first.length,
        (index) {
          Widget circleButton = Padding(
            padding: const EdgeInsets.only(top: 8, left: 4),
            child: InkResponse(
              radius: 30,
              child: CircleButton(
                radius: 40,
                color: Colors.grey[300]!,
                text: appStateNotifier.listOfSthayiNotes[avartanIndex][index],
              ),
              onLongPress: () {
                showDialog(
                    context: context,
                    builder: (BuildContext buildContext) {
                      return SimpleDialog(
                          title: const Text('Note Options'),
                          children: [
                            SimpleDialogOption(
                                child: const Text('Play from here'),
                                onPressed: () {}),
                            SimpleDialogOption(
                                child: const Text('Clear note'),
                                onPressed: () {
                                  setState(() {
                                    appStateNotifier
                                            .listOfSthayiNotes[avartanIndex]
                                        [index] = '';
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
                          setState(
                            () {
                              appStateNotifier.listOfSthayiNotes[avartanIndex]
                                  [index] = appStateNotifier.notes[pickerIndex];
                              Navigator.pop(buildContext);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          );

          /*return Row(children: <Widget>[Text('1234')] + [
            for (var element in appStateNotifier.vibhagas)
              Row(children: List.generate(element, (index) => circleButton) + [Text('123')])
          ]);*/

          /*if (appStateNotifier.vibhagas.contains(index+1)){
             return Row(
               mainAxisSize: MainAxisSize.min,
                 children: [circleButton,  Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Container(color: Colors.black45, height: 50, width: 2,),
            ),]);
          } else {
            return circleButton;
          }*/
          return circleButton;
        },
      ),
    );

    int count = -1;
    for (var indexToInsertVibhaag in appStateNotifier.vibhagas) {
      count += (indexToInsertVibhaag + 1);
      for (var eachAvartan in notesWidgets) {
        eachAvartan.insert(
          count,
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Container(color: Colors.black45, height: 50, width: 2),
          )
        );
      }
    }

    return Stack(
      children: [
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.only(right: 4),
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Wrap(
                  children: notesWidgets[index],
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemCount: notesWidgets.length,
            ),
          ),
        ),
        Positioned(
          bottom: bottomBarPosition.dy - 50,
          left: bottomBarPosition.dx,
          child: Draggable(
            feedback: Material(child: BottomOptions()),
            childWhenDragging: Opacity(child: BottomOptions(), opacity: 0.3),
            child: BottomOptions(
              dropDownValue: dropDownValue,
              onDropdownChange: (int? changedValue) => setState(() => dropDownValue = changedValue!),
              onPlusTap: () => appStateNotifier.changeNotes('add', 2, dropDownValue),
              onMinusTap: () => appStateNotifier.changeNotes('rem', 2, dropDownValue),
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
