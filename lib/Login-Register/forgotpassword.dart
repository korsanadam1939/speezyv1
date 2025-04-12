import 'package:flutter/material.dart';


class ForgotPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black54),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Forgot Password',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 12.0),

                Text(
                  'Enter your email address below to receive a password reset code.',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 40.0),

                _buildTextField( 
                  labelText: 'email address',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 35.0),

                ElevatedButton(
                  onPressed: () {
                    print('SEND RESET CODE Butonuna Tıklandı');
                  },
                  child: Text(
                    'SEND RESET CODE',
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
                  ),
                ),
                 SizedBox(height: 25.0),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "remembered password? ",
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14.0,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        print('Login Tıklandı');
                         Navigator.of(context).pop(); 
                      },
                      child: Text(
                        'login',
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
    );
  }

  Widget _buildTextField({
    required String labelText,
    IconData? icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return TextField(
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
        filled: true,
        fillColor: Colors.white,
      ),
      style: TextStyle(color: Colors.black87),
    );
  }
}