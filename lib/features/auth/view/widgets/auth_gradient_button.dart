import 'package:flutter/material.dart';
import 'package:mospotify/core/theme/app_pallete.dart';

class AuthGradientButton extends StatelessWidget {
  const AuthGradientButton({super.key, required this.buttonText, required this.onTap});
  final String buttonText;
  final VoidCallback onTap;


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        gradient: const LinearGradient(colors:
            [Pallete.gradient1,Pallete.gradient2],
            begin: Alignment.bottomLeft,
            end:Alignment.topRight )
      ),
      child: ElevatedButton(onPressed: onTap,
        child: Text(buttonText,
        style: TextStyle(fontWeight: FontWeight.w600,fontSize: 17)),
      style:ElevatedButton.styleFrom(
        backgroundColor: Pallete.transparentColor,
          shadowColor: Pallete.transparentColor,
          fixedSize: const Size(395, 55)
      ) ,),
    );
  }
}
