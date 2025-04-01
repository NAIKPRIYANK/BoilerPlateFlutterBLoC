
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_rating_stars/flutter_rating_stars.dart';
// import 'package:sanyojak_app/presentation/resources/color_manager.dart';
// // import 'package:sanyojak_app/presentation/screens/rateUs/bloc.dart';
// // import 'package:sanyojak_app/presentation/screens/rateUs/event.dart';

// class RatingStar extends StatefulWidget {
//   const RatingStar({super.key});

//   @override
//   _RatingStarState createState() => _RatingStarState();
// }

// class _RatingStarState extends State<RatingStar> {
//   double value = 3.5;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         const SizedBox(height: 30,),
//         const Divider(height: 10),
        
//         RatingStars(
//           axis: Axis.horizontal,
//           value: value,
//           onValueChanged: (v) {
           
//             setState(() {
//               value = v;
//                //context.read<RateUsBloc>().add(ValueEvent(value: v));
              
//             });
//           },
//           starCount: 5,
//           starSize: 35,
//           valueLabelColor: const Color(0xff9b9b9b),
//           valueLabelTextStyle: const TextStyle(
//               color: Colors.black,
//               fontWeight: FontWeight.w400,
//               fontStyle: FontStyle.normal,
//               fontSize: 12.0),
//           valueLabelRadius: 10,
//           maxValue: 5,
//           starSpacing: 20,
//           maxValueVisibility: true,
//           valueLabelVisibility: true,
          
//           animationDuration: const Duration(milliseconds: 1000),
//           valueLabelPadding:
//               const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
//           valueLabelMargin: const EdgeInsets.only(right: 8),
//           starOffColor: const Color.fromARGB(255, 204, 227, 225),
//           starColor: ColorManager.tabColor,
          
//           angle: 5,
//         ),
//       ],
//     );
//   }
// }