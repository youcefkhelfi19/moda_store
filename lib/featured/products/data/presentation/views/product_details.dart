
import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:moda_store/config/text_styles.dart';
import 'package:moda_store/featured/products/data/presentation/view_model/product/product/product_cubit.dart';
import 'package:moda_store/featured/products/data/presentation/views/widgets/add_more_images.dart';
import 'package:moda_store/featured/products/data/presentation/views/widgets/colors_palette.dart';

import '../../../../../config/app_colors.dart';
import '../../../../../config/app_routes.dart';
import '../../../../../config/constans.dart';
import '../../models/product_model.dart';
import '../../../../../widgets/colors_list.dart';
import '../view_model/product/add_product/add_product_cubit.dart';
import 'widgets/switch_btns.dart';
import 'widgets/update_colors.dart';
import 'widgets/update_sizes.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({Key? key, required this.productId})
      : super(key: key);
  final String productId;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  void initState() {
    context.read<ProductCubit>().getProduct(id: widget.productId.toString());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(

  builder: (context, state) {
    if(state is ProductSuccess){
      Product product = state.product;
      
      return RefreshIndicator(
        onRefresh: () async{
         await context.read<ProductCubit>().getProduct(id: widget.productId.toString());
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title:  Text(product.title),
            elevation: 0.0,
            backgroundColor: AppColors.mainColor,
            actions: [
              IconButton(onPressed: () {
                Navigator.pushNamed(context, AppRoutes.update,arguments: state.product);

              }, icon: const Icon(Ionicons.heart))
            ],
          ),
          body: ListView(
            children: [
              Container(
                  height: 400,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Stack(
                    children: [
                      Swiper(
                        itemBuilder: (context, index) {
                          final image = product.images![index];
                          return Padding(
                            padding: const EdgeInsets.only(left: 3,right: 3),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    //  cacheManager: customCacheManager,
                                    key: UniqueKey(),
                                    imageUrl:product.images![index],
                                    height: 400,
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
                                  ),
                                ),
                                Positioned(
                                    right:5,
                                    top:5,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.white38,
                                          shape: BoxShape.circle
                                      ),
                                      child: IconButton(icon: const Icon(Ionicons.remove_circle_outline),
                                        onPressed: () async{
                                          await context.read<AddProductCubit>().deleteImage(url: image, imagesLinks: product.images!.cast<String>(), id: product.productId.toString());

                                        },
                                      ),
                                    ))

                              ],
                            ),
                          );
                        },
                        indicatorLayout: PageIndicatorLayout.SCALE,
                        autoplay: false,
                        itemCount: product.images!.length,
                        pagination: const SwiperPagination(),
                        control:  const SwiperControl(
                            color: Colors.transparent,disableColor: Colors.transparent
                        ),
                      ),
                      Positioned(
                          right:10,
                          bottom:20,
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.white38,
                                shape: BoxShape.circle
                            ),
                            child: IconButton(icon: const Icon(Icons.add_a_photo_outlined),
                              onPressed: () {
                                showDialog(context: context, builder: (context){
                                  return  AddMoreImages(product: product,);
                                });
                              },
                            ),
                          ))

                    ],
                  )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:  [
                    const Text('Price:',style: TextStyles.style20,),
                    Text('${product.price}DZD',style:  TextStyles.style20,),
                  ],),
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('Description:',style: TextStyles.style20),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ExpandableText(
                  product.description,
                  style: TextStyle(fontSize: 16,color: Colors.grey.shade700),
                  expandText: 'show more',
                  collapseText: 'show less',
                  maxLines: 3,
                  linkColor: Colors.blue,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text('Sizes:',style:TextStyles.style20),
                        const Spacer(),
                        InkWell(onTap: () {
                          showDialog(context: context, builder: (context){
                            return UpdateSizes(id: product.productId.toString(),);

                          });
                        }, child: const Icon(Icons.edit_outlined),)

                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex:10,
                          child: SizedBox(
                              height: 40,
                              child: ListView(

                                children: [
                                  CustomRadioButton(
                                    elevation: 0,
                                    padding: 0,
                                    absoluteZeroSpacing: false,
                                    shapeRadius: 10,
                                    enableShape: true,
                                    width: 60,
                                    height: 40,
                                    unSelectedColor: Colors.white,
                                    selectedBorderColor: AppColors.mainColor,
                                    unSelectedBorderColor: AppColors.mainColor,
                                    defaultSelected: product.sizes[0],
                                    buttonLables: product.sizes,
                                    buttonValues: product.sizes,
                                    buttonTextStyle: const ButtonTextStyle(
                                        selectedColor: Colors.white,
                                        unSelectedColor: Colors.black,
                                        textStyle: TextStyle(fontSize: 16)),
                                    radioButtonValue: (value) {
                                    },
                                    selectedColor: AppColors.mainColor,
                                  ),
                                ],
                              )
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10,bottom: 5,top: 5),
                child: Row(
                  children: [
                    const Text('Colors:' , style: TextStyles.style20,),
                    const Spacer(),
                    InkWell(onTap: () {
                      showDialog(context: context, builder: (context){
                        return UpdateColors(id: product.productId.toString(),);

                      });
                    }, child: const Icon(Icons.edit_outlined),)
                  ],
                ),
              ),
              ColorsList(colors:product.colors,
              ),
              const SizedBox(height: 20,),
             SwitchBtns(product: product,),

        const SizedBox(height: 20,),
            ],
          ),
        ),
      );

    }else if(state is ProductFailed){

    }
    return const Scaffold(
      body: Center (child: CircularProgressIndicator(),),
    );
  },
);
  }


}
