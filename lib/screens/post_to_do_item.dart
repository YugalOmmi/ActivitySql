
import 'dart:io';
import 'dart:math';

import 'package:activitysql1/models/to_do_model.dart';
import 'package:activitysql1/screens/to_do_lsit_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../utilities/db_helper.dart';





class PostToDoItem extends StatefulWidget {
  //PostToDoItem({Key? key}) : super(key: key);
  ToDoModel toDoModel;
  bool isInsert;
  String appBarTitle;
  PostToDoItem(this.toDoModel,this.appBarTitle,this.isInsert);

  @override
  State<PostToDoItem> createState() => _PostToDoItemState(this.toDoModel,this.appBarTitle);
}



class _PostToDoItemState extends State<PostToDoItem> {
  ToDoModel toDoModel;
  String appBarTitle;
  File? image;
  TextEditingController _nameEditingContoller = TextEditingController();
  TextEditingController _branchEditingContoller = TextEditingController();
  TextEditingController _addressEditingContoller = TextEditingController();

  @override
  onResume(){
    ToDoListScreen();
  }

  @override
  void initState() {
    super.initState();
    profileImage();

  }

  _PostToDoItemState(this.toDoModel,this.appBarTitle);
  @override
  Widget build(BuildContext context) {

    _nameEditingContoller.text= toDoModel.name;
    _branchEditingContoller.text= toDoModel.branch;
    _addressEditingContoller.text= toDoModel.address;


    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),),
      body: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        child:SingleChildScrollView (
          child:Column(
            children: [
              GestureDetector(
                onTap: (){
                  pickImage(ImageSource.gallery);
                },
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 40.0,
                  child: CircleAvatar(
                    backgroundImage: image != null ? FileImage(image!) : null,
                    radius: 40.0,
                  ),
                ),
              ),
              SizedBox(height: 50,),
              TextField(
                controller: _nameEditingContoller,
                decoration: InputDecoration(
                    hintText: "Enter Name",
                    labelText: "Name",
                    border: OutlineInputBorder()
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: _branchEditingContoller,
                decoration: InputDecoration(
                    hintText: "Enter Branch",
                    labelText: "Branch",
                    border: OutlineInputBorder()
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: _addressEditingContoller,
                decoration: InputDecoration(
                    hintText: "Enter Address",
                    labelText: "Address",
                    border: OutlineInputBorder()
                ),
              ),
              SizedBox(height: 20,),
              Container(
                  width: double.infinity,
                  child: Column(
                    children:[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blueAccent,
                        ),
                        onPressed: () {
                          if(widget.isInsert) {
                            insertData();
                          }else{
                            updateData();
                          }
                        },
                        child: Text(widget.isInsert ? 'Save' : "Update"),
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                          ),
                          onPressed: () {
                            deleteData();
                          },
                          child: Text("Delete"))
                    ],
                  )

              ),
            ],
          ),

        ),
      ),
    );
  }
  insertData(){
    widget.toDoModel.id = Random().nextInt(16789);
    widget.toDoModel.name= _nameEditingContoller.text;
    widget.toDoModel.branch= _branchEditingContoller.text;
    widget.toDoModel.address= _addressEditingContoller.text;
    widget.toDoModel.image= (image != null ? image?.path : "")!;

    DataBaseHelper dataBaseHelper= DataBaseHelper();
    dataBaseHelper.insertItem(widget.toDoModel);
    setState((){});
    Navigator.pop(context,false );

  }

  updateData(){
    widget.toDoModel.name= _nameEditingContoller.text;
    widget.toDoModel.branch= _branchEditingContoller.text;
    widget.toDoModel.address= _addressEditingContoller.text;
    widget.toDoModel.image= (image != null ? image?.path : "")!;
    DataBaseHelper dataBaseHelper= DataBaseHelper();
    dataBaseHelper.updateItem(widget.toDoModel);
    setState((){});
    // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder:
    //     (context) => ToDoListScreen()), (Route<dynamic> route) => false);
    Navigator.pop(context,true);


  }
  deleteData(){
    //toDoModel.id = Random().nextInt(10);
    toDoModel.name= _nameEditingContoller.text;
    toDoModel.branch= _branchEditingContoller.text;
    toDoModel.address= _addressEditingContoller.text;
    toDoModel.image= (image != null ? image?.path : "")!;
    DataBaseHelper dataBaseHelper= DataBaseHelper();
    dataBaseHelper.deleteItem(toDoModel);
    setState((){});
    //  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
    // ToDoListScreen()), (Route<dynamic> route) => false);
    Navigator.pop(context,true);
  }
  profileImage(){
    if(widget.toDoModel.image != null && widget.toDoModel.image !=""){
      File file = File(widget.toDoModel.image);
      // final imageTemp = FileImage(file) ;
      image = file;
    }
  }

  Future pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    final imageTemporary = File(image.path);

    setState(() {
      this.image = imageTemporary;
    });

  }
}

