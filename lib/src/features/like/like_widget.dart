import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  final bool isLiked;
  final Function()? onTap;

  const LikeButton({super.key, required this.isLiked, required this.onTap});

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  double cur = 40;
  double target = 70;

  @override
  Widget build(BuildContext context) {
    cur = widget.isLiked ? 70 : 40;
    target = widget.isLiked ? 70 : 40;
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 500),
      tween: Tween<double>(begin: cur, end: target),
      builder: (BuildContext context, double val, Widget? child) {
        return Padding(
          padding: EdgeInsets.only(right: (40 - val / 2)),
          child: GestureDetector(
            onTap: () {
              widget.onTap!();
              target = target == 40 ? 70 : 40;
            },
            child: Icon(
              size: val,
              widget.isLiked ? Icons.favorite : Icons.favorite_border,
              color: widget.isLiked ? Colors.red : Colors.grey,
            ),
          ),
        );
      },
    );
  }
}
