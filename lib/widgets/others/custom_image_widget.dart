// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomImageWidget extends StatelessWidget {
  const CustomImageWidget({
    Key? key,
    required this.path,
    this.height = 20.00,
    this.width = 25.00,
    this.scale = 1.0,
    this.borderRadius = BorderRadius.zero,
    this.color,
  }) : super(key: key);

  final String path;
  final double? height;
  final double? width;
  final double scale;
  final BorderRadiusGeometry? borderRadius;
  final Color? color;

  String getFileExtension(String fileName) {
    try {
      return ".${fileName.split('.').last}";
    } catch (e) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final extension = getFileExtension(path);
    return extension == '.svg'
        ? ClipRRect(
            borderRadius: borderRadius ?? BorderRadius.zero,
            child: SvgPicture.asset(
              path,
              height: height,
              width: width,
              color: color,
            ),
          )
        : ClipRRect(
            borderRadius: borderRadius ?? BorderRadius.zero,
            child: Image.asset(
              path,
              scale: scale,
              height: height,
              width: width,
            ),
          );
  }
}
