import 'package:cloud_firestore/cloud_firestore.dart';

class UserData{
  final String? id;
  final String? name;
  final String? email;

  UserData(
      {this.id,
        this.name,
        this.email,

      });
  factory UserData.fromFirestore(
      DocumentSnapshot<Map<String,dynamic>> snapeshot,
      SnapshotOptions? options,
      ){
    final data =snapeshot.data();
    return UserData(
      id:data?['id'],
      name:data?['name'],
      email: data?['email'],

    );
  }
  Map<String,dynamic> toFirestore(){
    return{
      if(id!=null)'id':id,
      if(name!=null)'name':name,
      if(email!=null)'email':email,

    };
  }
}
class UserLoginResponseEntity{
  String? accessToken;
  String? displayName;
  String? email;

  UserLoginResponseEntity({
    this.accessToken,
    this.displayName,
    this.email,

  });
  factory UserLoginResponseEntity.fromJson(Map<String,dynamic> json)=>
      UserLoginResponseEntity(
        accessToken: json["access_token"],
        displayName: json["display_name"],
        email: json["email"],

      );
  Map<String,dynamic> toJson()=>{
    "access_token":accessToken,
    "display_name":displayName,
    "email":email,

  };}
