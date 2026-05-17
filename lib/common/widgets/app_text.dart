import 'package:flutter/material.dart';
import 'package:premises/common/utils/utils.dart';

import 'package:premises/common/resources/app_colors.dart';
import 'package:premises/common/resources/app_dimens.dart';
import 'package:premises/common/resources/app_strings.dart';

class AppText extends StatelessWidget {
  final String? text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final bool isCenter;
  final bool isAsteriskVisible;
  final bool isUpperCase;
  final TextOverflow textOverflow;
  final TextDecoration textDecoration;

  //Outfit-Bold.ttf - FontWeight.w700
  //Outfit-SemiBold.ttf - FontWeight.w600
  //Outfit-Medium.ttf - FontWeight.w500
  //Outfit-Regular.ttf - FontWeight.w400

  //BB BRAND Primary
  AppText.xlargeBrandPrimaryBold(this.text,
      {super.key,
      isCenter,
      isAsteriskVisible,
      isUpperCase,
      textOverflow,
      textDecoration,
      fontSize})
      : color = AppColors.color_primary,
        fontSize = fontSize ?? TextSize().xlarge,
        isCenter = isCenter ?? false,
        isAsteriskVisible = isAsteriskVisible ?? false,
        isUpperCase = isUpperCase ?? false,
        textOverflow = textOverflow ?? TextOverflow.clip,
        textDecoration = textDecoration ?? TextDecoration.none,
        fontWeight = FontWeight.w700;

  AppText.xsmallBrandSecondaryBold(this.text,
      {super.key,
      isCenter,
      isAsteriskVisible,
      isUpperCase,
      textOverflow,
      textDecoration})
      : color = AppColors.color_secondary,
        fontSize = TextSize().xsmall,
        isCenter = isCenter ?? false,
        isAsteriskVisible = isAsteriskVisible ?? false,
        isUpperCase = isUpperCase ?? false,
        textOverflow = textOverflow ?? TextOverflow.clip,
        textDecoration = textDecoration ?? TextDecoration.none,
        fontWeight = FontWeight.w700;

  AppText.xsmallBrandPrimaryRegular(this.text,
      {super.key,
      isCenter,
      isAsteriskVisible,
      isUpperCase,
      textOverflow,
      textDecoration})
      : color = AppColors.color_primary,
        fontSize = TextSize().xsmall,
        isCenter = isCenter ?? false,
        isAsteriskVisible = isAsteriskVisible ?? false,
        isUpperCase = isUpperCase ?? false,
        textOverflow = textOverflow ?? TextOverflow.clip,
        textDecoration = textDecoration ?? TextDecoration.none,
        fontWeight = FontWeight.w400;

  AppText.xsmallBrandPrimarySemiBold(this.text,
      {super.key,
      isCenter,
      isAsteriskVisible,
      isUpperCase,
      textOverflow,
      textDecoration,
      color})
      : color = color ?? AppColors.color_primary,
        fontSize = TextSize().xsmall,
        isCenter = isCenter ?? false,
        isAsteriskVisible = isAsteriskVisible ?? false,
        isUpperCase = isUpperCase ?? false,
        textOverflow = textOverflow ?? TextOverflow.clip,
        textDecoration = textDecoration ?? TextDecoration.none,
        fontWeight = FontWeight.w600;

  AppText.xsmallBrandPrimaryMedium(this.text,
      {super.key,
      isCenter,
      isAsteriskVisible,
      isUpperCase,
      textOverflow,
      textDecoration})
      : color = AppColors.color_primary,
        fontSize = TextSize().xsmall,
        isCenter = isCenter ?? false,
        isAsteriskVisible = isAsteriskVisible ?? false,
        isUpperCase = isUpperCase ?? false,
        textOverflow = textOverflow ?? TextOverflow.clip,
        textDecoration = textDecoration ?? TextDecoration.none,
        fontWeight = FontWeight.w500;

