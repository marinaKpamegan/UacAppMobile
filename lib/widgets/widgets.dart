import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CircleImage extends StatelessWidget {
  final String asset;
  final double size;

  const CircleImage(this.asset, this.size);
  @override
  Widget build(BuildContext context) {
    double _size = size;

    return Center(
      child: new Container(
          width: _size,
          height: _size,
          decoration: new BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Color.fromRGBO(112, 226, 156, 1).withOpacity(0.5), width: 0.5),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(3.0, 3.0),
                  blurRadius: 5.0,
                  spreadRadius: 2.0,
                  color: Colors.white.withOpacity(0.4)
                )
              ],
              image: new DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/$asset"),

              )
          )
      ),
    );
  }

}
