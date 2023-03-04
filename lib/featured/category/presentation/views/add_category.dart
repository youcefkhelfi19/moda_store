import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moda_store/featured/category/presentation/view_model/category_cubit.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/text_styles.dart';
import '../../../auth/presentation/views/widgets/upload_image.dart';
import '../../../products/data/presentation/views/widgets/input_field.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  late File image = File('');
  late TextEditingController categoryController;
  @override
  void initState() {
    categoryController = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    categoryController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: (){
              imageAlertDialog(context: context,
                openCamera: () {
                  _pickImageFromCamera();
                },
                openGallery: () {
                  _pickImageFromGallery();
                },);
            },
            child: Container(
              width: 100,
              height: 100,
              margin: const EdgeInsets.all(3),
              decoration:   BoxDecoration(
                borderRadius: BorderRadius.circular(10),
               image: image.path.isEmpty?null:DecorationImage(
                 image: FileImage(image)
               )
              ),
              child: DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(10),
                color: AppColors.secondaryColor,
                child:  Align(
                  alignment: Alignment.center,
                  child: image.path.isNotEmpty?null:const Icon(
                    Icons.add_photo_alternate_outlined,
                    size: 40,
                    color: AppColors.mainColor,
                  ),
                ),
              ),
            ),
          ),
          InputField(
              label: 'Category',
              hintText: 'Category', textEditingController: categoryController, validator:(value){
            return value;
          }),
          Align(
            alignment: Alignment.bottomRight,
            child: BlocConsumer<CategoryCubit, CategoryState>(
              listener:(context, state){
                if(state is CategorySuccess){
                  setState(() {
                    image = File('');
                    categoryController.clear();
                  });
                }
              },
              builder: (context, state) {
                return state.isLoading?const CircularProgressIndicator(color: AppColors.mainColor,):
                MaterialButton(
                  height: 40,
                  minWidth: 50,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  color: AppColors.mainColor,
                  onPressed: () async{
                    if(image != null || categoryController.text.isNotEmpty){
                      await context.read<CategoryCubit>().uploadCategory(image: image, categoryTitle: categoryController.text);
                    }
                  },
                  child: Text('Add',style: TextStyles.style20.copyWith(color: AppColors.secondaryColor,
                      fontWeight: FontWeight.normal,fontSize: 16),),
                );
              },
            ),
          )

        ],
      ),
    );
  }
  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = File(pickedFile!.path);
      Navigator.pop(context);

    });


  }
  Future<void> _pickImageFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      image = File(pickedFile!.path);
      Navigator.pop(context);
    });


  }
}