  AppText.smallBrandPrimaryMedium(this.text,
      {super.key,
      isCenter,
      isAsteriskVisible,
      isUpperCase,
      textOverflow,
      textDecoration})
      : color = AppColors.color_primary,
        fontSize = TextSize().small,
        isCenter = isCenter ?? false,
        isAsteriskVisible = isAsteriskVisible ?? false,
        isUpperCase = isUpperCase ?? false,
        textOverflow = textOverflow ?? TextOverflow.clip,
        textDecoration = textDecoration ?? TextDecoration.none,
        fontWeight = FontWeight.w500;

  AppText.smallBrandPrimarySemiBold(this.text,
      {super.key,
      isCenter,
      isAsteriskVisible,
      isUpperCase,
      textOverflow,
      textDecoration})
      : color = AppColors.color_primary,
        fontSize = TextSize().small,
        isCenter = isCenter ?? false,
        isAsteriskVisible = isAsteriskVisible ?? false,
        isUpperCase = isUpperCase ?? false,
        textOverflow = textOverflow ?? TextOverflow.clip,
        textDecoration = textDecoration ?? TextDecoration.none,
        fontWeight = FontWeight.w600;

  ///BB BRAND Secondary
  AppText.xxxlargeBrandSecondaryBold(this.text,
      {super.key,
      isCenter,
      isAsteriskVisible,
      isUpperCase,
      textOverflow,
      textDecoration})
      : color = AppColors.color_secondary,
        fontSize = TextSize().xxxlarge,
        isCenter = isCenter ?? false,
        isAsteriskVisible = isAsteriskVisible ?? false,
        isUpperCase = isUpperCase ?? false,
        textOverflow = textOverflow ?? TextOverflow.clip,
        textDecoration = textDecoration ?? TextDecoration.none,
        fontWeight = FontWeight.w700;

  AppText.mediumBrandSecondaryBold(this.text,
      {super.key,
      isCenter,
      isAsteriskVisible,
      isUpperCase,
      textOverflow,
      textDecoration})
      : color = AppColors.color_secondary,
        fontSize = TextSize().xmedium,
        isCenter = isCenter ?? false,
        isAsteriskVisible = isAsteriskVisible ?? false,
        isUpperCase = isUpperCase ?? false,
        textOverflow = textOverflow ?? TextOverflow.clip,
        textDecoration = textDecoration ?? TextDecoration.none,
        fontWeight = FontWeight.w700;

  AppText.xlargeBrandSecondaryBold(this.text,
      {super.key,
      isCenter,
      isAsteriskVisible,
      isUpperCase,
      textOverflow,
      textDecoration})
      : color = AppColors.color_secondary,
        fontSize = TextSize().xlarge,
        isCenter = isCenter ?? false,
        isAsteriskVisible = isAsteriskVisible ?? false,
        isUpperCase = isUpperCase ?? false,
        textOverflow = textOverflow ?? TextOverflow.clip,
        textDecoration = textDecoration ?? TextDecoration.none,
        fontWeight = FontWeight.w700;

  AppText.xxlargeBrandSecondaryBold(this.text,
      {super.key,
      isCenter,
      isAsteriskVisible,
      isUpperCase,
      textOverflow,
      textDecoration})
      : color = AppColors.color_secondary,
        fontSize = TextSize().xxlarge,
        isCenter = isCenter ?? false,
        isAsteriskVisible = isAsteriskVisible ?? false,
        isUpperCase = isUpperCase ?? false,
        textOverflow = textOverflow ?? TextOverflow.clip,
        textDecoration = textDecoration ?? TextDecoration.none,
        fontWeight = FontWeight.w700;

  AppText.xxlargeWhiteBold(this.text,
      {super.key,
      isCenter,
      isAsteriskVisible,
      isUpperCase,
      textOverflow,
      textDecoration})
      : color = AppColors.white,
        fontSize = TextSize().xxlarge,
        isCenter = isCenter ?? false,
        isAsteriskVisible = isAsteriskVisible ?? false,
        isUpperCase = isUpperCase ?? false,
        textOverflow = textOverflow ?? TextOverflow.clip,
        textDecoration = textDecoration ?? TextDecoration.none,
        fontWeight = FontWeight.w700;

