import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/app_colors.dart';
import '../../../../../../config/text_styles.dart';
import '../../view_model/product/add_product/add_product_cubit.dart';
import 'colors_palette.dart';

class UpdateColors extends StatefulWidget {
  const UpdateColors({Key? key,required this.id}) : super(key: key);
 final String id;
  @override
  State<UpdateColors> createState() => _UpdateColorsState();
}

class _UpdateColorsState extends State<UpdateColors> {
  List<int> selectedColors = [];
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

      content: ColorsPalette(
        onTap: (values){

          selectedColors = values;
        },
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
            await context.read<AddProductCubit>().
            updateField(fieldValue: selectedColors, field: 'colors', id: widget.id);
            if (mounted) Navigator.of(context).pop();        },
          child: Text('Save',style: TextStyles.style20.copyWith(color: AppColors.secondaryColor,
              fontWeight: FontWeight.normal,fontSize: 16),),
        )

      ],
    );
  }
}
