import 'package:flutter/material.dart';

Widget StudentIdentity(BuildContext context) {



  int _value = 1;
  return Container(
    child: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: ScrollPhysics(),
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 120,
                child: Text("Civilité:"),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                height: 50,
                margin: EdgeInsets.only(bottom: 15, left: 10),
                width: MediaQuery.of(context).size.width - 150,
                child: DropdownButton(style: TextStyle(color: Colors.black),
                  items: [
                    DropdownMenuItem(
                      child: Text("Docteur"),
                      value: 1,
                    ),
                    DropdownMenuItem(
                      child: Text("Madame"),
                      value: 2,
                    ),
                    DropdownMenuItem(
                      child: Text("Monsieur"),
                      value: 3,
                    ),
                    DropdownMenuItem(
                      child: Text("Professeur"),
                      value: 4,
                    ),
                    DropdownMenuItem(
                      child: Text("Rd Père"),
                      value: 5,
                    )
                  ],
                  // TODO: find another way to change value
                  onChanged: (value) {

                  },
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 120,
                child: Text("Nom:"),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                height: 50,
                margin: EdgeInsets.only(bottom: 15),
                width: MediaQuery.of(context).size.width - 150,
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 120,
                child: Text("Prénoms:"),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                height: 50,
                margin: EdgeInsets.only(bottom: 15),
                width: MediaQuery.of(context).size.width - 150,
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              )
            ],
          ),
          Row(
            children: [
              Container(
                width: 120,
                child: Text("Sexe:"),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                height: 50,
                margin: EdgeInsets.only(bottom: 15),
                width: MediaQuery.of(context).size.width - 150,
                child: DropdownButton(
                  items: [
                    DropdownMenuItem(
                      child: Text("femme"),
                      value: 1,
                    ),
                    DropdownMenuItem(
                      child: Text("homme"),
                      value: 2,
                    ),

                  ],
                  // TODO: find another way to change value
                  onChanged: (value) {

                  },
                ),
              )
            ],
          ),
        ],
      ),
    ),
  );
}
