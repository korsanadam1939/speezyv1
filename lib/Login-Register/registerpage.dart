import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils/file_importers.dart';
import 'loginscreen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; 

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController = TextEditingController();

  bool _isPasswordHidden = true;
  bool _isRepeatPasswordHidden = true;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }
  Future<void> girisKontrol() async {
    var ka = _usernameController.text;
    var s ="A1";

    if (ka.isNotEmpty && s.isNotEmpty) {
      var sp = await SharedPreferences.getInstance();
      await sp.setString("kullaniciadi", ka);
      await sp.setString("seviye", s);

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Giriş hatalı")),
      );
    }
  }

  Future<void> _registerUser() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (_passwordController.text != _repeatPasswordController.text) {
      if (mounted) {
        setState(() {
          _errorMessage = "Şifreler eşleşmiyor.";
        });
      }
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      User? user = userCredential.user;

      if (user != null) {
        await user.updateDisplayName(_usernameController.text.trim());
        await user.reload(); 

      
        String userRole = 'user'; 

        Map<String, dynamic> userData = {
          'uid': user.uid, 
          'username': _usernameController.text.trim(),
          'email': user.email,
          'role': userRole, 
          'createdAt': FieldValue.serverTimestamp(),
         
        };

        await _firestore.collection('users').doc(user.uid).set(userData);

        print('Kayıt Başarılı. Auth UID: ${user.uid}, Rol: $userRole');
        await girisKontrol();

        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        }
      } else {
        if (mounted) {
          setState(() {
            _errorMessage = "Kullanıcı oluşturulamadı.";
          });
        }
      }

    } on FirebaseAuthException catch (e) {
      print('Auth Kayıt Hatası Kodu: ${e.code}');
      String message = _handleAuthError(e); 
       if (mounted) {
        setState(() {
          _errorMessage = message;
        });
      }
    } catch (e) {
      print('Beklenmedik Kayıt Hatası: $e');
       if (mounted) {
        setState(() {
          _errorMessage = 'Bir hata oluştu: $e'; 
        });
       }
    } finally {
       if (mounted) {
        setState(() {
          _isLoading = false;
        });
       }
    }
  }

  String _handleAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return 'Şifre çok zayıf. Daha güçlü bir şifre seçin.';
      case 'email-already-in-use':
        return 'Bu e-posta adresi zaten kullanımda.';
      case 'invalid-email':
        return 'Geçersiz e-posta adresi formatı.';
      case 'operation-not-allowed':
        return 'E-posta/Şifre ile kayıt şu anda etkin değil.';
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
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Kayıt Ol',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'or sign up with email',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 30.0),
                  _buildTextField(
                    controller: _usernameController,
                    labelText: 'username',
                    icon: Icons.person_outline,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Lütfen bir kullanıcı adı girin.';
                      }
                      if (value.length < 3) {
                         return 'Kullanıcı adı en az 3 karakter olmalıdır.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
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
                        return 'Lütfen bir şifre girin.';
                      }
                      if (value.length < 6) {
                        return 'Şifre en az 6 karakter olmalıdır.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  _buildPasswordField(
                    controller: _repeatPasswordController,
                    labelText: 'repeat password',
                    isPasswordHidden: _isRepeatPasswordHidden,
                    togglePasswordVisibility: () {
                      setState(() {
                        _isRepeatPasswordHidden = !_isRepeatPasswordHidden;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Lütfen şifrenizi tekrar girin.';
                      }
                      if (value != _passwordController.text) {
                        return 'Şifreler eşleşmiyor.';
                      }
                      return null;
                    },
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
                    onPressed: _isLoading ? null : _registerUser,
                    child: _isLoading
                        ? SizedBox(
                            height: 20.0,
                            width: 20.0,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 3.0,
                            ),
                          )
                        : Text(
                            'HESABI OLUŞTUR',
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
                        'zaten bir hesabın varmı? ',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14.0,
                        ),
                      ),
                      GestureDetector(
                        onTap: _isLoading ? null : () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen()),
                          );
                        },
                        child: Text(
                          'Buraya tıkla',
                          style: TextStyle(
                            color: _isLoading ? Colors.grey : Colors.orangeAccent[700],
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
      autovalidateMode: AutovalidateMode.onUserInteraction, 
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
          isPasswordHidden ? Icons.visibility_off_outlined : Icons.visibility_outlined,
          color: Colors.grey[500],
        ),
        onPressed: togglePasswordVisibility,
      ),
       validator: validator, 
    );
  }
}