  AppText.smallBrandSecondaryBold(this.text,
      {super.key,
      isCenter,
      isAsteriskVisible,
      isUpperCase,
      textOverflow,
      textDecoration})
      : color = AppColors.color_secondary,
        fontSize = TextSize().small,
        isCenter = isCenter ?? false,
        isAsteriskVisible = isAsteriskVisible ?? false,
        isUpperCase = isUpperCase ?? false,
        textOverflow = textOverflow ?? TextOverflow.clip,
        textDecoration = textDecoration ?? TextDecoration.none,
        fontWeight = FontWeight.w700;

  AppText.xsmallBrandSecondarySemiBold(this.text,
      {super.key,
      isCenter,
      isAsteriskVisible,
      isUpperCase,
      textOverflow,
      textDecoration})
      : color = AppColors.color_secondary,
        fontSize = TextSize().xsmall,
        isCenter = isCenter ?? false,
        isAsteriskVisible = isAsteriskVisible ?? false,
        isUpperCase = isUpperCase ?? false,
        textOverflow = textOverflow ?? TextOverflow.clip,
        textDecoration = textDecoration ?? TextDecoration.none,
        fontWeight = FontWeight.w600;

  AppText.smallBrandSecondarySemiBold(this.text,
      {super.key,
      isCenter,
      isAsteriskVisible,
      isUpperCase,
      textOverflow,
      textDecoration})
      : color = AppColors.color_secondary,
        fontSize = TextSize().small,
        isCenter = isCenter ?? false,
        isAsteriskVisible = isAsteriskVisible ?? false,
        isUpperCase = isUpperCase ?? false,
        textOverflow = textOverflow ?? TextOverflow.clip,
        textDecoration = textDecoration ?? TextDecoration.none,
        fontWeight = FontWeight.w600;

  AppText.xsmallElevenBrandSecondarySemiBold(this.text,
      {super.key,
      isCenter,
      isAsteriskVisible,
      isUpperCase,
      textOverflow,
      textDecoration})
      : color = AppColors.color_secondary,
        fontSize = TextSize().xsmallEleven,
        isCenter = isCenter ?? false,
        isAsteriskVisible = isAsteriskVisible ?? false,
        isUpperCase = isUpperCase ?? false,
        textOverflow = textOverflow ?? TextOverflow.clip,
        textDecoration = textDecoration ?? TextDecoration.none,
        fontWeight = FontWeight.w600;

  //text_grey
  AppText.xxxlargeGreySemiBold(this.text,
      {super.key,
      isCenter,
      isAsteriskVisible,
      isUpperCase,
      textOverflow,
      textDecoration})
      : color = AppColors.text_grey,
        fontSize = TextSize().xxxlarge,
        isCenter = isCenter ?? false,
        isAsteriskVisible = isAsteriskVisible ?? false,
        isUpperCase = isUpperCase ?? false,
        textOverflow = textOverflow ?? TextOverflow.clip,
        textDecoration = textDecoration ?? TextDecoration.none,
        fontWeight = FontWeight.w600;

  AppText.smallGreySemiBold(this.text,
      {super.key,
      isCenter,
      isAsteriskVisible,
      isUpperCase,
      textOverflow,
      textDecoration})
      : color = AppColors.text_grey,
        fontSize = TextSize().small,
        isCenter = isCenter ?? false,
        isAsteriskVisible = isAsteriskVisible ?? false,
        isUpperCase = isUpperCase ?? false,
        textOverflow = textOverflow ?? TextOverflow.clip,
        textDecoration = textDecoration ?? TextDecoration.none,
        fontWeight = FontWeight.w600;

  AppText.xsmallGreySemiBold(this.text,
      {super.key,
      isCenter,
      isAsteriskVisible,
      isUpperCase,
      textOverflow,
      textDecoration})
      : color = AppColors.text_grey,
        fontSize = TextSize().xsmall,
        isCenter = isCenter ?? false,
        isAsteriskVisible = isAsteriskVisible ?? false,
        isUpperCase = isUpperCase ?? false,
        textOverflow = textOverflow ?? TextOverflow.clip,
        textDecoration = textDecoration ?? TextDecoration.none,
        fontWeight = FontWeight.w600;

