import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/user_controller.dart';
import '../models/models.dart';
import 'user_detail_screen.dart';

class UserListScreen extends StatelessWidget {
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users List'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => userController.refreshUsers(),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) => userController.searchUsers(value),
              decoration: InputDecoration(
                hintText: 'Search users...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (userController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else if (userController.errorMessage.value.isNotEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(userController.errorMessage.value),
                      ElevatedButton(
                        onPressed: () => userController.fetchUsers(),
                        child: Text('Retry'),
                      ),
                    ],
                  ),
                );
              } else {
                return RefreshIndicator(
                  onRefresh: () => userController.refreshUsers(),
                  child: ListView.builder(
                    itemCount: userController.filteredUsers.length,
                    itemBuilder: (context, index) {
                      Users user = userController.filteredUsers[index];
                      return Card(
                        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Theme.of(context).primaryColor,
                            child: Text(
                              (user.name?.isNotEmpty == true)
                              ? user.name![0].toUpperCase()
                              : '?',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Text(
                            user.name ?? '',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(user.email ?? ''),
                              Text(
                                'Company: ${user.company?.name ?? ''}',
                                style: TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                          onTap: () => Get.to(() => UserDetailScreen(user: user)),
                        ),
                      );
                    },
                  ),
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}