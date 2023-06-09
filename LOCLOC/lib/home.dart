import 'package:cloud_firestore/cloud_firestore.dart';
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
  late Future<List<String>> _groupNamesFuture = Future.value([]);

  Future<List<String>> getGroupNames() async {
    final groupsCollection = FirebaseFirestore.instance.collection('group');
    final groupsSnapshot = await groupsCollection.get();
    final groupNames = <String>[];
    for (final doc in groupsSnapshot.docs) {
      final docSnapshot = await groupsCollection.doc(doc.id).get();
      final groupName = docSnapshot.data()?['name'] as String?;
      if (groupName != null) {
        groupNames.add(groupName);
      }
    }
    return groupNames;
  }

  @override
  void initState() {
    super.initState();
    _groupNamesFuture = getGroupNames();
  }

  void onTap(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MapScreen(groupId: index + 1)),
    );
  }

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
      body: FutureBuilder<List<String>>(
        future: _groupNamesFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final groups = snapshot.data!;
            return Column(
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
                        title: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MapScreen(groupId: index + 1)),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 5),
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 255, 221, 152),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
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
                            ),
                          ),
                        ),
                        contentPadding: const EdgeInsets.all(10),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Failed to load groups"),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
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

class GroupListView extends StatelessWidget {
  const GroupListView({
    required this.groups,
    required this.onTap,
  });

  final List<String> groups;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: groups.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => onTap(index),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 221, 152),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    groups[index],
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red, fontSize: 18),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
