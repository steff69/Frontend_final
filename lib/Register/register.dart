import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travel_app/Models%202/RegisterModel.dart';
import 'package:travel_app/common/shimmers/cutomButtomn.dart';
import 'package:travel_app/constants/constants.dart';
import 'package:travel_app/controller/RegisterController.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _nameController = TextEditingController();
  late final TextEditingController _passwordController = TextEditingController();
  final FocusNode _passwordCFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordCFocusNode.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var c = Get.put(RegisterController()); // Ensure RegisterController is initialized only once

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: AppBar(
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF00506A), Color(0xFF002C3E)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          title: Padding(
            padding: EdgeInsets.only(left: 100),
            child: Text(
              'Register',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          elevation: 0,
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF002C3E), Color(0xFF00506A)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            SizedBox(height: 5.h),
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25.0),
                bottomRight: Radius.circular(25.0),
              ),
              child: Image.asset(
                'assets/t.jpg',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'Sign up today for exclusive deals and smooth bookings.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(height: 35.h),
            _buildTextField(_emailController, "Enter Email", CupertinoIcons.mail),
            SizedBox(height: 20.h),
            _buildTextField(_nameController, "Name", CupertinoIcons.person),
            SizedBox(height: 20.h),
            _buildTextField(_passwordController, "Password", CupertinoIcons.lock, isPassword: true),
            SizedBox(height: 20.h),
            Obx(() => c.loading.value
                ? Center(child: CircularProgressIndicator(color: Colors.blue))
                : CustomButton(
                    onTap: () {
                      RegisterModel model = RegisterModel(
                        email: _emailController.text,
                        password: _passwordController.text,
                        username: _nameController.text,
                      );
                      String data = RegisterModelToJson(model);
                      c.registerFunction(data);
                    },
                    text: "SIGN UP",
                    btnheigh: 35.h,
                  )),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hintText,
    IconData icon, {
    bool isPassword = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white),
        prefixIcon: Icon(icon, size: 20, color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(color: Colors.white, width: 2.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(color: Colors.blue, width: 2.0),
        ),
      ),
      style: TextStyle(color: Colors.white),
    );
  }
}