  AppText.xsmallRedSemiBold(this.text,
      {super.key,
      isCenter,
      isAsteriskVisible,
      isUpperCase,
      textOverflow,
      textDecoration})
      : color = AppColors.app_color_red,
        fontSize = TextSize().xsmall,
        isCenter = isCenter ?? false,
        isAsteriskVisible = isAsteriskVisible ?? false,
        isUpperCase = isUpperCase ?? false,
        textOverflow = textOverflow ?? TextOverflow.clip,
        textDecoration = textDecoration ?? TextDecoration.none,
        fontWeight = FontWeight.w600;

  AppText.xsmallRedBold(this.text,
      {super.key,
      isCenter,
      isAsteriskVisible,
      isUpperCase,
      textOverflow,
      textDecoration})
      : color = AppColors.app_color_red,
        fontSize = TextSize().xsmall,
        isCenter = isCenter ?? false,
        isAsteriskVisible = isAsteriskVisible ?? false,
        isUpperCase = isUpperCase ?? false,
        textOverflow = textOverflow ?? TextOverflow.clip,
        textDecoration = textDecoration ?? TextDecoration.none,
        fontWeight = FontWeight.w700;

  AppText.smallGreyMedium(this.text,
      {super.key,
      isCenter,
      isAsteriskVisible,
      isUpperCase,
      textOverflow,
      textDecoration})
      : color = AppColors.text_grey,
        fontSize = TextSize().small,
        isCenter = isCenter ?? false,
        isAsteriskVisible = isAsteriskVisible ?? false,
        isUpperCase = isUpperCase ?? false,
        textOverflow = textOverflow ?? TextOverflow.clip,
        textDecoration = textDecoration ?? TextDecoration.none,
        fontWeight = FontWeight.w500;

  AppText.smallRedMedium(this.text,
      {super.key,
      isCenter,
      isAsteriskVisible,
      isUpperCase,
      textOverflow,
      textDecoration})
      : color = AppColors.text_asteriskColor_color,
        fontSize = TextSize().small,
        isCenter = isCenter ?? false,
        isAsteriskVisible = isAsteriskVisible ?? false,
        isUpperCase = isUpperCase ?? false,
        textOverflow = textOverflow ?? TextOverflow.clip,
        textDecoration = textDecoration ?? TextDecoration.none,
        fontWeight = FontWeight.w500;

  AppText.smallGreyRegular(this.text,
      {super.key,
      isCenter,
      isAsteriskVisible,
      isUpperCase,
      textOverflow,
      textDecoration})
      : color = AppColors.text_grey,
        fontSize = TextSize().small,
        isCenter = isCenter ?? false,
        isAsteriskVisible = isAsteriskVisible ?? false,
        isUpperCase = isUpperCase ?? false,
        textOverflow = textOverflow ?? TextOverflow.clip,
        textDecoration = textDecoration ?? TextDecoration.none,
        fontWeight = FontWeight.w400;

  AppText.smallRedRegular(this.text,
      {super.key,
      isCenter,
      isAsteriskVisible,
      isUpperCase,
      textOverflow,
      textDecoration})
      : color = AppColors.text_asteriskColor_color,
        fontSize = TextSize().small,
        isCenter = isCenter ?? false,
        isAsteriskVisible = isAsteriskVisible ?? false,
        isUpperCase = isUpperCase ?? false,
        textOverflow = textOverflow ?? TextOverflow.clip,
        textDecoration = textDecoration ?? TextDecoration.none,
        fontWeight = FontWeight.w400;

  AppText.xsmallGreyRegular(this.text,
      {super.key,
      isCenter,
      isAsteriskVisible,
      isUpperCase,
      textOverflow,
      textDecoration})
      : color = AppColors.text_grey,
        fontSize = TextSize().xsmall,
        isCenter = isCenter ?? false,
        isAsteriskVisible = isAsteriskVisible ?? false,
        isUpperCase = isUpperCase ?? false,
        textOverflow = textOverflow ?? TextOverflow.clip,
        textDecoration = textDecoration ?? TextDecoration.none,
        fontWeight = FontWeight.w400;

