import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moda_store/featured/products/data/models/product_model.dart';

import '../../../../../../config/app_colors.dart';
import '../../../../../../config/text_styles.dart';
import '../../view_model/product/add_product/add_product_cubit.dart';

class SwitchBtns extends StatefulWidget {
  const SwitchBtns({Key? key,required this.product}) : super(key: key);
 final Product product;
  @override
  State<SwitchBtns> createState() => _SwitchBtnsState();
}

class _SwitchBtnsState extends State<SwitchBtns> {
 late bool isPopular;
 late bool isRecommended;
  @override
  void initState() {
     isPopular = widget.product.isPopular;
     isRecommended = widget.product.isRecommended;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return    Padding(
      padding: const EdgeInsets.symmetric(horizontal:10 ),
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
                    value:  isPopular,
                    onChanged: (value) {
                      setState(() {
                        isPopular = value;
                      });
                      context.read<AddProductCubit>().updateField(fieldValue: isPopular, field: 'isPopular', id: widget.product.productId.toString());

                    }
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
                    onChanged: (value){
                      setState(() {
                        isRecommended = value;
                      });
                      context.read<AddProductCubit>().updateField(fieldValue: isRecommended, field: 'isRecommended', id: widget.product.productId.toString());
                    }
                ),
              ],
            ),
          ),
        ],
      ),
    )
    ;
  }
}
