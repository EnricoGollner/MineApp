import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mine_app/src/core/theme/app_colors.dart';
import 'package:sizer/sizer.dart';

TextStyle get dropdownLabelStyle => GoogleFonts.roboto(
      fontSize: SizerUtil.deviceType == DeviceType.mobile ? 12 : 20,
      fontWeight: FontWeight.w500,
      color: colorOnSurface,
    );

TextStyle get dropdownTextStyle => GoogleFonts.roboto(fontSize: SizerUtil.deviceType == DeviceType.mobile ? 14 : 20,
      fontWeight: FontWeight.w500,
      color: colorOnPrimary,
    );

TextStyle get dropdownHintRunningStyle => GoogleFonts.roboto(
      fontSize: SizerUtil.deviceType == DeviceType.mobile ? 14 : 20,
      fontWeight: FontWeight.w500,
      color: colorSecondary,
    );

TextStyle get dropdownHintLossStyle => GoogleFonts.roboto(
      fontSize: SizerUtil.deviceType == DeviceType.mobile ? 14 : 20,
      fontWeight: FontWeight.w500,
      color: colorError,
    );
    
TextStyle get textFieldLabelMinorStyle => GoogleFonts.roboto(
      fontSize: SizerUtil.deviceType == DeviceType.mobile ? 10 : 20,
      fontWeight: FontWeight.w500,
      color: colorOnSurface,
    );

TextStyle get textFieldStyle => GoogleFonts.roboto(
      fontSize: SizerUtil.deviceType == DeviceType.mobile ? 14 : 20,
      fontWeight: FontWeight.w400,
      color: colorOnPrimary,
    );

TextStyle get hintTextStyle => GoogleFonts.roboto(
      fontSize: SizerUtil.deviceType == DeviceType.mobile ? 13 : 19,
      fontWeight: FontWeight.w400,
      color: colorOnPrimary,
    );

TextStyle get snackbarMessageStyle => GoogleFonts.roboto(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: colorOnPrimary,
    );
