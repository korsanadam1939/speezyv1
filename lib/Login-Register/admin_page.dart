import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'loginscreen.dart';


class AdminHomeScreen extends StatefulWidget {
  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    User? currentUser = _auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Panel'),
        backgroundColor: Colors.indigo[700], 
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () async {
              await _auth.signOut();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
                (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Welcome Admin, ${currentUser?.displayName ?? currentUser?.email ?? 'Admin'}!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'User List:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
           
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('users').orderBy('createdAt', descending: true).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
             
                if (snapshot.hasError) {
                  print('Firestore Stream Error: ${snapshot.error}');
                  return Center(child: Text('Kullanıcılar yüklenirken bir hata oluştu.'));
                }
             
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('Hiç kullanıcı bulunamadı.'));
                }

               
                final users = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                
                    var data = users[index].data() as Map<String, dynamic>?; 
                    if (data == null) return SizedBox.shrink(); 

                    String username = data['username'] ?? 'N/A';
                    String email = data['email'] ?? 'N/A';
                    String role = data['role'] ?? 'N/A';
                    String uid = users[index].id; 

                    return Card(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Icon(Icons.person),
                          backgroundColor: role == 'admin' ? Colors.indigo[100] : Colors.grey[300],
                        ),
                        title: Text(username, style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text('Email: $email\nRol: $role'),
                        isThreeLine: true,
                        trailing: IconButton(
                          icon: Icon(Icons.edit_note, color: Colors.grey),
                          tooltip: 'Edit User (Not Implemented)',
                          onPressed: () {
                            print('Edit user: $uid');
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}