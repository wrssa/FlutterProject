import 'package:flutter/material.dart';
import 'map.dart';

import 'creategroup.dart';
import 'profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> groups = [
    'Mahidol Gang',
    'Family',
    'OT6',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Image(
              image: AssetImage('assets/logo.png'),
              width: 70,
              height: 70,
            ),
            SizedBox(width: 8),
          ],
        ),
        toolbarHeight: 100,
        backgroundColor: Colors.red,
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 25),
            const Text(
              "List of all groups",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: groups.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 5),
                      width: 10,
                      height: 50,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 221, 152),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        groups[index],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(10),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ShowMap()),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.view_list),
            label: 'All Groups',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Create New Group',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CreateGroup()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Profile()),
              );
              break;
            default:
          }
        },
        selectedItemColor: Colors.red,
      ),
      backgroundColor: const Color.fromARGB(255, 43, 43, 43),
    );
  }
}
