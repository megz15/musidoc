import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotesScreenStateManager extends ChangeNotifier {
  //GLobal
  int _selectedTab = 0;
  int get selectedTab => _selectedTab;

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

  /*void changeAlapNotes(String addOrRem) {
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
  }*/

  void changeNotes(String addOrRem, int tab, int changeBy) {
    var notes = [];
    switch (tab) {
      case 1: notes = _listOfAlapNotes; break;
      case 2: notes = _listOfSthayiNotes; break;
      case 3: notes = _listOfTaans; break;
    }
    switch (addOrRem) {
      case "add":
        /*_listOfSthayiNotes
            .addAll(List.filled(_dropDownValue, List.filled(totalBeats, '')));*/
      if (tab != 1){
        for (var i = 0; i < changeBy; i++) {
          notes.add(List.filled(totalBeats, ''));
        }} else {
        _listOfAlapNotes.addAll(List.filled(changeBy, ''));
      }
        break;
      case "rem":
        if (tab != 1){
        if (notes.length < changeBy) {
          notes.clear();
        } else {
          notes.removeRange(notes.length - changeBy, notes.length);
        }} else {
          _listOfAlapNotes.length < changeBy ? _listOfAlapNotes.clear() : _listOfAlapNotes.removeRange(_listOfAlapNotes.length - changeBy, _listOfAlapNotes.length);
          _listOfAlapSeparationIndices.removeWhere((element) => element > (_listOfAlapNotes.length - changeBy));
        }
        break;
    }
    notifyListeners();
  }

  /*void changeDropdownValue(String? newValue) {
    _dropDownValue = int.parse(newValue ?? '5');
    notifyListeners();
  }*/

  void onTapDrawer(int index) {
    _selectedTab = index;
    notifyListeners();
  }
}

final appStateProvider = ChangeNotifierProvider<NotesScreenStateManager>((ref) => NotesScreenStateManager());
