import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../utils/custom_color.dart';

class CustomLoadingAPI extends StatelessWidget {
  const CustomLoadingAPI({
    Key? key,
    this.color,
  }) : super(key: key);
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitWaveSpinner(
        color: color ?? CustomColor.primaryLightColor,
      ),
    );
  }
}
