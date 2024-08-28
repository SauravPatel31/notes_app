import 'package:flutter/material.dart';
import 'package:notes_app/DBProvider.dart';
import 'package:notes_app/data/dbhelper.dart';
import 'package:notes_app/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>DBProvider(dbhelper: Dbhelper.getInstance()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Notes',
        darkTheme: ThemeData.dark(useMaterial3: true),
        home: HomePage(),
      ),
    );
  }
}

