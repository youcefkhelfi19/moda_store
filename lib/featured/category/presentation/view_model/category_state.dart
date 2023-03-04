part of 'category_cubit.dart';

@immutable
abstract class CategoryState {
  final bool isLoading;

  const CategoryState(this.isLoading);
}

class CategoryInitial extends CategoryState {
  const CategoryInitial() : super(true);

}
class CategoryLoading extends CategoryState {
  const CategoryLoading() : super(true);
}
class CategorySuccess extends CategoryState {
  final List categories;

  const CategorySuccess({required this.categories}): super(false);
}
class CategoryFailed extends CategoryState {
  const CategoryFailed() : super(false);

}
