import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travel_app/Models%202/LoginModel.dart';
import 'package:travel_app/Register/register.dart';
import 'package:travel_app/common/shimmers/cutomButtomn.dart';
import 'package:travel_app/constants/constants.dart';
import 'package:travel_app/controller/LoginController.dart';
import 'package:travel_app/pages/MainScreen.dart';
import 'package:travel_app/pages/ProfilePage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _passwordController = TextEditingController();
  final FocusNode _passwordCFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordCFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var c = Get.put(LoginController());

    if (c.pf.value == true) {
      return ProfilePage();
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: AppBar(
          backgroundColor: Colors.transparent, // Set to transparent to show gradient
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [ Color(0xFF00506A),Color(0xFF002C3E)], // Same gradient as ProfilePage
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          title: GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MainScreen(),
                ),
              );
            },
            child: Icon(Icons.arrow_back, color: Colors.white), // White back icon
          ),
          elevation: 0, // No shadow
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF002C3E), Color(0xFF00506A)], // Background gradient
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(),
          child: ListView(
            children: [
              SizedBox(height: 5.h),

              // Image with convex corners
              ClipRRect(
                borderRadius: BorderRadius.only(
                 
                ),
                child: Image.asset('assets/t.jpg'), // Image at the top
              ),

              SizedBox(height: 20.h), // Space below the image

              // Quote Styled Text
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  '“Discover More with Every Login”',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w300, // Light weight for "quote" feel
                    letterSpacing: 1.2, // Elegant letter spacing
                  ),
                ),
              ),

              SizedBox(height: 30.h), // Space before "Sign In"

              // Sign In Text
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Sign In',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold, // Bold to stand out
                  ),
                ),
              ),

              SizedBox(height: 30.h), // Space before fields

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    // Email TextField
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: "Enter Email",
                        hintStyle: TextStyle(color: Colors.white), // White hint text
                        prefixIcon: Icon(
                          CupertinoIcons.mail,
                          size: 20,
                          color: Colors.white, // White icon color
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide: BorderSide(
                            color: Colors.white, // White border
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide: BorderSide(
                            color: Colors.blue, // Blue border for focus
                            width: 2.0,
                          ),
                        ),
                      ),
                      style: TextStyle(color: Colors.white), // White input text
                    ),
                    SizedBox(height: 20.h),

                    // Password TextField
                    TextField(
                      controller: _passwordController,
                      obscureText: true, // Hide password input
                      decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: TextStyle(color: Colors.white), // White hint text
                        prefixIcon: Icon(
                          CupertinoIcons.lock,
                          size: 20,
                          color: Colors.white, // White icon color
                        ),
                        suffixIcon: Icon(
                          Icons.visibility_off, // Visibility toggle icon
                          color: Colors.white,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide: BorderSide(
                            color: Colors.white, // White border
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide: BorderSide(
                            color: Colors.blue, // Blue border for focus
                            width: 2.0,
                          ),
                        ),
                      ),
                      style: TextStyle(color: Colors.white), // White input text
                    ),

                    // Register link
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(() => RegisterPage());
                            },
                            child: Text(
                              'Register',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Login Button
                    Obx(() => c.loading.value
                        ? Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    )
                        : CustomButton(
                      onTap: () {
                        LoginModel model = LoginModel(
                          email: _emailController.text,
                          password: _passwordController.text,
                        );
                        String data = loginModelToJson(model);
                        c.loginFunction(data);
                      },
                      text: "L O G I N",
                      btnheigh: 35.h,
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
