import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget {
  final SocialType type;
  final VoidCallback onTap;

  const SocialLoginButton({
    super.key,
    required this.type,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          print('Social button tapped: ${type.name}');
          onTap();
        },
        customBorder: const CircleBorder(),
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipOval(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                type == SocialType.facebook
                    ? 'assets/images/facebook_logo.png'
                    : 'assets/images/google_logo.png',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback to custom painted logo if image not found
                  return type == SocialType.facebook
                      ? _buildFacebookLogo()
                      : _buildGoogleLogo();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFacebookLogo() {
    return Center(
      child: CustomPaint(
        size: const Size(24, 24),
        painter: FacebookLogoPainter(),
      ),
    );
  }

  Widget _buildGoogleLogo() {
    return Center(
      child: CustomPaint(
        size: const Size(24, 24),
        painter: GoogleLogoPainter(),
      ),
    );
  }
}

class FacebookLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path();
    // Facebook 'f' logo path
    path.moveTo(size.width * 0.5, size.height * 0.2);
    path.lineTo(size.width * 0.65, size.height * 0.2);
    path.lineTo(size.width * 0.65, size.height * 0.4);
    path.lineTo(size.width * 0.5, size.height * 0.4);
    path.lineTo(size.width * 0.5, size.height * 0.95);
    path.lineTo(size.width * 0.35, size.height * 0.95);
    path.lineTo(size.width * 0.35, size.height * 0.4);
    path.lineTo(size.width * 0.25, size.height * 0.4);
    path.lineTo(size.width * 0.25, size.height * 0.25);
    path.lineTo(size.width * 0.35, size.height * 0.25);
    path.lineTo(size.width * 0.35, size.height * 0.15);
    path.quadraticBezierTo(
      size.width * 0.35,
      size.height * 0.05,
      size.width * 0.45,
      size.height * 0.05,
    );
    path.lineTo(size.width * 0.5, size.height * 0.05);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class GoogleLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2.5;

    // Blue section
    final bluePaint = Paint()
      ..color = const Color(0xFF587DBD)
      ..style = PaintingStyle.fill;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -0.5,
      1.5,
      true,
      bluePaint,
    );

    // Red section
    final redPaint = Paint()
      ..color = const Color(0xFFE33629)
      ..style = PaintingStyle.fill;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -2.8,
      1.3,
      true,
      redPaint,
    );

    // Yellow section
    final yellowPaint = Paint()
      ..color = const Color(0xFFF8BD00)
      ..style = PaintingStyle.fill;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      2.8,
      1.0,
      true,
      yellowPaint,
    );

    // Green section
    final greenPaint = Paint()
      ..color = const Color(0xFF319F43)
      ..style = PaintingStyle.fill;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      1.0,
      1.8,
      true,
      greenPaint,
    );

    // White center circle
    final whitePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius * 0.5, whitePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

enum SocialType { facebook, google }
