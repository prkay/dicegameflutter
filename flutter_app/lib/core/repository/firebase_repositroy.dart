import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/repository/local_user_data.dart';
import 'package:flutter_app/features/login/model/login_request_model.dart';
import 'package:flutter_app/features/register/model/registration_request_model.dart';
import 'package:flutter_app/resources/string_keys.dart';

enum userExist { exist, notexist, otherError }
class FireBaseRepository {
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  Future<String>storeUserData({@required UserModel userModel}) async {
    var u = await checkUserExistOrNot(email: userModel.email);
    if(u == userExist.exist){
      return StringKeys.userAlreadyExist;
    }else if(u ==userExist.otherError){
      return StringKeys.somethingWentWrong;
    }else{
      try{
        DocumentReference documentReferencer = userCollection.doc(userModel.email);
        await documentReferencer.set(userModel.toMap()).whenComplete(() {
          return StringKeys.userCreated;
        }).catchError((e) => print(e));
        return StringKeys.userCreated;
      }catch(e){
        print(e.toString());
        return StringKeys.somethingWentWrong;
      }
    }
  }

  Future<userExist> checkUserExistOrNot({@required email}) async {
    try{
      final QuerySnapshot result = await Future.value(userCollection
          .where("email", isEqualTo: email)
          .limit(1)
          .get());
      if(result.docs.isEmpty){
        return userExist.notexist;
      }else{
        return userExist.exist;
      }
    }catch(e){
      print(e.toString());
      return userExist.otherError;
    }
  }

  Future<String> authenticateUser({LoginRequest userModel}) async {
    try{
      final QuerySnapshot result = await Future.value(userCollection
          .where("email", isEqualTo: userModel.email).where("password",isEqualTo: userModel.password)
          .limit(1)
          .get());
      if(result.docs.isEmpty){
        return StringKeys.inValidCredentials;
      }else{
        await LocalUserDB.saveUserData(UserModel.fromMap(result.docs.first.data()));
        return StringKeys.userAlreadyExist;
      }
    }catch(e){
      print(e.toString());
      return StringKeys.somethingWentWrong;
    }
  }

  Future<dynamic> getListOfAllUsers() async {
    try{
      final QuerySnapshot result = await Future.value(userCollection
      .orderBy('total_point', descending: true)
          .get());
      List<UserModel> userList = [];
      result.docs.forEach((element) {
        userList.add(UserModel.fromMap(element.data()));
      });
      return userList;
    }catch(e){
      return StringKeys.somethingWentWrong;
    }
  }

  Future<String> updateStoredDate({UserModel userModel}) async{
    try{
      DocumentReference documentReferencer = userCollection.doc(userModel.email);
      await documentReferencer
          .update(userModel.toMap());
      await authenticateUser(userModel: LoginRequest(email: userModel.email,password: userModel.password));
      return StringKeys.scoreUpdated;
    }catch(e){
      return StringKeys.somethingWentWrong;
    }
  }
}