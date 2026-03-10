import 'package:get/get.dart';
import '../models/models.dart';
import '../services/api_service.dart';

class UserController extends GetxController {
  final ApiService _apiService = ApiService();

  var users = <Users>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;
  var filteredUsers = <Users>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  void fetchUsers() async {
    try {
      isLoading(true);
      errorMessage('');
      users.value = await _apiService.fetchUsers();
      filteredUsers.value = users;
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  void searchUsers(String query) {
    if (query.isEmpty) {
      filteredUsers.value = users;
    } else {
      filteredUsers.value = users.where((user) =>
          user.name!.toLowerCase().contains(query.toLowerCase()) ||
          user.email!.toLowerCase().contains(query.toLowerCase())).toList();
    }
  }

  void refreshUsers() {
    fetchUsers();
  }
}