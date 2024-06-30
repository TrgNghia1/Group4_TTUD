import 'package:flutter/material.dart';

class Card_i4 extends StatefulWidget {
  final List<int> list;
  final int sum;

  Card_i4({required this.list, required this.sum});
  @override
  State<Card_i4> createState() => _Card_i4State();
}

class _Card_i4State extends State<Card_i4> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 1,
            offset: Offset(1, 2),
          ),
        ],
      ),
      width: MediaQuery.of(context).size.width * 0.9,
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Row(

          children: [
            Container(
              width: (MediaQuery.of(context).size.width*0.9 - 30) * 0.65,
              child: Text(
                widget.list.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),

              ),
            ),

            Container(
              child: Text(
                widget.sum.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}