part of 'product_cubit.dart';

@immutable
abstract class ProductState {
  final bool isLoading;

  const ProductState(this.isLoading);
}

class ProductInitial extends ProductState {
  const ProductInitial() : super(false);

}
class ProductLoading extends ProductState {
  const ProductLoading() : super(true);

}
class ProductFailed extends ProductState {
  const ProductFailed({required this.errMsg}) : super(false);
  final String errMsg;

}
class ProductSuccess extends ProductState {
  final Product product;
  const ProductSuccess({required this.product}):super(false);
}
