import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Abstract class FontStyles that contains all the possible styles
/// that can have the texts inside the Application
abstract class FontStyles {
  ///Defining a textTheme variable using OpenSans font family of Google Fonts
  static final TextTheme textTheme = GoogleFonts.openSansTextTheme();

  /// Font style for titles
  static final title = GoogleFonts.openSans(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  /// Font style for subtitles
  static final subtitle = GoogleFonts.openSans(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  /// ExtraBold font style
  static final extraBold = GoogleFonts.openSans(
    fontWeight: FontWeight.w800,
  );

  /// Bold font style
  static final bold = GoogleFonts.openSans(
    fontWeight: FontWeight.w700,
  );

  /// SemiBold font style
  static final semiBold = GoogleFonts.openSans(
    fontWeight: FontWeight.w600,
  );

  /// Medium font style
  static final medium = GoogleFonts.openSans(
    fontWeight: FontWeight.w500,
  );

  /// Regular font style
  static final regular = GoogleFonts.openSans(
    fontWeight: FontWeight.w400,
  );

  /// Light font style
  static final light = GoogleFonts.openSans(
    fontWeight: FontWeight.w300,
  );
}
