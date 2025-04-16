import '../models/client.dart';
import '../services/file_service.dart';

class ClientController {
  final String fileName = 'clients';
  List<Client> clients = [];

  Future<void> loadClients() async {
    final data = await FileService.readData(fileName);
    clients = data.map((json) => Client.fromJson(json)).toList();
  }

  Future<void> saveClients() async {
    await FileService.saveData(fileName, clients.map((c) => c.toJson()).toList());
  }

  Future<void> addClient(Client client) async {
    clients.add(client);
    await saveClients();
  }

  Future<void> updateClient(Client client) async {
    final index = clients.indexWhere((c) => c.id == client.id);
    if (index != -1) {
      clients[index] = client;
      await saveClients();
    }
  }

  Future<void> deleteClient(int id) async {
    clients.removeWhere((c) => c.id == id);
    await saveClients();
  }
}
