import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../../../models/product_model.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(const ProductInitial());

  Future getProduct({required String id})async{
    emit(const ProductLoading());
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    Product product;
    try{
      var snapshot =   firebaseFirestore.collection('products').doc(id);
      snapshot.get().then((value){
           Map<String, dynamic> data = value.data() as Map<String, dynamic>;
           product = Product.fromMap(data);
           emit(ProductSuccess(
            product: product
        ));

      });
    }catch(e){
      emit(ProductFailed(errMsg: e.toString()));
    }
  }

}
