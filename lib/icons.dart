import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget svgIcon(String path, {double size = 24}) =>
    SvgPicture.asset(path, width: size, height: size);