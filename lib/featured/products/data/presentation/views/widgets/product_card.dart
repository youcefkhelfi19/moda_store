import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ionicons/ionicons.dart';
import 'package:moda_store/config/app_colors.dart';
import 'package:moda_store/config/app_routes.dart';
import 'package:moda_store/featured/products/data/presentation/view_model/product/add_product/add_product_cubit.dart';
import 'package:moda_store/featured/products/data/presentation/view_model/product/product/product_cubit.dart';

import '../../../models/product_model.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.product
  }) : super(key: key);
  final Product product;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
       Navigator.pushNamed(context, AppRoutes.details,arguments: product.productId);
      },
      child: SizedBox(
        width: 170,

        child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            ),
            child:Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        child:CachedNetworkImage(
                          //  cacheManager: customCacheManager,
                          key: UniqueKey(),
                          imageUrl:product.images![0],
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.fill,
                          maxHeightDiskCache: 800,
                          placeholder: (context,url) {
                            return  Container(
                              padding: const EdgeInsets.all(30),
                                height: 100,
                                width: 100,
                                child: Image.asset(
                                    'assets/images/loading.gif',
                                
                                )
                            );
                          },
                          errorWidget: (context,url,error) => const Icon(Ionicons.alert_circle_outline),
                        ),),
                     Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(product.title,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text('${product.price} DZD',
                        style:  TextStyle(fontSize: 16,color: AppColors.mainColor,decoration: product.discount == 0? null:TextDecoration.lineThrough,
                      ),

                      ),
                    ),
                  ],
                ),
                DeleteProductBtn(product: product),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(5),
                    decoration:  BoxDecoration(
                        color: AppColors.mainColor.withOpacity(0.2),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)
                        )
                    ),
                    child: Text('${product.quantity}',style: const TextStyle(color: AppColors.mainColor),),
                  ),
                ),
                Positioned(child: product.discount == 0? const SizedBox():Container(
                  height: 30,
                  width: 40,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                        topLeft: Radius.circular(10)
                    )
                  ),
                  child: Text('-${product.discount}%',style: const TextStyle(color: Colors.white,fontSize: 14),),
                )),
                Positioned(
                    left: 0,
                    top:130 ,
                    child: product.discount == 0? const SizedBox():Container(
                  height: 20,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      color: Colors.red,

                  ),
                  child: Text('${(product.price)-(product.price*(product.discount/100))}DA',style: const TextStyle(color: Colors.white,fontSize: 16),),
                ))
              ],
            )
        ),
      ),
    );
  }
}

class DeleteProductBtn extends StatelessWidget {
  const DeleteProductBtn({
    super.key, required this.product,
  });
 final Product product;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 5,
      top: 5,
      child: Container(
        padding: const EdgeInsets.all(3),
        decoration:  BoxDecoration(
            color: AppColors.mainColor.withOpacity(0.2),
            shape: BoxShape.circle
        ),
        child: InkWell(
            onTap: ()async{
             await context.read<AddProductCubit>().deleteProductPictures(product: product);
            }, child: const Icon(Ionicons.remove_circle,color: Colors.red,)),
      ),
    );
  }
}