  AppText.xsmallGreyMedium(this.text,
      {super.key,
      isCenter,
      isAsteriskVisible,
      isUpperCase,
      textOverflow,
      textDecoration})
      : color = AppColors.text_grey,
        fontSize = TextSize().xsmall,
        isCenter = isCenter ?? false,
        isAsteriskVisible = isAsteriskVisible ?? false,
        isUpperCase = isUpperCase ?? false,
        textOverflow = textOverflow ?? TextOverflow.clip,
        textDecoration = textDecoration ?? TextDecoration.none,
        fontWeight = FontWeight.w500;

  AppText.xsmallRedMedium(this.text,
      {super.key,
      isCenter,
      isAsteriskVisible,
      isUpperCase,
      textOverflow,
      textDecoration})
      : color = AppColors.text_asteriskColor_color,
        fontSize = TextSize().xsmall,
        isCenter = isCenter ?? false,
        isAsteriskVisible = isAsteriskVisible ?? false,
        isUpperCase = isUpperCase ?? false,
        textOverflow = textOverflow ?? TextOverflow.clip,
        textDecoration = textDecoration ?? TextDecoration.none,
        fontWeight = FontWeight.w500;

  //text_grey_g1
  AppText.smallGreyG1Regular(this.text,
      {super.key,
      isCenter,
      isAsteriskVisible,
      isUpperCase,
      textOverflow,
      textDecoration})
      : color = AppColors.text_grey_g1,
        fontSize = TextSize().small,
        isCenter = isCenter ?? false,
        isAsteriskVisible = isAsteriskVisible ?? false,
        isUpperCase = isUpperCase ?? false,
        textOverflow = textOverflow ?? TextOverflow.clip,
        textDecoration = textDecoration ?? TextDecoration.none,
        fontWeight = FontWeight.w400;

  //text_grey_g1
  AppText.smallGreyG1SemiBold(this.text,
      {super.key,
        isCenter,
        isAsteriskVisible,
        isUpperCase,
        textOverflow,
        textDecoration})
      : color = AppColors.text_grey_g1,
        fontSize = TextSize().small,
        isCenter = isCenter ?? false,
        isAsteriskVisible = isAsteriskVisible ?? false,
        isUpperCase = isUpperCase ?? false,
        textOverflow = textOverflow ?? TextOverflow.clip,
        textDecoration = textDecoration ?? TextDecoration.none,
        fontWeight = FontWeight.w600;

  AppText.xsmallGreyG1Medium(this.text,
      {super.key,
      isCenter,
      isAsteriskVisible,
      isUpperCase,
      textOverflow,
      textDecoration})
      : color = AppColors.text_grey_g1,
        fontSize = TextSize().xsmall,
        isCenter = isCenter ?? false,
        isAsteriskVisible = isAsteriskVisible ?? false,
        isUpperCase = isUpperCase ?? false,
        textOverflow = textOverflow ?? TextOverflow.clip,
        textDecoration = textDecoration ?? TextDecoration.none,
        fontWeight = FontWeight.w500;

  AppText.xsmallGreyG1Regular(this.text,
      {super.key,
      isCenter,
      isAsteriskVisible,
      isUpperCase,
      textOverflow,
      textDecoration})
      : color = AppColors.text_grey_g1,
        fontSize = TextSize().xsmall,
        isCenter = isCenter ?? false,
        isAsteriskVisible = isAsteriskVisible ?? false,
        isUpperCase = isUpperCase ?? false,
        textOverflow = textOverflow ?? TextOverflow.clip,
        textDecoration = textDecoration ?? TextDecoration.none,
        fontWeight = FontWeight.w400;

  // Greay Dark
  AppText.xxsmallGreyDarkRegular(this.text,
      {super.key,
      isCenter,
      isAsteriskVisible,
      isUpperCase,
      textOverflow,
      textDecoration})
      : color = AppColors.text_grey_dark,
        fontSize = TextSize().xxsmall,
        isCenter = isCenter ?? false,
        isAsteriskVisible = isAsteriskVisible ?? false,
        isUpperCase = isUpperCase ?? false,
        textOverflow = textOverflow ?? TextOverflow.clip,
        textDecoration = textDecoration ?? TextDecoration.none,
        fontWeight = FontWeight.w400;

