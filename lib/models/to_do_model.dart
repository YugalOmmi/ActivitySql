class ToDoModel {
  late int id;
  late String name;
  late String branch;
  late String address;
  late String image;
  ToDoModel(this.name,this.branch,this.address,this.image);
  ToDoModel.withID(this.id,this.name,this.branch,this.address,this.image);

  //model to MAp
  Map<String,dynamic> toMap(){
    Map<String,dynamic> map=new Map();
    map["id"]=id;
    map["name"]=name;
    map["branch"]= branch;
    map["address"]=address;
    map["image"]=image;
    return map;
  }
//map to model
  ToDoModel.fromMap(Map<String,dynamic > map){
    id=map["id"];
    name=map["name"];
    branch=map["branch"];
    address=map["address"];
    image=map["image"];
  }

}