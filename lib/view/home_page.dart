import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:notes_app/DBProvider.dart';
import 'package:notes_app/view/add_edit_notes_page.dart';
import 'package:notes_app/data/dbhelper.dart';
import 'package:notes_app/notes_model.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }

}
class HomePageState extends State<StatefulWidget> with SingleTickerProviderStateMixin{
  TextEditingController titlecontroller =TextEditingController();
  TextEditingController desccontroller =TextEditingController();
 static List<NotesModel> allNotes=[];
  @override
  void initState() {
    // getAllNotes();
    super.initState();
    context.read<DBProvider>().getIntitNote();
  }
  List myColor=[
    Color(0xff6A1B9A),
    Color(0xff283593),
    Color(0xff00695B),
    Color(0xff0277BD),
    Color(0xffFF8E01),
    Color(0xffF85181),
    Color(0xff01828F),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
      ),
      body: Consumer<DBProvider>(
        builder: (_,provider,__){
          List<NotesModel> allNotes =provider.getAllNotes();
          return allNotes.isNotEmpty?AnimationLimiter(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 10,mainAxisSpacing: 10),
              itemBuilder: (_,index){
                return AnimationConfiguration.staggeredGrid(
                  position: index,
                  columnCount: 2,
                  duration: Duration(milliseconds: 300),
                  child: SlideAnimation(
                    verticalOffset: 50,
                    child: ScaleAnimation(
                      delay: Duration(milliseconds: 200),
                      child: Stack(
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => AddEditNotesPage(isUpdate: true,sno: allNotes[index].sno!,title: allNotes[index].title,desc: allNotes[index].desc,),));
                            },
                            child: Container(
                              height: 300,
                              width: 300,
                              decoration: BoxDecoration(
                                //color: myColor[index] ,
                                  color: Colors.primaries[Random().nextInt(Colors.primaries.length-1)].shade800,
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(allNotes[index].title,style: TextStyle(fontSize: 22 ,fontWeight: FontWeight.bold),),
                                      Text(allNotes[index].desc,textAlign: TextAlign.justify,style: TextStyle(fontSize: 18),),
                                    ],
                                  ),
                                ),
                              ),

                            ),
                          ),
                          ///Delete Closed Button...
                          Positioned(
                              right: 0,
                              child: IconButton(onPressed: ()async{
                                context.read<DBProvider>().deleteNotes(allNotes[index].sno!);
                              }, icon: Icon(Icons.close_outlined,size: 28,color: Colors.white,)))
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount:allNotes.length,
            ),
          ):Center(child: Text("Opps. No Notes Found !!",style: TextStyle(fontSize: 21),),);
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            titlecontroller.clear();
            desccontroller.clear();
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddEditNotesPage(),));
           // Navigator.push(context, MaterialPageRoute(builder: (context) => Newpage(title: titlecontroller.text,desc: desccontroller.text,),));
          },
        tooltip: "Add Note",
        child: Icon(Icons.add,color: Colors.white,),
        backgroundColor: Color(0xff252525),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }

}

/*showModalBottomSheet(context: context, builder: (_){
              return Container(
                child: Column(
                  children: [
                    Text("ADD NOTES"),
                    SizedBox(height: 20,),
                    ///Title TextFields...
                    TextField(
                      controller:titlecontroller ,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)
                        )
                      ),
                    ),
                    SizedBox(height: 10,),
                    ///Title TextFields...
                    TextField(
                      controller: desccontroller,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)
                          )
                      ),
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(onPressed: ()async{
                          if(titlecontroller.text.isNotEmpty&&desccontroller.text.isNotEmpty){
                            bool isAdd = await myDB.addNotes(newNotes: NotesModel(title: titlecontroller.text, desc: desccontroller.text));
                            if(isAdd){
                              getAllNotes();
                            }
                            setState(() {

                            });
                          }
                          else{
                            Navigator.pop(context);
                          }
                        }, child: Text("Add")),
                        ElevatedButton(onPressed: (){
                          Navigator.pop(context);
                        }, child: Text("cancel")),
                      ],
                    )
                  ],
                ),
              );
            });*/