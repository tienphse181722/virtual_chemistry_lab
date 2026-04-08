import 'package:flutter/material.dart';
import 'package:virtual_chemistry_lab/constants/colors.dart';

class AppLogo extends StatelessWidget {
  final double size;
  
  const AppLogo({
    super.key,
    this.size = 166,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.grey,
      ),
      child: ClipOval(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Placeholder: Science icon (replace with actual logo image)
            // To use actual logo, uncomment below and add image to assets:
            // Image.asset(
            //   'assets/images/chemlearn_logo.png',
            //   width: size * 1.3,
            //   height: size * 1.3,
            //   fit: BoxFit.cover,
            // ),
            
            // Temporary icon placeholder
            Icon(
              Icons.science_outlined,
              size: size * 0.48,
              color: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
