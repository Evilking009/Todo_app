import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Model/todo.dart';
import 'todo.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'Data/database.dart';

void main() async{

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(listModelAdapter());

  await Hive.openBox('taskbox');

  runApp(
    MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  todoModel db = todoModel();


  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: todoModel.themeNotifier,
      builder: (_, ThemeMode themeMode, __) {
        return MaterialApp(
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: themeMode,
          home: Todo()
          );
      }
    );
  }
}
