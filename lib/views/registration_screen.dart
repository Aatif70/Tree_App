import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tree_app/constants/app_theme.dart';
import 'package:tree_app/models/user_model.dart';
import 'package:tree_app/utils/routes.dart';
import 'package:tree_app/utils/widgets.dart';
import 'package:tree_app/view_models/auth_view_model.dart';
import 'package:flutter_animate/flutter_animate.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _agreedToTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.splashGradient,
          image: DecorationImage(
            image: const AssetImage('assets/images/leaves_pattern.png'),
            opacity: 0.1,
            repeat: ImageRepeat.repeat,
            filterQuality: FilterQuality.low,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.05),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 8,
                    shadowColor: Colors.black26,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Icon(
                              Icons.account_circle,
                              size: 60,
                              color: AppTheme.darkGreen,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Let\'s Get Started 🌱',
                              style: AppTheme.headingStyle.copyWith(
                                fontSize: 24,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Register as ${_getRoleName(authViewModel.currentUser.role)}',
                              style: AppTheme.smallTextStyle,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24),
                            CustomTextField(
                              label: 'Full Name',
                              hint: 'Enter your full name',
                              controller: _nameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                            ),
                            CustomTextField(
                              label: 'Phone Number',
                              hint: 'Enter your phone number',
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your phone number';
                                }
                                return null;
                              },
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: _agreedToTerms,
                                  activeColor: AppTheme.darkGreen,
                                  onChanged: (value) {
                                    setState(() {
                                      _agreedToTerms = value ?? false;
                                    });
                                  },
                                ),
                                Expanded(
                                  child: Text(
                                    'I agree to protect and care for planted trees',
                                    style: AppTheme.smallTextStyle,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton(
                              onPressed: authViewModel.isLoading || !_agreedToTerms
                                  ? null
                                  : _handleRegistration,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.darkGreen,
                                foregroundColor: AppTheme.white,
                                disabledBackgroundColor:
                                    AppTheme.darkGreen.withOpacity(0.5),
                                padding: const EdgeInsets.symmetric(vertical: 16),
                              ),
                              child: authViewModel.isLoading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: AppTheme.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Text('Register & Begin'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ).animate().fade(duration: 500.ms).scale(
                        begin: const Offset(0.9, 0.9),
                        end: const Offset(1, 1),
                        duration: 500.ms,
                      ),
                  SizedBox(height: screenHeight * 0.02),
                  TextButton(
                    onPressed: () {
                      // For demo purposes, go back to role selection
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Already registered? Login instead',
                      style:
                          AppTheme.smallTextStyle.copyWith(color: AppTheme.darkGreen),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _getRoleName(UserRole role) {
    switch (role) {
      case UserRole.citizen:
        return 'Citizen';
      case UserRole.treeOfficer:
        return 'Tree Officer';
      case UserRole.treeAuthority:
        return 'Tree Authority';
      default:
        return 'User';
    }
  }

  void _handleRegistration() async {
    if (_formKey.currentState!.validate()) {
      final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
      final bool success = await authViewModel.registerUser(
        name: _nameController.text,
        phoneNumber: _phoneController.text,
      );

      if (success && mounted) {
        _navigateToHomeScreen();
      }
    }
  }

  void _navigateToHomeScreen() {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    switch (authViewModel.currentUser.role) {
      case UserRole.citizen:
        Navigator.pushReplacementNamed(context, Routes.citizenHome);
        break;
      case UserRole.treeOfficer:
        Navigator.pushReplacementNamed(context, Routes.officerHome);
        break;
      case UserRole.treeAuthority:
        Navigator.pushReplacementNamed(context, Routes.authorityHome);
        break;
      default:
        Navigator.pushReplacementNamed(context, Routes.roleSelection);
    }
  }
} 