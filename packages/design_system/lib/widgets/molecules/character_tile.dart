import 'package:design_system/design_system.dart';
import 'package:external_dependencies/external_dependencies.dart';
import 'package:flutter/material.dart';

class CharacterTile extends StatelessWidget {
  final String imagePath;
  final String? characterName;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final BorderRadiusGeometry? borderRadius;
  final double? shadowHeight;
  final LinearGradient? gradient;

  const CharacterTile({
    required this.imagePath,
    this.characterName,
    this.onTap,
    this.width,
    this.height,
    this.borderRadius,
    this.shadowHeight,
    this.gradient,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          image: DecorationImage(
            image: NetworkImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: shadowHeight,
                decoration: BoxDecoration(
                  gradient: gradient ??
                      LinearGradient(
                        colors: [
                          context.colors.secondary.withOpacity(.7),
                          context.colors.secondary.withOpacity(.7),
                          Colors.transparent,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                ),
                child: Center(
                  child: Text(
                    characterName ?? '',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.visible,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                      .animate(delay: 500.milliseconds)
                      .fade(duration: 800.milliseconds),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
