import '../../utils/basic_screen_imports.dart';

//Add this CustomPaint widget to the Widget Tree

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(414.5, 30.8734);
    path_0.cubicTo(290, -11.0377, 120, -9.53775, 0, 30.8734);
    path_0.lineTo(0, 150.873);
    path_0.lineTo(414.5, 150.873);
    path_0.lineTo(414.5, 30.8734);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color =CustomColor.primaryDarkColor.withOpacity(1.0);
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
