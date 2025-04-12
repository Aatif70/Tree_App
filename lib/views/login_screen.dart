import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tree_app/constants/app_theme.dart';
import 'package:tree_app/models/user_model.dart';
import 'package:tree_app/view_models/auth_view_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();
  final _otpController = TextEditingController();

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final role = authViewModel.currentUser.role;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(_getLoginTitle(role)),
        backgroundColor: AppTheme.darkGreen,
        foregroundColor: AppTheme.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              
              // ID Field (changes based on role)
              TextFormField(
                controller: _idController,
                decoration: InputDecoration(
                  labelText: _getIdentifierLabel(role),
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your ${_getIdentifierLabel(role)}';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              
              // Password field for officers and authority
              if (role != UserRole.citizen) 
                Column(
                  children: [
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              
              // OTP field for authority
              if (role == UserRole.treeAuthority)
                Column(
                  children: [
                    TextFormField(
                      controller: _otpController,
                      decoration: const InputDecoration(
                        labelText: 'OTP (Optional)',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
                
              const SizedBox(height: 24),
              
              ElevatedButton(
                onPressed: authViewModel.isLoading ? null : _handleLogin,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: authViewModel.isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(),
                      )
                    : Text(_getButtonText(role)),
              ),
              
              if (role == UserRole.citizen)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: const Text('New user? Register here'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _getLoginTitle(UserRole role) {
    switch (role) {
      case UserRole.citizen:
        return 'Citizen Login';
      case UserRole.treeOfficer:
        return 'Tree Officer Login';
      case UserRole.treeAuthority:
        return 'Tree Authority Login';
      default:
        return 'Login';
    }
  }

  String _getIdentifierLabel(UserRole role) {
    switch (role) {
      case UserRole.citizen:
        return 'Phone Number';
      case UserRole.treeOfficer:
        return 'Officer ID';
      case UserRole.treeAuthority:
        return 'Authority ID';
      default:
        return 'ID';
    }
  }

  String _getButtonText(UserRole role) {
    return role == UserRole.citizen ? 'Continue' : 'Login';
  }

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
      
      final success = await authViewModel.login(
        identifier: _idController.text,
        password: _passwordController.text,
        otp: _otpController.text.isNotEmpty ? _otpController.text : null,
      );
      
      if (success && mounted) {
        Navigator.pushReplacementNamed(context, authViewModel.getHomeRoute());
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login failed. Please check your credentials.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
} 