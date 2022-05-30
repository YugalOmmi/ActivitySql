import 'package:activitysql1/models/to_do_model.dart';
import 'package:activitysql1/screens/post_to_do_item.dart';
import 'package:flutter/material.dart';

import '../utilities/db_helper.dart';


class ToDoListScreen extends StatefulWidget {
  ToDoListScreen({Key? key}) : super(key: key);

  @override
  State<ToDoListScreen> createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  DataBaseHelper dataBaseHelper= DataBaseHelper();
  List<ToDoModel>? _todoList = [];
  int count=0;

  @override
  void initState() {
    super.initState();
    print("update list");
    updateListView();
  }

  @override
  Widget build(BuildContext context) {
    _todoList ??= [];
    return Scaffold(
      appBar: AppBar(
        title:  Text("ActivitySQL!"),),
      body: popuplateListView(),
      floatingActionButton: FloatingActionButton(onPressed: (){
        navigationToDetailsView(ToDoModel("","","",""),"Add New Address",true);
      }, child: const Icon(Icons.add) ,),
    );
  }



  ListView popuplateListView(){

    return ListView.builder(itemCount: _todoList!.length,
        itemBuilder: (context,index){
          return Card(
            child: GestureDetector(
              onTap: (){
                navigationToDetailsView(_todoList![index], "Update or Delete Item",false);
              },
              child: ListTile(
                //leading: Image.file(_todoList![index].image,fit: BoxFit.fill,height: 30,width: 10),
                title: Text(_todoList![index].name),
                subtitle: Text(_todoList![index].branch),
                trailing: const Icon(Icons.arrow_forward_rounded),
              ),
            ) ,
          );
        }
    );
  }
  //ListView pop
  navigationToDetailsView(ToDoModel toDoModel,String appBarTitle, bool isInsert) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PostToDoItem(toDoModel, appBarTitle, isInsert),
      ),
    ).then((value) {
      setState(() {
        updateListView();
      });
    });
  }
  updateListView() async{
    _todoList=await dataBaseHelper.getModelsFromMapList();
  }

}
