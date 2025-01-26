

import 'dart:convert';
import 'package:get/get.dart';
import 'package:untitled/store/storage.dart';
import '../entities/userdata.dart';

class UserStore extends GetxController {
  static const String STORAGE_USER_TOKEN_KEY = "token_key";
  static const String STORAGE_USER_PROFILE_KEY = "user_profile_key";

  static UserStore get to => Get.find();

  final _isLogin = false.obs;
  String token = '';
  final _profile = UserLoginResponseEntity().obs;

  bool get isLogin => _isLogin.value;
  UserLoginResponseEntity get profile => _profile.value;
  bool get hasToken => token.isNotEmpty;

  @override
  void onInit() {
    super.onInit();
    token = StorageServices.to.getString(STORAGE_USER_TOKEN_KEY);
    var profileOffline = StorageServices.to.getString(STORAGE_USER_PROFILE_KEY);
    if (profileOffline.isNotEmpty) {
      _isLogin.value = true;
      _profile(UserLoginResponseEntity.fromJson(jsonDecode(profileOffline)));
    }
  }

  Future<void> setToken(String value) async {
    await StorageServices.to.setString(STORAGE_USER_TOKEN_KEY, value);
    token = value;
  }

  Future<String> getProfile() async {
    if (token.isEmpty) return "";
    try {
     // var result = await UserAPI.profile(); // Uncomment if needed
     // _profile(result);
      _isLogin.value = true;
    } catch (e) {
      print("Error fetching profile: $e");
    }

    return StorageServices.to.getString(STORAGE_USER_PROFILE_KEY);
  }

  Future<void> saveProfile(UserLoginResponseEntity profile) async {
    _isLogin.value = true;
    StorageServices.to.setString(STORAGE_USER_PROFILE_KEY, jsonEncode(profile));
    setToken(profile.accessToken ?? '');
  }

  Future<void> updateProfile(UserLoginResponseEntity newProfile) async {
    _isLogin.value = true;

    String? existingProfileData = StorageServices.to.getString(STORAGE_USER_PROFILE_KEY);
    UserLoginResponseEntity? existingProfile;

    if (existingProfileData != null) {
      existingProfile = UserLoginResponseEntity.fromJson(jsonDecode(existingProfileData));
    }

    UserLoginResponseEntity updatedProfile = UserLoginResponseEntity(
      email: newProfile.email?.isNotEmpty == true ? newProfile.email : existingProfile?.email ?? "",
      accessToken: newProfile.accessToken?.isNotEmpty == true ? newProfile.accessToken : existingProfile?.accessToken ?? "",
      displayName: newProfile.displayName?.isNotEmpty == true ? newProfile.displayName : existingProfile?.displayName ?? "",

    );

    StorageServices.to.setString(STORAGE_USER_PROFILE_KEY, jsonEncode(updatedProfile));
    setToken(updatedProfile.accessToken ?? '');
  }

  Future<void> onLogout() async {
    await StorageServices.to.remove(STORAGE_USER_TOKEN_KEY);
    await StorageServices.to.remove(STORAGE_USER_PROFILE_KEY);
    _isLogin.value = false;
    token = '';
  }
}
