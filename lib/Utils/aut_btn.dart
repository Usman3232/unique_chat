import 'package:flutter/material.dart';

// class AutBtn extends StatelessWidget {
//   final double? height;
//   final double? width;
//   final Color? colour;
//   final String? text;
//   //VoidCallback callback;
// //Function callback;

//   const AutBtn(
//       {Key? key,
//       this.height,
//       this.width,
//       this.colour,
//       this.text,
//       //required this.callback
//       })
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration:
//           BoxDecoration(color: colour, borderRadius: BorderRadius.circular(10)),
//       height: height,
//       width: width,
//       child: Center(
//         child: GestureDetector(
//           onTap: () {
//            // callback();
//           },
//           child: Text(
//             text!,
//             style: TextStyle(fontSize: 20, color: Colors.white),
//           ),
//         ),
//       ),
//     );
//   }
// }

class CustomAuthButton extends StatelessWidget {
  String title;
  final double? height;
  final double? width;
  final Color? colour,textcolour;

  // Function callback;
  VoidCallback callback;
  CustomAuthButton(
      {Key? key,
      this.title = "",
      required this.callback,
      this.colour,this.textcolour = Colors.white,
      this.height,
      this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: MaterialButton(
        height: height,
        minWidth: width,
        color: colour,
        onPressed: () {
          callback();
        },
        child: Text(
          title,
          style: TextStyle(fontSize: 20, color: textcolour),
        ),
      ),
    );
  }
}
