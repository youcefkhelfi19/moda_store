import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'products_list_state.dart';

class ProductsListCubit extends Cubit<ProductsListState> {
  ProductsListCubit() : super(ProductsListInitial());
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  getProducts(String category) {
    return firebaseFirestore
        .collection('products')
        .where('category', isEqualTo: category)
        .snapshots();
  }
  getPopularProducts() {
    return firebaseFirestore
        .collection('products')
        .where('isPopular', isEqualTo: true).limit(15)
        .snapshots();
  }
  getRecommendedProducts() {
    return firebaseFirestore
        .collection('products')
        .where('isRecommended', isEqualTo: true).limit(15)
        .snapshots();
  }
  getNewestProducts() {
    return firebaseFirestore
        .collection('products')
        .orderBy('dateTime', descending: false).limit(15)
        .snapshots();
  }
  getAllPopularProducts() {
    return firebaseFirestore
        .collection('products')
        .where('isPopular', isEqualTo: true)
        .snapshots();
  }
  getAllRecommendedProducts() {
    return firebaseFirestore
        .collection('products')
        .where('isRecommended', isEqualTo: true)
        .snapshots();
  }
  getAllNewestProducts() {
    return firebaseFirestore
        .collection('products')
        .orderBy('dateTime', descending: true)
        .snapshots();
  }
}
