// ignore: file_names
import 'package:flutter/material.dart';
import '../presentation/resources/color_manager.dart';

// ignore: must_be_immutable
class CheckboxRow extends StatefulWidget {
  bool switchVal;
  String title;
  Color backColor;
  Color iconColor;
  IconData iconData;
  CheckboxRow({super.key,required this.switchVal,required this.title,required this.iconColor,required this.backColor,required this.iconData});

  @override
  // ignore: no_logic_in_create_state
  State<CheckboxRow> createState() => _CheckboxRowState(switchVal: switchVal,title: title,iconColor: iconColor,backColor: backColor,iconData: iconData);
}

class _CheckboxRowState extends State<CheckboxRow> {
  bool switchVal;
  String title;
  Color backColor;
  Color iconColor;
  IconData iconData;
  _CheckboxRowState({required this.switchVal,required this.title,required this.iconColor,required this.backColor,required this.iconData});
  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        // border: Border.all(
        //   color: Colors.grey.withOpacity(0.2),
        // ),
      ),
      child: ListTile(
        leading: _iconBtn(backColor: backColor, icon: iconData,iconColor: iconColor),
        title: Text(title,style: const TextStyle(color: Colors.grey,fontWeight: FontWeight.normal,fontSize: 17),),
        trailing: Checkbox(
            activeColor: ColorManager.primary,
            checkColor: Colors.white,
            value: switchVal,
            onChanged: (pref){
              setState(() {
                switchVal = pref!;
              });
            }),
      ),
    );
  }

  Widget _iconBtn(
      {required Color backColor,
        required IconData icon,
      required iconColor}) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: 40,
      width: 40,
      decoration: BoxDecoration(
          color: backColor, borderRadius: BorderRadius.circular(12)),
      child: Icon(icon,color: iconColor,),
    );
  }
}
