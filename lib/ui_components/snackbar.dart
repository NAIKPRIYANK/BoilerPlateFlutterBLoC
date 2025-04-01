
import 'package:flutter/material.dart';

class Snakbar{
  static void showSnakbar(BuildContext context,{required String text,required Color color}){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text),backgroundColor: color,));
  }
}