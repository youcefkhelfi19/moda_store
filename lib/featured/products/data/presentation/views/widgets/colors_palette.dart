import 'package:flutter/material.dart';
import 'package:moda_store/config/app_colors.dart';

class ColorsPalette extends StatefulWidget {
  const ColorsPalette({Key? key,   this.onTap}) : super(key: key);
final Function(List<int>)? onTap;
  @override
  State<ColorsPalette> createState() => _ColorsPaletteState();
}

class _ColorsPaletteState extends State<ColorsPalette> {
   List<int> selectedColors = [];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      width: 250,
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 50,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          itemCount: AppColors.colorsList.length,
          itemBuilder: (BuildContext ctx, index) {
            return GestureDetector(
              onTap: (){
                if(selectedColors.contains(AppColors.colorsList[index])){
                  selectedColors.remove(AppColors.colorsList[index]);
                }else{
                  selectedColors.add(AppColors.colorsList[index]);
                }
                setState(() {
                  widget.onTap!(selectedColors);
                });
              },
              child: Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: selectedColors.contains(AppColors.colorsList[index])?Border.all(color: AppColors.mainColor,width: 2):null
                ),
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(AppColors.colorsList[index])
                  ),
                ),
              ),
            );
          }),
    );
  }
}
