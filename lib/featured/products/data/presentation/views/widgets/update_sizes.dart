import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/app_colors.dart';
import '../../../../../../config/constans.dart';
import '../../../../../../config/text_styles.dart';
import '../../view_model/product/add_product/add_product_cubit.dart';

class UpdateSizes extends StatefulWidget {
  const UpdateSizes({Key? key,required this.id}) : super(key: key);
   final String id ;
  @override
  State<UpdateSizes> createState() => _UpdateSizesState();
}

class _UpdateSizesState extends State<UpdateSizes> {
  List<String> selectedSizes= [];
  bool isShoes = true;
  @override
  Widget build(BuildContext context) {
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

      content: SizedBox(
        height: 300,
        child: Column(
          children: [
            Row(
              children: [
                const Text('Sizes',style: TextStyle(color: AppColors.mainColor,fontSize: 16),),
                const Spacer(),
                Text('Shoes',style: TextStyles.style20.copyWith(fontWeight: FontWeight.normal,fontSize: 16),),
                CupertinoSwitch(
                  activeColor: AppColors.mainColor.withOpacity(0.7),
                  thumbColor: AppColors.mainColor,
                  trackColor: AppColors.secondaryColor,
                  value: isShoes,
                  onChanged: (value) => setState(() => isShoes = value),
                ),
              ],
            ),
            SizedBox(
              child: CustomCheckBoxGroup(
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
                buttonLables: isShoes?shoesSizes:sizes,
                autoWidth: true,
                buttonValuesList: isShoes?shoesSizes.cast<dynamic>():sizes.cast<dynamic>(),
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
            ),
          ],
        ),
      ),
      actions: [
        MaterialButton(
          height: 40,
          minWidth: 50,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
          ),
          color: AppColors.mainColor,
          onPressed: () async{
            await context.read<AddProductCubit>().updateField(fieldValue: selectedSizes, field: 'sizes', id: widget.id);
            if (mounted) Navigator.of(context).pop();        },
          child: Text('Save',style: TextStyles.style20.copyWith(color: AppColors.secondaryColor,
              fontWeight: FontWeight.normal,fontSize: 16),),
        )

      ],
    );
  }
}
