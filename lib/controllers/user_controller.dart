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


  Future<void> fetchUsers() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final fetched = await _apiService.fetchUsers();
      users.assignAll(fetched);
      filteredUsers.assignAll(fetched);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void searchUsers(String query) {
    if (query.trim().isEmpty) {
      filteredUsers.assignAll(users);
      return;
    }

    final q = query.toLowerCase();
    filteredUsers.assignAll(
      users.where((u) =>
          (u.name ?? '').toLowerCase().contains(q) ||
          (u.email ?? '').toLowerCase().contains(q),
      ),
    );
  }

  Future<void> refreshUsers() async {
    await fetchUsers();
  }
}