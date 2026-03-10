import 'package:basic_crud_app/widgets/details_row_widget.dart';
import 'package:flutter/material.dart';
import '../models/models.dart';

class UserDetailScreen extends StatelessWidget {
  final Users user;

  const UserDetailScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name ?? 'User Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 60,
                child: Text(
                  user.name![0].toUpperCase(),
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildDetailRow('Name', user.name ?? ''),
                    buildDetailRow('Email', user.email ?? ''),
                    buildDetailRow('Phone', user.phone ?? ''),
                    buildDetailRow('Website', user.website ?? ''),
                    buildDetailRow('Company', user.company?.name ?? ''),
                    buildDetailRow('City', user.address?.city ?? ''),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}