import 'package:flutter/material.dart';
import 'package:todo_app/Model/todo.dart';
import 'package:hive/hive.dart';

class todoModel {

  List myList = [];
  var myBox = Hive.box('taskbox');

  // for theme switch
  bool themeToggle = false;

  // Valuelistner
  static ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.dark);


  void createDummyData(){
    myList = [
       listModel(text: 'Your Task'),
     ];
  }

  void loadDatabase(){

   myList = myBox.get('tasks');

  }

  void updateDatabase(){

   myBox.put('tasks', myList);

  }





}