import 'package:flutter/material.dart';

class UserHeader extends StatelessWidget {
  final String name;
  final String profileImageUrl;

  const UserHeader({
    super.key,
    required this.name,
    required this.profileImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hello,",
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
            Text(
              name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(profileImageUrl),
        ),
      ],
    );
  }
}
