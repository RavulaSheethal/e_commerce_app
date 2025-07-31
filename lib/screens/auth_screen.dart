import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/home_screen.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLogin = true;

  String email = '';
  String password = '';
  String name = '';
  String phone = '';

  void toggleForm() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  Future<void> handleAuth() async {
    if (_formKey.currentState!.validate()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (isLogin) {
        String? savedEmail = prefs.getString('email');
        String? savedPassword = prefs.getString('password');
        if (email == savedEmail && password == savedPassword) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => HomeScreen()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Invalid credentials')),
          );
        }
      } else {
        prefs.setString('name', name);
        prefs.setString('email', email);
        prefs.setString('phone', phone);
        prefs.setString('password', password);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registered successfully! Please login.')),
        );
        setState(() {
          isLogin = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isLogin ? 'Login' : 'Register')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              if (!isLogin)
                TextFormField(
                  decoration: InputDecoration(labelText: 'Name'),
                  onChanged: (val) => name = val,
                  validator: (val) =>
                      val!.isEmpty ? 'Please enter your name' : null,
                ),
              if (!isLogin)
                TextFormField(
                  decoration: InputDecoration(labelText: 'Phone Number'),
                  onChanged: (val) => phone = val,
                  validator: (val) =>
                      val!.isEmpty ? 'Please enter your phone' : null,
                ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                onChanged: (val) => email = val,
                validator: (val) =>
                    val!.isEmpty ? 'Please enter your email' : null,
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
                onChanged: (val) => password = val,
                validator: (val) =>
                    val!.length < 6 ? 'Password must be 6+ chars' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: handleAuth,
                child: Text(isLogin ? 'Login' : 'Register'),
              ),
              TextButton(
                onPressed: toggleForm,
                child: Text(isLogin
                    ? "Don't have an account? Register"
                    : "Already have an account? Login"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
