import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:speezy/Login-Register/registerpage.dart';
import 'package:speezy/Login-Register/userhome_screen.dart';
import 'package:speezy/main.dart';
import 'package:speezy/screens/home_page.dart';

import '../utils/file_importers.dart';
import 'admin_page.dart';
import 'forgotpassword.dart'; // Firestore ekleyin



class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance; 


  final _formKey = GlobalKey<FormState>();


  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  bool _isPasswordHidden = true;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _loginUser() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      User? user = userCredential.user;

      if (user != null) {
        print('Auth Giriş Başarılı: ${user.email}');

        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(user.uid).get();

        if (mounted) {
          if (userDoc.exists && userDoc.data() != null) {
            Map<String, dynamic> userData =
                userDoc.data() as Map<String, dynamic>;
            String userRole =
                userData['role'] ?? 'user';


            print('Kullanıcı Rolü: $userRole');

            var sp = await SharedPreferences.getInstance();
            await sp.setString("kullaniciadi",userData["username"] );
            await sp.setString("seviye", "A1");

            if (userRole == 'admin') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => AdminHomeScreen()),
              );
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
              );
            }
          } else {
            print(
              'HATA: Firestore kullanıcı dokümanı bulunamadı. UID: ${user.uid}',
            );
            await _auth.signOut(); 
            setState(() {
              _errorMessage =
                  'Kullanıcı verileri bulunamadı. Lütfen destek ile iletişime geçin.';
              _isLoading = false;
            });
            return; 
          }
        } 
      } else {
        if (mounted) {
          setState(() {
            _errorMessage = "Giriş yapılamadı, kullanıcı bilgisi alınamadı.";
          });
        }
      }
    } on FirebaseAuthException catch (e) {
      print('Auth Giriş Hatası Kodu: ${e.code}');
      String message = _handleAuthError(e); 
      if (mounted) {
        setState(() {
          _errorMessage = message;
        });
      }
    } catch (e) {
      print('Beklenmedik Giriş Hatası: $e');
      if (mounted) {
        setState(() {
          _errorMessage = 'Bir hata oluştu: $e';
        });
      }
    } finally {
      if (_isLoading && mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  String _handleAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'Bu e-posta adresi ile kayıtlı kullanıcı bulunamadı.';
      case 'wrong-password':
        return 'Yanlış şifre girdiniz.';
      case 'invalid-email':
        return 'Geçersiz e-posta adresi formatı.';
      case 'user-disabled':
        return 'Bu kullanıcı hesabı devre dışı bırakılmış.';
      case 'too-many-requests':
        return 'Çok fazla başarısız giriş denemesi. Lütfen daha sonra tekrar deneyin.';
      case 'network-request-failed':
        return 'İnternet bağlantınızı kontrol edin.';
      default:
        return 'Kimlik doğrulama hatası. Lütfen tekrar deneyin.';
    }
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 32.0,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Giriş yap',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Hoşgeldin!',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 15.0, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 40.0),
                  _buildTextField(
                    controller: _emailController,
                    labelText: 'email',
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Lütfen e-posta adresinizi girin.';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Lütfen geçerli bir e-posta adresi girin.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  _buildPasswordField(
                    controller: _passwordController,
                    labelText: 'password',
                    isPasswordHidden: _isPasswordHidden,
                    togglePasswordVisibility: () {
                      setState(() {
                        _isPasswordHidden = !_isPasswordHidden;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Lütfen şifrenizi girin.';
                      }
                      if (value.length < 6) {
                        return 'Şifre en az 6 karakter olmalıdır.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10.0),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgotPasswordScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'şifrenimi unuttun?',
                        style: TextStyle(
                          color: Colors.orangeAccent[700],
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  if (_errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: Text(
                        _errorMessage!,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _loginUser,
                    child:
                        _isLoading
                            ? SizedBox(
                              height: 20.0,
                              width: 20.0,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 3.0,
                              ),
                            )
                            : Text(
                              'GİRİŞ YAP',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent[400],
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      elevation: 3,
                      disabledBackgroundColor: Colors.orangeAccent[200],
                    ),
                  ),
                  SizedBox(height: 25.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "henüz bir hesabın yokmu? ",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14.0,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Buraya tıkla',
                          style: TextStyle(
                            color: Colors.orangeAccent[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildTextField({
    required TextEditingController controller, 
    required String labelText,
    IconData? icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator, 
  }) {
    return TextFormField(
      controller: controller, 
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: labelText,
        hintStyle: TextStyle(color: Colors.grey[500]),
        suffixIcon: suffixIcon,
        contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.grey[300]!, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.grey[300]!, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.orangeAccent[400]!, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.red[700]!, width: 1.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.red[700]!, width: 1.5),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      style: TextStyle(color: Colors.black87),
      validator: validator, 
      autovalidateMode:
          AutovalidateMode.onUserInteraction, 
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller, 
    required String labelText,
    required bool isPasswordHidden,
    required VoidCallback togglePasswordVisibility,
    String? Function(String?)? validator, 
  }) {
    return _buildTextField(
      controller: controller,
      labelText: labelText,
      obscureText: isPasswordHidden,
      suffixIcon: IconButton(
        icon: Icon(
          isPasswordHidden
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
          color: Colors.grey[500],
        ),
        onPressed: togglePasswordVisibility,
      ),
      validator: validator, 
    );
  }
}
