import 'dart:math' as m;

import 'package:xremitpro/utils/basic_screen_imports.dart';
import 'package:xremitpro/widgets/logo/basic_logo_widget.dart';

class AnimatedButton extends StatefulWidget {
  const AnimatedButton({super.key, this.onComplete});

  final VoidCallback? onComplete;

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animation = Tween<double>(begin: 0, end: 1).animate(controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          widget.onComplete?.call();
          controller.reset();
        }
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _onLongPressStart(LongPressStartDetails details) {
    controller.reset();
    controller.forward();
  }

  void _onLongPressEnd(LongPressEndDetails details) {
    controller.reset();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.2,
      child: ClipRRect(
        child: GestureDetector(
          onLongPressStart: _onLongPressStart,
          onLongPressEnd: _onLongPressEnd,
          child: AnimatedBuilder(
              animation: controller,
              builder: (context, snapshot) {
                return CustomPaint(
                  painter: ArcShapePainter(
                    progress: animation.value,
                    radius: MediaQuery.of(context).size.width,
                    color: CustomColor.primaryLightColor,
                    strokeWidth: 6,
                  ),
                  child: Column(
                    crossAxisAlignment: crossCenter,
                    mainAxisAlignment: mainCenter,
                    children: [
                      //Logo
                      BasicLogoWidget(
                        isWhite: true,
                        isDashBoard: true,
                      ),
                      verticalSpace(Dimensions.heightSize),
                      //Text
                      TitleHeading2Widget(
                        text: Strings.tabAndHold,
                        color: CustomColor.whiteColor,
                        opacity: 0.5,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}

//Arc shape painter
class ArcShapePainter extends CustomPainter {
  //Define constructor parameters
  late double progress;
  late double radius;
  late Color color;
  late double strokeWidth;

  //Define private variables
  late Paint _linePaint;
  late Paint _solidPaint;
  late Path _path;

  //Create constructor and initialize private variables
  ArcShapePainter(
      {required this.color,
      this.progress = .5,
      this.radius = 400,
      this.strokeWidth = 4}) {
    _linePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    _solidPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    //First define the cord length and bound the angle
    var cordLength = size.width + 4;
    if (radius <= (cordLength * .5) + 16) radius = (cordLength * .5) + 16;
    if (radius >= 600) radius = 600;

    //Define required angles
    var arcAngle = m.asin((cordLength * .5) / radius) * 2;
    var startAngle = (m.pi + m.pi * .5) - (arcAngle * .5);
    var progressAngle = arcAngle * progress;

    //Define center of the available screen
    Offset center = Offset((cordLength * .5) - 2, radius + 8);

    //Draw the line arc
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle,
        progressAngle, false, _linePaint);

    //Draw the solid arc path
    _path = Path();
    _path.arcTo(Rect.fromCircle(center: center, radius: radius), startAngle,
        arcAngle, true);
    _path.lineTo(size.width, size.height);
    _path.lineTo(0, size.height);
    _path.close();

    //Draw some shadow over the solid arc
    canvas.drawShadow(
        _path.shift(const Offset(0, 1)), Colors.transparent, 3, true);

    //Draw the solid arc using path
    canvas.drawPath(_path.shift(const Offset(0, 12)), _solidPaint);
  }

  @override
  bool hitTest(Offset position) {
    //Accept long pressing only for the solid arc
    return _path.contains(position);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // Make it conditionally return for release build
    // For now I am making always true
    return true;
  }
}
