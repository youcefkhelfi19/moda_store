part of 'add_product_cubit.dart';

abstract class AddProductState {
  final bool isLoading;

  const AddProductState(this.isLoading);
}
class AddProductInitial extends AddProductState {

  AddProductInitial() : super(false);

}
class AddProductLoading extends AddProductState {
   AddProductLoading() : super(true);

}
class AddProductSuccess extends AddProductState {
   AddProductSuccess() : super(false);

}
class AddProductFailed extends AddProductState {
   AddProductFailed() : super(false);

}
