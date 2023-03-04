part of 'products_list_cubit.dart';

@immutable
abstract class ProductsListState {}

class ProductsListInitial extends ProductsListState {}
class ProductsLoading extends ProductsListState {}
class ProductsListSuccess extends ProductsListState {}
class ProductsListFailed extends ProductsListState {}
