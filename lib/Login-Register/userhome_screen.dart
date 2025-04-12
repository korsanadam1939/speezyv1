import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'loginscreen.dart';


class UserHomeScreen extends StatefulWidget {
  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    User? currentUser = _auth.currentUser;

    if (currentUser == null) {
       WidgetsBinding.instance.addPostFrameCallback((_) {
         Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (Route<dynamic> route) => false,
          );
       });
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.orangeAccent[700], 
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
      body: Center(
        child: StreamBuilder<DocumentSnapshot>(
          stream: _firestore.collection('users').doc(currentUser.uid).snapshots(),
          builder: (context, snapshot) {
            
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (snapshot.hasError) {
               print('Firestore User Stream Error: ${snapshot.error}');
              return Text('Bilgileriniz yüklenirken bir hata oluştu.');
            }
            if (!snapshot.hasData || !snapshot.data!.exists) {
              return Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                    Text('Kullanıcı verileri bulunamadı.'),
                    SizedBox(height: 10),
                    Text('Lütfen çıkış yapıp tekrar deneyin veya destekle iletişime geçin.', textAlign: TextAlign.center),
                 ],
              );
            }

           
            var userData = snapshot.data!.data() as Map<String, dynamic>?;
            if (userData == null) return Text('Kullanıcı verisi okunamadı.'); 

            String username = userData['username'] ?? 'Kullanıcı';
            String email = userData['email'] ?? 'N/A';
            String role = userData['role'] ?? 'user';

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    child: Icon(Icons.person, size: 50),
                    backgroundColor: Colors.orangeAccent[100],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Welcome, $username!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Email: $email',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Role: $role',
                    style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.grey[700]),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                       print('Edit Profile Tapped');
                    },
                    child: Text('Edit Profile (Not Implemented)'),
                     style: ElevatedButton.styleFrom(backgroundColor: Colors.orangeAccent[400]),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}