import 'dart:io';

import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ionicons/ionicons.dart';
import 'package:moda_store/config/text_styles.dart';
import 'package:moda_store/featured/products/data/models/product_model.dart';
import 'package:moda_store/featured/products/data/presentation/view_model/product/add_product/add_product_cubit.dart';
import 'package:moda_store/featured/products/data/presentation/views/widgets/colors_palette.dart';

import '../../../../../config/app_colors.dart';
import '../../../../../config/constans.dart';
import '../../../../../services/locator.dart';
import '../../../../category/presentation/views/add_category.dart';
import '../../../../category/presentation/views/widgets/custom_btn.dart';
import 'widgets/input_field.dart';

class UpdateProduct extends StatefulWidget {
  const UpdateProduct({Key? key,required this.product}) : super(key: key);
  final Product product ;
  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {

  GlobalKey<FormState> formKey = GlobalKey();
  late TextEditingController titleTextController;
  late TextEditingController descriptionTextController;
  late TextEditingController priceTextController;
  late TextEditingController discountTextController;
  late TextEditingController quantityTextController;
  late TextEditingController categoryTextController;
  @override
  void initState() {
    initForm();
    super.initState();
  }
  @override
  void dispose() {
    cleatForm();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AddProductCubit, AddProductState>(
      listener: (context, state) {
        if(state is AddProductSuccess){
          cleatForm();
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: AppColors.mainColor,
                centerTitle: true,
                title: const Text('Update Product'),
                actions: [IconButton(onPressed: (){
                  showDialog(context: context, builder: (context){
                    return  AlertDialog(
                      titlePadding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      title: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: const BoxDecoration(
                              color: AppColors.mainColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)
                              )
                          ),
                          child:  Text('Add Category',style: TextStyles.style20.copyWith(color: AppColors.secondaryColor),)),
                      content: const AddCategory(),
                    );
                  });
                }, icon: const Icon(Ionicons.duplicate_outline))],

              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5,bottom: 20),
                        child: Text('Product details',style: TextStyles.style20.copyWith(fontSize: 16),),
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 3,
                              child: InputField(hintText: 'Product Name',
                                label: 'Product Name',
                                textEditingController: titleTextController,
                                validator: (value){
                                  if(value!.isEmpty){
                                    return 'Add title';
                                  }
                                  return null;
                                },
                              )),
                          const SizedBox(width: 10,),
                          Expanded(
                              flex: 2,
                              child: EasyAutocomplete(
                                controller: categoryTextController,
                                decoration: const InputDecoration(hintText: 'Category',
                                  label: Text('Category'),),
                                suggestions: getIt.get<GetStorage>().read('categories'),
                                onChanged: (value) => print('onChanged value: $value'),
                                onSubmitted: (value) => print('onSubmitted value: $value'),
                                validator: (value){
                                  if(value!.isEmpty){
                                    return 'Add Category';
                                  }
                                  return null;
                                },

                              )
                          )

                        ],
                      ),
                      const SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          keyboardType: TextInputType.multiline,
                          controller: descriptionTextController,
                          minLines: 3,
                          maxLines: 5,
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Add Description';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            label: Text('Description'),
                            hintText: 'Product Description',
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Row(
                        children: [
                          Expanded(
                              flex: 3,
                              child: InputField(hintText: 'Price',
                                label: 'Price',
                                textEditingController: priceTextController,
                                validator: (value){
                                  if(value!.isEmpty){
                                    return 'Add price';
                                  }
                                  return null;
                                },
                                isNumber: true,
                                showSuffix: true,
                                suffix: 'DZ',
                              )),

                          const SizedBox(width: 5,),

                          Expanded(
                              flex: 2,
                              child: InputField(hintText: 'Quantity',
                                label:  'Quantity',
                                textEditingController: quantityTextController,
                                validator: (value){
                                  if(value!.isEmpty){
                                    return 'Add discount';
                                  }
                                  return null;
                                },
                                isNumber: true,
                                showSuffix: false,
                              )) ,const SizedBox(width: 5,),
                          Expanded(
                              flex: 2,
                              child: InputField(hintText: 'discount',
                                label: 'Discount',
                                textEditingController: discountTextController,
                                validator: (value){
                                  if(value!.isEmpty){
                                    return 'Add discount';
                                  }
                                  return null;
                                },
                                isNumber: true,
                                showSuffix: true,
                                suffix: '%',
                              )),
                        ],
                      ),

          const Spacer(),
                      CustomBtn(title: 'Upload',
                        onTap: () async{
                          if(formKey.currentState!.validate()){
                              context.read<AddProductCubit>().updateFieldsProduct(
                                  id: widget.product.productId.toString(),
                                  title: titleTextController.text,
                                  category: categoryTextController.text,
                                  description: descriptionTextController.text,
                                  price: double.parse(priceTextController.text),
                                  quantity: int.parse(quantityTextController.text),
                                  discount: int.parse(discountTextController.text));

                          }
                        },)
                    ],
                  ),
                ),
              ),
            ),
            state.isLoading? Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.black12,
              alignment: Alignment.center,
              child: const SizedBox(
                height: 100,
                width: 100,
                child: CircularProgressIndicator(
                  color: AppColors.mainColor,
                ),
              ),
            ):const SizedBox(),

          ],
        );
      },
    );
  }


  openColorsPalette(){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        titlePadding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        title: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: const BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)
                )
            ),
            child:  Text('Select Colors',style: TextStyles.style20.copyWith(color: AppColors.secondaryColor),)),

        content: ColorsPalette(
          onTap: (selectedColors){
            setState(() {
              selectedColors = selectedColors;
            });
          },
        ),
      );
    });

  }
  initForm(){
    titleTextController = TextEditingController(text: widget.product.title);
    descriptionTextController= TextEditingController(text:widget.product.description);
    priceTextController= TextEditingController(text:widget.product.price.toString());
    discountTextController = TextEditingController(text: widget.product.discount.toString());
    quantityTextController = TextEditingController(text: widget.product.quantity.toString());
    categoryTextController = TextEditingController(text:widget.product.category);

  }
  cleatForm(){
    setState(() {
      titleTextController.clear();
      descriptionTextController.clear();
      categoryTextController.clear();
      priceTextController.clear();
      discountTextController.clear();

    });
  }
}