  // Black Semi Bold
  AppText.xxsmallSemiBold(this.text,
      {super.key,
      isCenter,
      isAsteriskVisible,
      isUpperCase,
      textOverflow,
      textDecoration})
      : color = AppColors.black,
        fontSize = TextSize().xxsmall,
        isCenter = isCenter ?? false,
        isAsteriskVisible = isAsteriskVisible ?? false,
        isUpperCase = isUpperCase ?? false,
        textOverflow = textOverflow ?? TextOverflow.clip,
        textDecoration = textDecoration ?? TextDecoration.none,
        fontWeight = FontWeight.w600;

  //text_grey_g2
  AppText.xsmallGreyG2SemiBold(this.text,
      {super.key,
      isCenter,
      isAsteriskVisible,
      isUpperCase,
      textOverflow,
      textDecoration})
      : color = AppColors.text_grey_g2,
        fontSize = TextSize().xsmall,
        isCenter = isCenter ?? false,
        isAsteriskVisible = isAsteriskVisible ?? false,
        isUpperCase = isUpperCase ?? false,
        textOverflow = textOverflow ?? TextOverflow.clip,
        textDecoration = textDecoration ?? TextDecoration.none,
        fontWeight = FontWeight.w600;

  AppText.xsmallGreyG2Medium(this.text,
      {super.key,
      isCenter,
      isAsteriskVisible,
      isUpperCase,
      textOverflow,
      textDecoration})
      : color = AppColors.text_grey_g2,
        fontSize = TextSize().xsmall,
        isCenter = isCenter ?? false,
        isAsteriskVisible = isAsteriskVisible ?? false,
        isUpperCase = isUpperCase ?? false,
        textOverflow = textOverflow ?? TextOverflow.clip,
        textDecoration = textDecoration ?? TextDecoration.none,
        fontWeight = FontWeight.w500;

  AppText.smallGreyG2Regular(this.text,
      {super.key,
      isCenter,
      isAsteriskVisible,
      isUpperCase,
      textOverflow,
      textDecoration})
      : color = AppColors.text_grey_g2,
        fontSize = TextSize().small,
        isCenter = isCenter ?? false,
        isAsteriskVisible = isAsteriskVisible ?? false,
        isUpperCase = isUpperCase ?? false,
        textOverflow = textOverflow ?? TextOverflow.clip,
        textDecoration = textDecoration ?? TextDecoration.none,
        fontWeight = FontWeight.w400;

  //text_white
  AppText.smallWhiteBold(this.text,
      {super.key,
      isCenter,
      isAsteriskVisible,
      isUpperCase,
      textOverflow,
      textDecoration})
      : color = AppColors.white,
        fontSize = TextSize().small,
        isCenter = isCenter ?? false,
        isAsteriskVisible = isAsteriskVisible ?? false,
        isUpperCase = isUpperCase ?? false,
        textOverflow = textOverflow ?? TextOverflow.clip,
        textDecoration = textDecoration ?? TextDecoration.none,
        fontWeight = FontWeight.w700;

  AppText.xsmallWhiteBold(this.text,
      {super.key,
      isCenter,
      isAsteriskVisible,
      isUpperCase,
      textOverflow,
      textDecoration})
      : color = AppColors.white,
        fontSize = TextSize().xsmall,
        isCenter = isCenter ?? false,
        isAsteriskVisible = isAsteriskVisible ?? false,
        isUpperCase = isUpperCase ?? false,
        textOverflow = textOverflow ?? TextOverflow.clip,
        textDecoration = textDecoration ?? TextDecoration.none,
        fontWeight = FontWeight.w700;

  AppText.smallWhiteSemiBold(this.text,
      {super.key,
      isCenter,
      isAsteriskVisible,
      isUpperCase,
      textOverflow,
      textDecoration})
      : color = AppColors.white,
        fontSize = TextSize().small,
        isCenter = isCenter ?? false,
        isAsteriskVisible = isAsteriskVisible ?? false,
        isUpperCase = isUpperCase ?? false,
        textOverflow = textOverflow ?? TextOverflow.clip,
        textDecoration = textDecoration ?? TextDecoration.none,
        fontWeight = FontWeight.w600;

