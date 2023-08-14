import 'package:dashboard/utils/utils.dart';
import 'package:flutter/material.dart';
// ignore: must_be_immutable
class ContainerBlock extends StatelessWidget {
  Widget content;
  double radius;
  EdgeInsets padding;
  EdgeInsets margin;
  double boxWidth;
  double boxHeight;
  BoxDecoration decoration;
  bool canAddDecoration;
  ContainerBlock({super.key,this.content = const SizedBox(),this.radius = 30,this.padding = const  EdgeInsets.all(0),this.boxWidth = 0,this.boxHeight = 0,this.margin = const EdgeInsets.all(0),this.decoration = const BoxDecoration(),this.canAddDecoration = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      width: boxWidth <= 0 ? null : boxWidth,
      height: boxHeight <= 0 ? null : boxHeight,
      decoration: canAddDecoration ? decoration : BoxDecoration(
       color: contentWidgetColor,
       borderRadius: BorderRadius.all(Radius.circular(radius)),
       boxShadow: const [
       BoxShadow(
        color: Color.fromARGB(59, 189, 181, 181),
        offset: Offset(-1.0, -1.0),
        blurRadius: 2,
        spreadRadius: 2,
       ),
       BoxShadow(
        color: Color(0xFFF9FAFC),
        offset: Offset(-2.0, -2.0),
       ),
       ]
      ),
      child: content,
    );
  }
}