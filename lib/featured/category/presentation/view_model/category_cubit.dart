import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meta/meta.dart';
import 'package:moda_store/featured/category/data/models/category_model.dart';
import 'package:moda_store/services/locator.dart';
import 'package:uuid/uuid.dart';

import '../../../../config/app_colors.dart';
import '../../../../widgets/alerts.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(const CategoryInitial());
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  FirebaseDatabase database = FirebaseDatabase.instance;
   List<CategoryModel> categories  = [];
  var uuid = const Uuid();

  addCategory(CategoryModel category)async {
    String id = uuid.v4();
    try{
      DatabaseReference ref = database.ref("categories").child(id);
      await ref.set(category.toJson()).whenComplete((){
        getCategories();
        customToast(
        msg: 'Uploaded success', color: AppColors.mainColor
        );
      });
    }catch(e){
      emit(const CategoryFailed());
    }
  }
  uploadCategory({required File image, required String categoryTitle})async{
    emit(const CategoryLoading());
    customToast(
        msg: 'uploading category', color: AppColors.mainColor
    );
    try{
      final ref =  firebaseStorage
          .ref()
          .child('categories')
          .child(DateTime.now().toString());
      await ref.putFile(image).whenComplete(() async {
        await ref.getDownloadURL().then((value){
          CategoryModel category = CategoryModel(imageLink: value, title: categoryTitle.trim());
          addCategory(category);
        });
      });
    }catch(e){
      emit(const CategoryFailed());
      customToast(
          msg: 'Something went wrong ', color: Colors.red
      );
    }
  }
  getCategories()async{
    emit(const CategoryLoading());
    try{
      DatabaseReference ref =  database.ref('categories');
      var snapshot =await ref.get();
      if(snapshot.exists){
        categories = [];
        for(var data in snapshot.children) {
          categories.add(CategoryModel.fromJson(data.value as Map<dynamic,dynamic>));
        }
        saveCategoriesLocally();
        emit(CategorySuccess(categories: categories));

      }else{
        emit(const CategorySuccess(categories: []));
      }
    }catch(e){
      emit(const CategoryFailed());
    }

  }
  saveCategoriesLocally(){
    List<String> categoriesNames = [];
    for(CategoryModel category in categories){
      categoriesNames.add(category.title);
    }
    getIt.get<GetStorage>().write('categories', categoriesNames);

  }
  getData(){
    final reference = FirebaseDatabase.instance.ref('categories');
    final stream = reference.onValue.map((event) => event.snapshot.value);
    return stream;
  }
}