  AppText.smallWhiteRegular(this.text,
      {super.key,
      isCenter,
      isAsteriskVisible,
      isUpperCase,
      textOverflow,
      textDecoration})
      : color = AppColors.white,
        fontSize = TextSize().small,
        isCenter = isCenter ?? false,
        isAsteriskVisible = isAsteriskVisible ?? false,
        isUpperCase = isUpperCase ?? false,
        textOverflow = textOverflow ?? TextOverflow.clip,
        textDecoration = textDecoration ?? TextDecoration.none,
        fontWeight = FontWeight.w400;

  AppText.xsmallWhiteRegular(this.text,
      {super.key,
      isCenter,
      isAsteriskVisible,
      isUpperCase,
      textOverflow,
      textDecoration})
      : color = AppColors.white,
        fontSize = TextSize().xsmall,
        isCenter = isCenter ?? false,
        isAsteriskVisible = isAsteriskVisible ?? false,
        isUpperCase = isUpperCase ?? false,
        textOverflow = textOverflow ?? TextOverflow.clip,
        textDecoration = textDecoration ?? TextDecoration.none,
        fontWeight = FontWeight.w400;

  AppText.xxsmallWhiteRegular(this.text,
      {super.key,
      isCenter,
      isAsteriskVisible,
      isUpperCase,
      textOverflow,
      textDecoration})
      : color = AppColors.white,
        fontSize = TextSize().xxsmall,
        isCenter = isCenter ?? false,
        isAsteriskVisible = isAsteriskVisible ?? false,
        isUpperCase = isUpperCase ?? false,
        textOverflow = textOverflow ?? TextOverflow.clip,
        textDecoration = textDecoration ?? TextDecoration.none,
        fontWeight = FontWeight.w400;

//for inductee id card valid invalid
  AppText.idCardValidInvalidText(this.text,
      {super.key,
      isCenter,
      isAsteriskVisible,
      isUpperCase,
      textOverflow,
      textDecoration,
      color})
      : color = color ? AppColors.app_color_green : AppColors.app_color_red,
        fontSize = TextSize().small,
        isCenter = isCenter ?? false,
        isAsteriskVisible = isAsteriskVisible ?? false,
        isUpperCase = isUpperCase ?? false,
        textOverflow = textOverflow ?? TextOverflow.clip,
        textDecoration = textDecoration ?? TextDecoration.none,
        fontWeight = FontWeight.w600;

  //Custom Text For Work Permit Status
  AppText.xsmallCustomSemiBold(this.text,
      {super.key,
      isCenter,
      isAsteriskVisible,
      isUpperCase,
      textOverflow,
      required Color? color,
      textDecoration})
      : color = color!,
        fontSize = TextSize().xsmall,
        isCenter = isCenter ?? false,
        isAsteriskVisible = isAsteriskVisible ?? false,
        isUpperCase = isUpperCase ?? false,
        textOverflow = textOverflow ?? TextOverflow.clip,
        textDecoration = textDecoration ?? TextDecoration.none,
        fontWeight = FontWeight.w600;

  //Custom Text For Work Permit Status
  AppText.xsmallCustomMedium(this.text,
      {super.key,
      isCenter,
      isAsteriskVisible,
      isUpperCase,
      textOverflow,
      required Color? color,
      textDecoration})
      : color = color!,
        fontSize = TextSize().xsmall,
        isCenter = isCenter ?? false,
        isAsteriskVisible = isAsteriskVisible ?? false,
        isUpperCase = isUpperCase ?? false,
        textOverflow = textOverflow ?? TextOverflow.clip,
        textDecoration = textDecoration ?? TextDecoration.none,
        fontWeight = FontWeight.w500;

  //Custom Text For Work Permit Status
  AppText.xsmallCustomRegular(this.text,
      {super.key,
      isCenter,
      isAsteriskVisible,
      isUpperCase,
      textOverflow,
      required Color? color,
      textDecoration})
      : color = color!,
        fontSize = TextSize().xsmall,
        isCenter = isCenter ?? false,
        isAsteriskVisible = isAsteriskVisible ?? false,
        isUpperCase = isUpperCase ?? false,
        textOverflow = textOverflow ?? TextOverflow.clip,
        textDecoration = textDecoration ?? TextDecoration.none,
        fontWeight = FontWeight.w500;

