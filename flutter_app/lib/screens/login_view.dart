import 'package:flutter/material.dart';
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
            
            return SingleChildScrollView(
              physics: isKeyboardOpen
                  ? const ClampingScrollPhysics()
                  : const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: isKeyboardOpen
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.center,
                    children: [
                      if (!isKeyboardOpen) SizedBox(height: constraints.maxHeight * 0.15),
                      
                      
                      // Email Field
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: const Icon(Icons.email_outlined, color: Colors.grey),
                          hintText: 'Enter your email',
                          hintStyle: const TextStyle(color: Color(0xFF8B8B8B)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color(0xFFBBBBBB)),
                            borderRadius: BorderRadius.circular(12)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color(0xFFFF6B35)),
                            borderRadius: BorderRadius.circular(12)),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(12)),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color(0xFFFF6B35)),
                            borderRadius: BorderRadius.circular(12)),
                        ),
                      ),

                      const SizedBox(height: 25),

                      // Password Field
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: const Icon(Icons.key_outlined, color: Colors.grey),
                          hintText: 'Enter your password',
                          hintStyle: const TextStyle(color: Colors.grey),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color(0xFFBBBBBB)),
                            borderRadius:  BorderRadius.circular(12)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color(0xFFFF6B35)),
                            borderRadius: BorderRadius.circular(12)),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(12)),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color(0xFFFF6B35)),
                            borderRadius: BorderRadius.circular(12)),
                        ),
                      ),

                      const SizedBox(height: 25),

                      // Login Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFF6B35),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Forgot Password
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            foregroundColor: const Color(0xFFFF6B35),
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                          ),
                          child: const Text("Forgot password?"),
                        ),
                      ),

                      // Sign Up Row
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: isKeyboardOpen ? 20 : constraints.maxHeight * 0.15),

                        child:Align(
                          alignment:Alignment.bottomCenter ,
                         child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('Don\'t have an account?'),
                            TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                foregroundColor: const Color(0xFFFF6B35),
                                overlayColor: Colors.transparent,
                              ),
                              child: const Text('Sign Up'),
                            ),
                          ],
                        ),
                      ),)
                  ]),
                )
              )
            );
  }),
            )
            );
          }
  }