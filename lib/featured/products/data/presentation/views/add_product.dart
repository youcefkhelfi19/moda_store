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
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../../config/app_colors.dart';
import '../../../../../config/constans.dart';
import '../../../../../services/locator.dart';
import '../../../../category/presentation/views/add_category.dart';
import '../../../../category/presentation/views/widgets/custom_btn.dart';
import 'widgets/input_field.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {

  List<File> imagesList = [];
  List<String> selectedSizes = [];
  List<int> selectedColors = [];
  List<Asset> assetsImages = [];
  bool isNumbers = false;
  bool isPopular = false;
  bool isRecommended = false;
  GlobalKey<FormState> formKey = GlobalKey();
  late TextEditingController titleTextController;
  late TextEditingController descriptionTextController;
  late TextEditingController priceTextController;
  late TextEditingController discountTextController;
  late TextEditingController categoryTextController;
  @override
  void initState() {
    titleTextController = TextEditingController();
    descriptionTextController= TextEditingController();
    priceTextController= TextEditingController();
    discountTextController = TextEditingController(text: '0');
    categoryTextController = TextEditingController();
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
          title: const Text('Add Product'),
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
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Select Product Images',style: TextStyles.style20.copyWith(fontSize: 16),),
                    const SizedBox(height: 5,),
                    Container(
                      height: 90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.secondaryColor.withOpacity(0.3),

                      ),
                      child: ListView.builder(
                          itemCount:imagesList.length+1,
                          scrollDirection: Axis.horizontal,
                          reverse: true,
                          itemBuilder:(context,index){
                        if (index == imagesList.length||imagesList.isEmpty) {
                          return Container(
                            width: 80,
                            margin: const EdgeInsets.all(3),
                            child: DottedBorder(
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(10),
                              color: AppColors.secondaryColor,
                              child: Align(
                                alignment: Alignment.center,
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: (){
                                    pickImages();
                                  },
                                  icon: const Icon(
                                    Icons.camera_alt_outlined,
                                    size: 40,
                                    color: AppColors.mainColor,
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Stack(
                            children: [
                              Container(
                                height:90,
                                width: 90,
                                margin: const EdgeInsets.all(3),
                                decoration: BoxDecoration(

                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: FileImage(imagesList[index]),
                                        fit: BoxFit.fill)

                                ),
                              ),
                              Positioned(
                                  top:7,
                                  right:7,
                                  child: Container(
                                    padding:const EdgeInsets.all(2),
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white54
                                    ),

                                    child: InkWell(
                                        onTap:(){
                                          imagesList.removeAt(index);
                                          setState(() {
                                          });
                                        },
                                        child: const Icon(Icons.remove_circle_outline,color: AppColors.mainColor,size: 17,)),
                                  ))
                            ],
                          );
                        }
                      }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Text('Product details',style: TextStyles.style20.copyWith(fontSize: 16),),
                    ),
                     Row(
                       children: [
                         Expanded(
                             flex: 3,
                             child: InputField(hintText: 'Product Name',
                               textEditingController: titleTextController,
                                 label: 'Product Name',
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
                                 decoration: const InputDecoration(hintText: 'Category',label: Text('Category')),
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
                          label:
                          Text('Description'),
                          hintText: 'Product Description',
                        ),
                      ),
                    ),
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
                              label: 'Quantity',
                              textEditingController: discountTextController,
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
                    const SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Text('Popular',style: TextStyles.style20.copyWith(fontWeight: FontWeight.normal,fontSize: 18),),
                                const Spacer(),
                                CupertinoSwitch(
                                  activeColor: AppColors.mainColor.withOpacity(0.7),
                                  thumbColor: AppColors.mainColor,
                                  trackColor: AppColors.secondaryColor,
                                  value: isPopular,
                                  onChanged: (value) => setState(() => isPopular = value),
                                ),
                              ],
                            ),
                          ),
                         const SizedBox(width: 10,),
                          Expanded(
                            child: Row(
                              children: [
                                Text('Recommended',style: TextStyles.style20.copyWith(fontWeight: FontWeight.normal,fontSize: 18),),
                                const Spacer(),
                                CupertinoSwitch(
                                  activeColor: AppColors.mainColor.withOpacity(0.7),
                                  thumbColor: AppColors.mainColor,
                                  trackColor: AppColors.secondaryColor,
                                  value: isRecommended,
                                  onChanged: (value) => setState(() => isRecommended = value),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20,),

                    Row(
                      children: [
                        const Text('Sizes',style: TextStyle(color: AppColors.mainColor,fontSize: 16),),
                        const Spacer(),
                        Text('Shoes',style: TextStyles.style20.copyWith(fontWeight: FontWeight.normal,fontSize: 16),),
                        CupertinoSwitch(
                          activeColor: AppColors.mainColor.withOpacity(0.7),
                          thumbColor: AppColors.mainColor,
                          trackColor: AppColors.secondaryColor,
                          value: isNumbers,
                          onChanged: (value) => setState(() => isNumbers = value),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          CustomCheckBoxGroup(
                            buttonTextStyle: const ButtonTextStyle(
                              selectedColor: Colors.white,
                              unSelectedColor: AppColors.mainColor,
                              textStyle: TextStyle(fontSize: 14),
                            ),
                            shapeRadius: 10,
                            radius: 10,
                            selectedBorderColor: AppColors.mainColor,
                            unSelectedBorderColor: AppColors.mainColor,
                            enableShape: true,
                            unSelectedColor: Colors.white,
                            buttonLables: isNumbers?shoesSizes:sizes,
                            autoWidth: false,
                            buttonValuesList: isNumbers?shoesSizes.cast<dynamic>():sizes.cast<dynamic>(),
                            checkBoxButtonValues: (values) {
                            setState(() {
                              selectedSizes = values.cast<String>();
                            });
                            },
                            height: 40,
                            spacing: 0,
                            horizontal: false,
                            enableButtonWrap: true,
                            width: 60,
                            absoluteZeroSpacing: false,
                            selectedColor: AppColors.mainColor,
                            padding: 0,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20,),
                    const Text('Colors',style: TextStyle(color: AppColors.mainColor,fontSize: 16),),
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.secondaryColor.withOpacity(0.3),
                      ),
                      child: ListView.builder(
                          itemCount:selectedColors.length+1,
                          scrollDirection: Axis.horizontal,
                          reverse: true,
                          itemBuilder:(context,index){
                            if (index == selectedColors.length||selectedColors.isEmpty) {
                              return Container(
                                width: 30,
                                margin: const EdgeInsets.all(3),
                                child: DottedBorder(
                                  borderType: BorderType.RRect,
                                  radius: const Radius.circular(10),
                                  color: AppColors.secondaryColor,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: (){
                                        openColorsPalette();
                                      },
                                      icon: const Icon(
                                        Icons.add,
                                        size: 15,
                                        color: AppColors.mainColor,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return  GestureDetector(
                                onTap: (){
                                  selectedColors.removeAt(index);
                                  setState(() {

                                  });
                                },
                                child: Container(
                                  height:20,
                                  width: 30,
                                  margin: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                       color: Color(selectedColors[index])

                                  ),
                                ),
                              );
                            }
                          }),
                    ),
                     const SizedBox(height: 20,),
                     CustomBtn(title: 'Upload',
                      onTap: () async{
                        if(formKey.currentState!.validate()){
                          if(selectedColors.isNotEmpty&&selectedSizes.isNotEmpty&&imagesList.isNotEmpty){
                            Product product =
                            Product(title: titleTextController.text,
                                category: categoryTextController.text.trim(),
                                description:descriptionTextController.text,
                                price: double.parse(priceTextController.text),
                                discount: int.parse(discountTextController.text),
                                sizes: selectedSizes,
                                colors: selectedColors,
                                quantity: 10,
                                isPopular: isPopular,
                                isRecommended: isRecommended,
                                dateTime: DateTime.now().toString());
                              await context.read<AddProductCubit>().uploadImagesAndProduct(imagesList, product);
                          }
                        }
                      },)
                  ],
                ),
              ),
            ),
          ),
        ),
        state.isLoading? Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.black12,
          alignment: Alignment.center,
          child:  SizedBox(
            height: 100,
            width: 100,
            child: Image.asset(
              'assets/images/loading.gif',
            )
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
          onTap: (values){
            setState(() {
              selectedColors = values;
            });
          },
        ),
      );
    });

  }
  Future<void> pickImages() async {
    List<Asset> result = <Asset>[];
    try {
      result = await MultiImagePicker.pickImages(
        maxImages: 1000,
        enableCamera: true,
        selectedAssets: assetsImages,
        cupertinoOptions: const CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: const MaterialOptions(
          actionBarColor: "#424242",
          actionBarTitle: "Select Images",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
    }
    if (!mounted) return;


    uploadImages(result);
  }
  Future<void> uploadImages(List<Asset> images) async {
    List<File> fileList = [];
    for (var i = 0; i < images.length; i++) {
      ByteData byteData = await images[i].getByteData();
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = '${tempDir.path}/image$i.jpg';
      File tempFile = File(tempPath);
      await tempFile.writeAsBytes(byteData.buffer.asUint8List());
      fileList.add(tempFile);
    }
    setState(() {
      imagesList= fileList ;
    });
    // Upload the files
  }
cleatForm(){
    setState(() {
      titleTextController.clear();
      descriptionTextController.clear();
      categoryTextController.clear();
      priceTextController.clear();
      discountTextController.clear();
      selectedSizes = [];
      selectedColors = [];
      imagesList = [];
      assetsImages = [];
      isPopular = false;
      isRecommended = false;
    });
}
}