  AppText.smallCustomRegular(this.text,
      {super.key,
      isCenter,
      isAsteriskVisible,
      isUpperCase,
      textOverflow,
      required Color? color,
      textDecoration})
      : color = color!,
        fontSize = TextSize().small,
        isCenter = isCenter ?? false,
        isAsteriskVisible = isAsteriskVisible ?? false,
        isUpperCase = isUpperCase ?? false,
        textOverflow = textOverflow ?? TextOverflow.clip,
        textDecoration = textDecoration ?? TextDecoration.none,
        fontWeight = FontWeight.w500;

  AppText.smallCustomSemiBold(this.text,
      {super.key,
      isCenter,
      isAsteriskVisible,
      isUpperCase,
      textOverflow,
      required Color? color,
      textDecoration})
      : color = color!,
        fontSize = TextSize().small,
        isCenter = isCenter ?? false,
        isAsteriskVisible = isAsteriskVisible ?? false,
        isUpperCase = isUpperCase ?? false,
        textOverflow = textOverflow ?? TextOverflow.clip,
        textDecoration = textDecoration ?? TextDecoration.none,
        fontWeight = FontWeight.w600;

  AppText.largeGreyBold(this.text,
      {super.key,
      isCenter,
      isAsteriskVisible,
      isUpperCase,
      textOverflow,
      textDecoration})
      : color = AppColors.text_grey,
        fontSize = TextSize().small,
        isCenter = isCenter ?? false,
        isAsteriskVisible = isAsteriskVisible ?? false,
        isUpperCase = isUpperCase ?? false,
        textOverflow = textOverflow ?? TextOverflow.clip,
        textDecoration = textDecoration ?? TextDecoration.none,
        fontWeight = FontWeight.w700;

  AppText.mediumGreyBold(this.text,
      {super.key,
      isCenter,
      isAsteriskVisible,
      isUpperCase,
      textOverflow,
      textDecoration})
      : color = AppColors.text_grey,
        fontSize = TextSize().medium,
        isCenter = isCenter ?? false,
        isAsteriskVisible = isAsteriskVisible ?? false,
        isUpperCase = isUpperCase ?? false,
        textOverflow = textOverflow ?? TextOverflow.clip,
        textDecoration = textDecoration ?? TextDecoration.none,
        fontWeight = FontWeight.w700;

  @override
  Widget build(BuildContext context) {
    final displayText =
    Validation().isValid(text) ? text! : AppStrings().blank;

    final textWidget = Text(
      isUpperCase ? displayText.toUpperCase() : displayText.toString(),
      overflow: textOverflow,
      softWrap: true,
      style: TextStyle(
          color: color,
          fontWeight: fontWeight,
          fontStyle: FontStyle.normal,
          fontFamily: FontFamily.fontFamily,
          decoration: textDecoration,
          //letterSpacing: AppSizes().letterSpacing,
          height: AppSizes().letterHeight,
          fontSize: fontSize),
      textAlign: isCenter ? TextAlign.center : TextAlign.left,
    );

    if (!isAsteriskVisible) {
      return Align(
        alignment: isCenter ? Alignment.center : Alignment.centerLeft,
        child: textWidget,
      );
    }

    return Align(
      alignment: isCenter ? Alignment.center : Alignment.centerLeft,
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Flexible(
          fit: FlexFit.loose,
          child: textWidget,
        ),
        Text(
          AppStrings().asterisk,
          overflow: textOverflow,
          softWrap: true,
          style: TextStyle(
              color: AppColors.text_asteriskColor_color,
              fontWeight: fontWeight,
              fontStyle: FontStyle.normal,
              fontFamily: FontFamily.fontFamily,
              decoration: textDecoration,
              //letterSpacing: AppSizes().letterSpacing,
              height: AppSizes().letterHeight,
              fontSize: fontSize),
          textAlign: isCenter ? TextAlign.center : TextAlign.left,
        )
      ]),
    );
  }
}
