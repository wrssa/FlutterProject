import 'package:flutter/material.dart';

import 'creategroup.dart';
import 'home.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

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
      body: Column(
        children: [
          const SizedBox(height: 20),
          const CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
                'https://cdn-icons-png.flaticon.com/512/5234/5234205.png'),
          ),
          const SizedBox(height: 20),
          const Text(
            'John Doe',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 10),
          Text(
            '@johndoe',
            style: TextStyle(fontSize: 18, color: Colors.grey[500]),
          ),
          const SizedBox(height: 15),
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color.fromARGB(255, 255, 221, 152),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildProfileInfoItem('Name', 'John Doe'),
                _buildProfileInfoItem('Email', 'johndoe@example.com'),
                _buildProfileInfoItem('Age', '25'),
                _buildProfileInfoItem('Gender', 'Male'),
                _buildProfileInfoItem('Birthdate', '01/01/1996'),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Handle edit profile button click
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red, // background color
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(30), // rounded corners
                    ),
                  ),
                  child: const Text('Edit Profile'),
                ),
              ],
            ),
          ),
        ],
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

  Widget _buildProfileInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
