import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moda_store/config/constans.dart';
import 'package:moda_store/featured/category/presentation/view_model/category_cubit.dart';

import '../../../../../config/app_routes.dart';
import 'category_card.dart';
import 'laoding_categories.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({
    Key? key,
  }) : super(key: key);

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  @override
  void initState() {
    context.read<CategoryCubit>().getCategories();
    context.read<CategoryCubit>().getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 120,
      child: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
            if(state is CategoryFailed){
            }else if(state is CategorySuccess){
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.categories.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, AppRoutes.categories, arguments: [index,state.categories]);
                      },
                      child: CategoryCard(
                        cateGory: state.categories[index],
                      ),
                    );
                  });
            }
            return const LoadingCategories();
        },
      ),
    );
  }
}
