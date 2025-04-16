import '../models/user.dart';
import '../services/file_service.dart';

class UserController {
  final String fileName = 'users';
  List<User> users = [];

  Future<void> loadUsers() async {
    final data = await FileService.readData(fileName);
    users = data.map((json) => User.fromJson(json)).toList();
  }

  Future<void> saveUsers() async {
    await FileService.saveData(fileName, users.map((u) => u.toJson()).toList());
  }

  Future<void> addUser(User user) async {
    users.add(user);
    await saveUsers();
  }

  Future<void> updateUser(User user) async {
    final index = users.indexWhere((u) => u.id == user.id);
    if (index != -1) {
      users[index] = user;
      await saveUsers();
    }
  }

  Future<void> deleteUser(int id) async {
    users.removeWhere((u) => u.id == id);
    await saveUsers();
  }

  User? getUser(String nome, String senha) {
    return users.firstWhere(
      (u) => u.nome == nome && u.senha == senha,
      orElse: () => User(id: -1, nome: '', senha: ''),
    );
  }
}
