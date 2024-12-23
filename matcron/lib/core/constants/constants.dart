import 'package:flutter/material.dart';
import 'package:matcron/config/theme/app_theme.dart';
import 'package:matcron/config/config.dart';


//Apis
const String userAPIBaseURL = '${Config.prodBaseUrl}/auth';
const String mattressAPIBaseUrl = '${Config.prodBaseUrl}/mattress';
const String dashboardAPIBaseUrl = '${Config.prodBaseUrl}/dashboard';
const String organizationBaseUrl = '${Config.prodBaseUrl}/Organisation';
const String typeBaseUrl = '${Config.prodBaseUrl}/mattresstype';
const String mattressBaseUrl = '${Config.prodBaseUrl}/mattress';

// UI
const double matcronTextFieldBorderRadius = 50;
Color matcronPrimaryColor = HexColor("#50C2C9");
const progressBarLabels = ["Select", "Tap RFID", "Finished"];



/// margin
double kMargin = 14.0;

/// bottom bar height
double kHeight = 62.0;

/// notch circle circle radius
const double kCircleRadius = 30.0;

/// margin between notch and circle
const double kCircleMargin = 8.0;

/// top radius
double kTopRadius = 10.0;

/// top margin
const double kTopMargin = 10.0;

/// bottom radius
double kBottomRadius = 28.0;

/// bottom bar item size
const double kIconSize = 24.0;

/// Pi value
const double kPi = 3.1415926535897932;