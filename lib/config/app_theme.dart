import 'package:flutter/material.dart';
import 'package:moda_store/config/text_styles.dart';

import 'app_colors.dart';


ThemeData englishTheme = ThemeData(
    fontFamily: 'PTSans-Regular',
    textTheme: TextTheme(
        headline1: TextStyles.style24,
        bodyText1: TextStyles.style20
    ),
    inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.secondaryColor.withOpacity(0.2),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: AppColors.secondaryColor.withOpacity(0.2)
            )
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: AppColors.secondaryColor.withOpacity(0.2)
            )
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: AppColors.secondaryColor.withOpacity(0.2)
            )
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: Colors.red.withOpacity(0.2)
            )
        )
    )
);
ThemeData arabicTheme = ThemeData(
    fontFamily: 'PTSans-Regular',
    textTheme: const TextTheme(
        headline1: TextStyles.style24,
        bodyText1: TextStyles.style20
    ),
    inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.secondaryColor.withOpacity(0.5),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: AppColors.secondaryColor.withOpacity(0.5)
            )
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: AppColors.secondaryColor.withOpacity(0.5)
            )
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: AppColors.secondaryColor.withOpacity(0.5)
            )
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: Colors.red.withOpacity(0.2)
            )
        )
    )
);