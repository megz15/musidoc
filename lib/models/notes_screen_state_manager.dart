import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotesScreenStateManager extends ChangeNotifier {
  //GLobal
  int _selectedTab = 0;
  int _dropDownValue = 5;

  int get selectedTab => _selectedTab;
  int get dropDownValue => _dropDownValue;

  List<String> _notes = ['S', 'Rb', 'R', 'Gb', 'G', 'M', 'M#', 'P', 'Db', 'D', 'Nb', 'N'];
  List<String> get notes => _notes;

  int _totalBeats = 16;
  List<int> _vibhagas = [4, 4, 4, 4];
  List<int> _khalis = [2];

  int get totalBeats => _totalBeats;
  List<int> get vibhagas => _vibhagas;
  List<int> get khalis => _khalis;

  NotesScreenStateManager() {
    //_listOfSthayiNotes = [];
    _listOfSthayiNotes.add(List.filled(totalBeats, ''));
    _listOfSthayiNotes.add(List.filled(totalBeats, ''));

    _listOfTaans.add(List.filled(totalBeats, ''));
    _listOfTaans.add(List.filled(totalBeats, ''));
  }

  //Alap
  List<String> _listOfAlapNotes = List.filled(20, '', growable: true);
  List<int> _listOfAlapSeparationIndices = [];

  List<String> get listOfAlapNotes => _listOfAlapNotes;
  List<int> get listOfAlapSeparationIndices => _listOfAlapSeparationIndices;

  //Sthayi
  List<List<String>> _listOfSthayiNotes = [];
  List<List<String>> get listOfSthayiNotes => _listOfSthayiNotes;

  //Taan
  List<List<String>> _listOfTaans = [];
  List<List<String>> get listOfTaans => _listOfTaans;

  void changeAlapNotes(String addOrRem) {
    switch (addOrRem) {
      case "add":
        _listOfAlapNotes.addAll(List.filled(_dropDownValue, ''));
        break;
      case "rem":
        _listOfAlapNotes.length < _dropDownValue ? _listOfAlapNotes.clear() : _listOfAlapNotes.removeRange(_listOfAlapNotes.length - _dropDownValue, _listOfAlapNotes.length);
        _listOfAlapSeparationIndices.removeWhere((element) => element > (_listOfAlapNotes.length - _dropDownValue));
        break;
    }
    notifyListeners();
  }

  void changeNotes(String addOrRem, int tab) {
    var notes = [];
    switch (tab) {
      case 1: notes = _listOfSthayiNotes; break;
      case 2: notes = _listOfTaans; break;
    }
    switch (addOrRem) {
      case "add":
        /*_listOfSthayiNotes
            .addAll(List.filled(_dropDownValue, List.filled(totalBeats, '')));*/
        for (var i = 0; i < _dropDownValue; i++) {
          notes.add(List.filled(totalBeats, ''));
        }
        break;
      case "rem":
        if (notes.length < _dropDownValue) {
          notes.clear();
        } else {
          notes.removeRange(notes.length - _dropDownValue, notes.length);
        }
        break;
    }
    notifyListeners();
  }

  void changeDropdownValue(String? newValue) {
    _dropDownValue = int.parse(newValue ?? '5');
    notifyListeners();
  }

  void onTapNavBar(int index) {
    _selectedTab = index;
    _dropDownValue = 5;
    notifyListeners();
  }
}

final appStateProvider = ChangeNotifierProvider<NotesScreenStateManager>((ref) => NotesScreenStateManager());
