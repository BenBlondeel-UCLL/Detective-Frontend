import 'package:detective/constants/sizes.dart';
import 'package:flutter/material.dart';

class PaddingStyle {
  static const EdgeInsetsGeometry paddingWithAppBarHeight = EdgeInsets.only(
    top: Sizes.headerHeight,
    left: Sizes.defaultSpace,
    bottom: Sizes.defaultSpace,
    right: Sizes.defaultSpace,
  );
}