import 'dart:async';
import 'dart:async';
import 'dart:core';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
class StorageServices extends GetxService{
static StorageServices get to=>Get.find();
late  SharedPreferences _preferences;


Future<StorageServices> init() async{
  _preferences=await SharedPreferences.getInstance();
  return this;
}
Future<bool> setString(String key,String value)async{
  return await _preferences.setString(key, value);

}
Future<bool> setBool(String key,bool value) async {
  return  await _preferences.setBool(key, value);
}
Future<bool> setList(String key, List<String> value)async{
  return await _preferences.setStringList(key, value);
}
String getString(String key){
  return _preferences.getString(key)??'';
}
bool getBool(String key){
  return _preferences.getBool(key)??false;
}
List<String> getList(String key){
  return _preferences.getStringList(key)??[];
}
Future<bool> remove(String key)async{
  return await _preferences.remove(key);
}
}
