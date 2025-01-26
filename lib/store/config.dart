import 'dart:ui';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:untitled/store/storage.dart';

import '../utilis/app_constant.dart';

class ConfigStore extends GetxController{
  static  ConfigStore get to=>Get.find();
  bool isfirstOpen=false;
  PackageInfo? _plateform;
  String get version=>_plateform?.version?? '-';
  bool get isRelease=>bool.fromEnvironment("dart.vm.product");
  Locale local=Locale('en','us');
  List<Locale> languages=[
    Locale('en','US'),
    Locale('zh','CN')
  ];
  void onInit(){
    super.onInit();
    isfirstOpen=StorageServices.to.getBool(AppConstants.STORAE_DEVICE_FIRST_OPEN_KEY);

  }
  Future<void> getPlateform() async{
    _plateform=await PackageInfo.fromPlatform();
  }
  Future<bool> saveAlreadyOpen(){
    return StorageServices.to.setBool(AppConstants.STORAE_DEVICE_FIRST_OPEN_KEY,true);

  }
void onInitLocale(){
    var langcode=  StorageServices.to.getString(AppConstants.STORAGE_LANGUAGE_CODEL);
    if(langcode.isEmpty)
      return;
}
}
