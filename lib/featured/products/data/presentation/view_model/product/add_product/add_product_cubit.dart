import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:moda_store/config/app_colors.dart';
import 'package:path/path.dart' as Path;
import 'package:uuid/uuid.dart';

import '../../../../../../../widgets/alerts.dart';
import '../../../../models/product_model.dart';

part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit() : super(AddProductInitial());

  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  var uuid = const Uuid();

  Future uploadImagesAndProduct(List<File> images,Product product) async {
   String productId = uuid.v4();
    emit(AddProductLoading());
    List<String> imagesLinks = [];
    try {
        for (int i = 0; i < images.length; i++) {
          final ref =  firebaseStorage
              .ref()
              .child('products')
              .child(productId)
              .child(Path.basename(DateTime.now().toString()));
          await ref.putFile(images[i]).whenComplete(() async {
            await ref.getDownloadURL().then((value) => {
              imagesLinks.add(value),
            });

          });
        }
        product.productId = productId;
        product.images = imagesLinks;
        await addProduct(product);
    } catch (e) {
      customToast(msg: 'something went wrong ', color: Colors.red);

    }
  }

  Future addProduct(Product product) async {
    try {
      await firebaseFirestore
          .collection('products')
          .doc(product.productId)
          .set(product.toJson())
          .whenComplete(() async {
           emit(AddProductSuccess());
           customToast(msg: 'Product has been saved', color: AppColors.mainColor);
          });

    } catch (e) {
     emit(AddProductFailed());
    }
  }
  Future updateField({required dynamic fieldValue, required String field, required String id }) async {

    try{
      await  firebaseFirestore
          .collection('products')
          .doc(id)
          .update({field: fieldValue}).then((value){
        customToast(
            msg: '$field has been updated', color: AppColors.mainColor
        );
      });


    }catch(e){
      print(e);
      customToast(
          msg: 'Something went wrong ', color: Colors.red
      );
    }

  }
updateFieldsProduct({required String id ,required String title,required String category,required String description,required double price,required int quantity,required int discount })async{
  emit(AddProductLoading());
    try{

    await  firebaseFirestore
        .collection('products')
        .doc(id)
        .update({'title': title,'description': description,'category': category,
      'price': price,'discount': discount,'quantity': quantity,}).then((value){

        customToast(
          msg: 'data has been updated', color: AppColors.mainColor
      );
        emit(AddProductSuccess());
    });


  }catch(e){
     emit(AddProductFailed());
    customToast(
        msg: 'Something went wrong ', color: Colors.red
    );
  }
}
updateImages({required List<String> imagesLinks,required List<File> images, required String id})async{
  emit(AddProductLoading());
  try {
    for (int i = 0; i < images.length; i++) {
      final ref =  firebaseStorage
          .ref()
          .child('products')
          .child(id)
          .child(Path.basename(DateTime.now().toString()));
      await ref.putFile(images[i]).whenComplete(() async {
        await ref.getDownloadURL().then((value) => {
          imagesLinks.add(value),
        });

      });
    }
    await updateField(fieldValue: imagesLinks, field: 'images', id: id);
    emit(AddProductSuccess());
  } catch (e) {
    customToast(msg: 'something went wrong ', color: Colors.red);

  }
}
  Future deleteImage({required String url,required List<String> imagesLinks,required String id}) async {
    try {
        Reference photoRef = firebaseStorage.refFromURL(url);
        await photoRef.delete().then((value) {
           imagesLinks.remove(url);
           updateField(fieldValue: imagesLinks, field: 'images', id: id);
        });

    } catch (e) {
      return false;
    }
  }
  Future deleteProductPictures({required Product product}) async {
    try {
      for (var url in product.images!) {
        Reference photoRef = firebaseStorage.refFromURL(url);
        await photoRef.delete().then((value) {
          print('deleted Successfully');
        });
      }
     await deleteProduct(id: product.productId.toString(),);
    } catch (e) {
    }
  }

  deleteProduct({required String id}) async {
    try {
        await firebaseFirestore.collection('devices').doc(id).delete().whenComplete((){
        }
        );

    } catch (e) {
    }
  }
}
