import 'package:flutter/material.dart';

class NewsCategory extends StatelessWidget {
  const NewsCategory({super.key, required this.color, required this.categoryName, required this.onTap, this.width, this.height});
  final Color? color;
  final String categoryName;
  final double? width;
  final double? height;
  final VoidCallback onTap;

  
  @override
  Widget build(BuildContext context) {


    return InkWell(
      onTap: onTap,


      child: Container(
        margin: const EdgeInsets.all(10.0),
        width: width!=0.0 ?  width : MediaQuery.of(context).size.width /2 -30,
        height: height != 0.0 ?  height : 80.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: color,
        ),
        child: Center(
          child: Text(categoryName,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
        ),
      ),
    );
  }
}