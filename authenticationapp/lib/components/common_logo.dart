import 'package:flutter/material.dart';

class CommonLogo extends StatelessWidget {
  const CommonLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      // ignore: sort_child_properties_last
      backgroundColor: Colors.white,
      // ignore: sort_child_properties_last
      child: Image.network(
        'https://i.ibb.co/RQ54qzh/wingman.jpg',
        width: 60,
        height: 60,
      ),
      maxRadius: 40,
    );
  }
}
