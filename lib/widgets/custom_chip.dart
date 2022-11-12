import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  const CustomChip({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      elevation: 20,
      padding: const EdgeInsets.all(8),
      backgroundColor: Colors.greenAccent[100],
      shadowColor: Colors.black,
      avatar: const CircleAvatar(
        backgroundImage: NetworkImage(
            "https://pbs.twimg.com/profile_images/1304985167476523008/QNHrwL2q_400x400.jpg"), //NetworkImage
      ), //CircleAvatar
      label: const Text(
        'GeeksforGeeks',
        style: TextStyle(fontSize: 20),
      ), //Text
    );
  }
}
