import 'package:flutter/material.dart';
import 'package:hovee_attendence/widget/custom_texts.dart';
import 'package:hovee_attendence/widget/space.dart';

class AnimatedDialog extends StatelessWidget {
  final String message;
  final String? imageString;

  const AnimatedDialog({super.key, required this.message, this.imageString});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: const Duration(seconds: 1),
      tween: Tween(
        begin: const Offset(0, 1),
        end: const Offset(0, 0),
      ),
      builder: (context, Offset offset, child) {
        return Transform.translate(
          offset: offset,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: imageString != null ? 100 : 70,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (imageString != null)
                      SizedBox(
                        height: 40,
                        child: Center(
                          child: Image(
                            image: AssetImage(imageString!),
                          ),
                        ),
                      ),
                    if (imageString != null) space(h: 4),
                    regularText(
                      text: message,
                      fontSize: 17,
                      color: Colors.black.withOpacity(0.66),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
