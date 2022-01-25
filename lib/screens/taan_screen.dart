import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musi_doc/components/components.dart';
import 'package:musi_doc/models/notes_screen_state_manager.dart';

class TaanScreen extends ConsumerStatefulWidget {
  const TaanScreen({Key? key}) : super(key: key);

  @override
  _TaanScreenState createState() => _TaanScreenState();
}

class _TaanScreenState extends ConsumerState<TaanScreen> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  int selectedTaan = 1;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final appStateNotifier = ref.watch(appStateProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              appStateNotifier.listOfTaans.length,
              (index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 40,
                  width: 57,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedTaan = index;
                      });
                    },
                    child: Text((index + 1).toString()),
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Select Tempo Here'),
              IconButton(onPressed: () {}, icon: const Icon(Icons.play_circle_outline)),
              BottomOptions(
                boxBlurRadius: 10,
                dropDownValue: 1,
                listOfDropDownValues: [1, 2, 3, 4, 5],
                onDropdownChange: (_) {},
                onMinusTap: () {},
                onPlusTap: () {},
              )
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
            child: Card(
              elevation: 10,
              child: buildTaanRow(selectedTaan, appStateNotifier),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTaanRow(int taanNumber, NotesScreenStateManager appStateNotifier) {
    List<Widget> notesWidgets = List.generate(
      appStateNotifier.listOfTaans[taanNumber].length,
      (index) {
        Widget circleButton = Padding(
          padding: const EdgeInsets.only(top: 8, left: 4),
          child: InkResponse(
            radius: 30,
            child: CircleButton(
              radius: 40,
              color: Colors.grey[300]!,
              text: appStateNotifier.listOfTaans[taanNumber][index],
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
                              appStateNotifier.listOfTaans[taanNumber][index] = '';
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
                            appStateNotifier.listOfTaans[taanNumber][index] = appStateNotifier.notes[pickerIndex];
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

        return circleButton;
      },
    );

    int count = -1;
    for (var indexToInsertVibhaag in appStateNotifier.vibhagas) {
      count += (indexToInsertVibhaag + 1);
      if (count > notesWidgets.length) break;

      notesWidgets.insert(
          count,
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Container(color: Colors.black45, height: 50, width: 2),
          ));
    }
    return Wrap(children: notesWidgets);
  }
}
