import 'package:flutter/material.dart';
import 'package:notes_app/DBProvider.dart';
import 'package:notes_app/data/dbhelper.dart';
import 'package:notes_app/notes_model.dart';
import 'package:provider/provider.dart';

class AddEditNotesPage extends StatelessWidget{
  int sno;
  bool isUpdate;
  String title,desc;
  AddEditNotesPage({this.isUpdate=false,this.sno=0,this.title="",this.desc=""});
///Controllers
  TextEditingController titlecontroller =TextEditingController();
  TextEditingController desccontroller =TextEditingController();
  @override
  Widget build(BuildContext context) {
    if(isUpdate){
      titlecontroller.text=title;
      desccontroller.text=desc;
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            InkWell(
              onTap: ()async{
                if(titlecontroller.text.isNotEmpty&&desccontroller.text.isNotEmpty){
                  if(isUpdate){
                    context.read<DBProvider>().updateNotes(NotesModel(title: titlecontroller.text, desc: desccontroller.text), sno);
                    Navigator.pop(context);
                  }
                  else{
                    context.read<DBProvider>().addNotes(NotesModel(title: titlecontroller.text, desc: desccontroller.text));
                    Navigator.pop(context);
                  }

                }


              },
              child: Container(
                margin: EdgeInsets.only(right: 20),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    color: Color(0xff3B3B3B),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Center(child: Text(isUpdate?"Edit":"Add",)),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              /// Notes Title..
              SizedBox(
                width: double.infinity,
                height: 150,
                child: TextField(
                  controller: titlecontroller,
                  expands: true,
                  maxLines: null,
                  style: TextStyle(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter The Title...",

                    // filled: true,
                    // fillColor: Colors.grey,
                  ),
                ),
              ),
              /// Notes Description..
              Expanded(
                child: SizedBox(
                  child: TextField(
                    controller: desccontroller,
                    style: TextStyle(fontSize: 21),
                    expands: true,
                    maxLines: null,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter The Description..."
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}

/*SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            InkWell(
              onTap: (){
                myDb.updateNote(updatedNotes:NotesModel(title: titlecontrol.text, desc: descontrol.text) , sno: widget.sno);
              },
              child: Container(
                margin: EdgeInsets.only(right: 20),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xff3B3B3B),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Center(child: Text("Edit",)),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              /// Notes Title..
              SizedBox(
                width: double.infinity,
                height: 150,
                child: TextField(
                  controller: titlecontrol,
                   expands: true,
                  maxLines: null,
                  style: TextStyle(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter The Title...",

                    // filled: true,
                    // fillColor: Colors.grey,
                  ),
                ),
              ),
              /// Notes Description..
              Expanded(
                child: SizedBox(
                  child: TextField(
                    controller: descontrol,
                    style: TextStyle(fontSize: 21),
                    expands: true,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter The Description..."
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    )*/