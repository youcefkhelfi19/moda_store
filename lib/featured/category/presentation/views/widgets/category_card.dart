import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:moda_store/featured/category/data/models/category_model.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.cateGory
  }) : super(key: key);
  final CategoryModel cateGory;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(19)
              ),
              child: CachedNetworkImage(
                //  cacheManager: customCacheManager,
                key: UniqueKey(),
                imageUrl:cateGory.imageLink,
                height: 80,
                width: 100,
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
           Container(
               height: 30,
               alignment: Alignment.center,
               child: Text(cateGory.title,style: const TextStyle(),))
        ],
      ),
    );
  }
}
