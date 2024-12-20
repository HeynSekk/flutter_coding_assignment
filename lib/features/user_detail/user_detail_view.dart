import 'package:flutter/material.dart';

import '../../models/user.dart';

class UserDetailPage extends StatelessWidget {
  const UserDetailPage({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //user id
            InfoWidget(title: 'ID', description: user.id.toString()),
            const SizedBox(
              height: 16,
            ),
            //name
            InfoWidget(title: 'Name', description: user.name ?? '<No name>'),
            const SizedBox(
              height: 16,
            ),
            //website
            InfoWidget(
                title: 'Website', description: user.website ?? '<No website>'),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}

class InfoWidget extends StatelessWidget {
  final String title;
  final String description;

  const InfoWidget({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    return SizedBox(
      width: sw - 32,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8), // Space between title and description
          Text(
            description,
            style: TextStyle(
              color: Colors.grey[600], // Grey color for the description
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
