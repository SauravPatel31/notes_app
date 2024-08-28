import 'package:notes_app/data/dbhelper.dart';

class NotesModel{
  int? sno;
  String title,desc;
  NotesModel({this.sno,required this.title,required this.desc});

  ///fromMap to Model
  factory NotesModel.fromMap(Map<String,dynamic> map)=>NotesModel(
        sno: map[Dbhelper.COLUMN_SNO],
        title: map[Dbhelper.COLUMN_TITLE],
        desc: map[Dbhelper.COLUMN_DESC]);

///FromModel to map
 Map<String,dynamic> toMap()=>{
   Dbhelper.COLUMN_TITLE:title,
   Dbhelper.COLUMN_DESC:desc
 };
}

/* factory NotesModel.fromMap(Map<String,dynamic> map){
    return NotesModel(
        sno: map[Dbhelper.COLUMN_SNO],
        title: map[Dbhelper.COLUMN_TITLE],
        desc: map[Dbhelper.COLUMN_DESC]);
  }*/