import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:my_app_flutter/datamodels/user_location.dart';

class Map extends StatelessWidget {
  const Map({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userLocation = Provider.of<UserLocation>(context);
    var string =
        'userLocation: (${userLocation.latitude}, ${userLocation.longitude})';
    print(string);
    return SafeArea(
      child: Column(
        children: [
          Text(
            string,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          TextButton(
            onPressed: () async {
              // var test = await LocationService().getLocation();
            },
            child: const Text(
              'Test getLocation',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}
