import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import 'add_user_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserProvider>();
    final users = provider.filteredUsers;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const AddUserScreen(),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: provider.setSearchQuery,
                    decoration: InputDecoration(
                      hintText: 'Search by name or phone',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                InkWell(
                  onTap: () => _showSortDialog(context),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.sort),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: users.isEmpty
                ? const Center(
                    child: Text(
                      'No users found',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];

                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 26,
                            backgroundColor: Colors.black,
                            backgroundImage: user.imagePath.isNotEmpty
                                ? FileImage(File(user.imagePath))
                                : null,
                            child: user.imagePath.isEmpty
                                ? const Icon(Icons.person,
                                    color: Colors.white)
                                : null,
                          ),
                          title: Text(
                            user.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(user.phone),
                              Text('Age: ${user.age}'),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _showSortDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        final provider = context.watch<UserProvider>();

        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Sort",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),

              RadioListTile<AgeSortType>(
                title: const Text("All"),
                value: AgeSortType.all,
                groupValue: provider.ageSortType,
                onChanged: (value) {
                  provider.setAgeSort(value!);
                  Navigator.pop(context);
                },
              ),

              RadioListTile<AgeSortType>(
                title: const Text("Age: Elder (60+)"),
                value: AgeSortType.elder,
                groupValue: provider.ageSortType,
                onChanged: (value) {
                  provider.setAgeSort(value!);
                  Navigator.pop(context);
                },
              ),

              RadioListTile<AgeSortType>(
                title: const Text("Age: Younger (< 60)"),
                value: AgeSortType.younger,
                groupValue: provider.ageSortType,
                onChanged: (value) {
                  provider.setAgeSort(value!);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
