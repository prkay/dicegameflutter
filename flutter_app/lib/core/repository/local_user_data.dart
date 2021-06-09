import 'package:flutter_app/core/constants/pref_keys.dart';
import 'package:flutter_app/features/register/model/registration_request_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalUserDB {

  static LocalUserDB _instance;
  static SharedPreferences _preferences;

  static Future<LocalUserDB> getInstance() async {
    _instance ??= LocalUserDB();

    _preferences ??= await SharedPreferences.getInstance();

    return _instance;
  }

  static Future<UserModel> getUserData() async {
    await getInstance();
    List<UserModel> decodedDataList = <UserModel>[];
    List<String> userList = await _preferences.getStringList(Prefkeys.USER_DATA);
    if(userList != null){
      for(int i =0 ; i< userList.length;i++){
        List<UserModel> decodedData = UserModel.decodeUserData(userList[i]);
        decodedDataList.add(decodedData[0]);
      }
    }
    return decodedDataList != null && decodedDataList.isNotEmpty ? decodedDataList.first : null;
  }
  static Future<void> saveUserData(UserModel userModel) async {
    List<String> tempUserData = <String>[];
    String encodedData = UserModel.encodeUserData([
      userModel
    ]);
    tempUserData.add(encodedData);
    await getInstance();
    await _preferences.setStringList(Prefkeys.USER_DATA, tempUserData);
  }
  static Future<void> removeUserData() async {
    await getInstance();
    await _preferences.remove(Prefkeys.USER_DATA);
  }
}