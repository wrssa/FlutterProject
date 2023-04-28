import 'package:flutter/material.dart';

import 'home.dart';
import 'profile.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  final List<String> friends = ['John', 'Jane', 'Peter', 'Mary'];
  String? _selectedFriend;
  List<String> selectedMembers = [];

  void _addMember() {
    if (_selectedFriend != null && !selectedMembers.contains(_selectedFriend)) {
      setState(() {
        selectedMembers.add(_selectedFriend!);
        _selectedFriend = null;
      });
    }
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
              width: 80,
              height: 80,
            ),
            SizedBox(width: 8),
          ],
        ),
        toolbarHeight: 100,
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 25.0),
            const Center(
              child: Text(
                'Create New Group',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 30.0),
            Container(
              height: 3,
              decoration: const BoxDecoration(
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 50.0),
            const Text(
              'Group Name',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
            const SizedBox(height: 20.0),
            const TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Enter group name',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white, // Set the border color to white
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                ),
              ),
            ),
            const SizedBox(height: 25.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Add Member',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
                DropdownButton<String>(
                  value: _selectedFriend,
                  items: [
                    for (var friend in friends)
                      DropdownMenuItem(
                        child: Text(
                          friend,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        value: friend,
                      ),
                  ],
                  hint: const Text(
                    'Select a friend',
                    style: TextStyle(color: Colors.white),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _selectedFriend = value;
                    });
                  },
                ),
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.add),
                    color: Colors.white,
                    onPressed: _addMember,
                  ),
                )
              ],
            ),
            const SizedBox(height: 25.0),
            //Group member row
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Group Members :',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
                const SizedBox(width: 20.0),
                selectedMembers.isEmpty
                    ? const Text(
                        'No members',
                        style: TextStyle(
                          color: Colors.white, // Set the text color to white
                        ),
                      )
                    : Expanded(
                        child: Wrap(
                          spacing: 8.0,
                          children: [
                            for (var member in selectedMembers)
                              Chip(
                                label: Text(member),
                                onDeleted: () {
                                  setState(() {
                                    selectedMembers.remove(member);
                                  });
                                },
                              ),
                          ],
                        ),
                      ),
              ],
            ),
            //const SizedBox(height: 50.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Implement create group logic here
                },
                style: ElevatedButton.styleFrom(
                  // ignore: deprecated_member_use
                  primary: Colors.red, // background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // rounded corners
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text(
                    'Create New Group',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
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
