import 'package:flutter/material.dart';
import 'package:my_app_flutter/utilities/hexColor.dart';

class PopularSearch extends StatelessWidget {
  const PopularSearch({Key? key}) : super(key: key);

  // Expanded _popularBox() {
  //   return Expanded(
  //     flex: 1,
  //     child: Column(
  //       children: <Widget>[Text('Bangkok')],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      margin: const EdgeInsets.only(
        left: 10.0,
        top: 20.0,
        right: 10.0,
        bottom: 10.0,
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.all(15),
              child: const Text(
                'POPULAR SEARCH',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Row(
            // spacing: 10,
            // direction: Axis.horizontal,
            // runSpacing: 10,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                    height: 50,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: HexColor.fromHex('#F0F0F0'),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 7,
                        )
                      ],
                    )),
              ),
              Expanded(
                flex: 1,
                child: Container(
                    height: 50,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: HexColor.fromHex('#F0F0F0'),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 7,
                        )
                      ],
                    )),
              ),
              Expanded(
                flex: 1,
                child: Container(
                    height: 50,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: HexColor.fromHex('#F0F0F0'),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 7,
                        )
                      ],
                    )),
              ),
            ],
          )
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: HexColor.fromHex('#F0F0F0'),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
          )
        ],
      ),
    );
  }
}
