import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:travel_app/common/custom_container.dart';
import 'package:travel_app/common/shimmers/cutomButtomn.dart';
import 'package:travel_app/constants/constants.dart';
import 'package:travel_app/controller/LoginController.dart';
import 'package:travel_app/widgets/EditeProfile.dart';
import 'package:travel_app/widgets/mony.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:travel_app/pages/VoleMain.dart';
import 'package:travel_app/pages/CoHome.dart';

import 'package:travel_app/pages/home_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 0;

  // Function to handle tab switching in the bottom navigation bar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Get.to(() => CoHome());
        break;
      case 1:
        Get.to(() => TravelFormScreen());
        break;
      case 2:
        Get.to(() => ProfilePage());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = Get.find<LoginController>();
    final box = GetStorage();
    var user = box.read("user");

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: AppBar(
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF002C3E), Color(0xFF00506A)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          title: Text(
            "Profile",
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 180.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF002C3E), Color(0xFF00506A)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                ),
                Positioned(
                  top: 110.h,
                  left: 20.w,
                  right: 20.w,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 20.r,
                            backgroundColor: kSecondary,
                            backgroundImage: NetworkImage(
                              user == null || user["profile"] == null || user["profile"].isEmpty
                                  ? 'https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436188.jpg'
                                  : user["profile"],
                            ),
                          ),
                          SizedBox(width: 7.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user != null && user["username"] != null
                                      ? '${user['username']}'
                                      : "Username",
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.sp),
                                ),
                                Text(
                                  user != null && user["email"] != null
                                      ? '${user['email']}'
                                      : "email",
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14.sp),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('Qual Miles: ${c.points.value}',
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.normal)),
                              Text('Prime Miles: ${c.miles.value}',
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.normal)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40.h),

            // GridView for Profile options
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              childAspectRatio: 1.5,
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 12.h,
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              children: [
                ProfileGridItem(
                  title: 'Edit Profile',
                  icon: Icons.person,
                  onTap: () {
                    Get.to(() => EditProfileScreen());
                  },
                ),
                ProfileGridItem(
                  title: 'Vol History',
                  icon: Ionicons.planet,
                ),
                ProfileGridItem(
                  title: 'Reclamation',
                  icon: Ionicons.chatbubble_outline,
                  onTap: () async {
                    Uri emailUri = Uri(
                      scheme: 'mailto',
                      path: 'resaonline@tunisair.com.tn',
                      query: 'subject=Reclamation&body=DECLARATION:%0ANº Vol:%0ANº Carte:',
                    );
                    if (!await launchUrl(emailUri)) {
                      print('Could not launch $emailUri');
                    }
                  },
                ),
                ProfileGridItem(
                  title: 'Convert Miles',
                  icon: MaterialCommunityIcons.tag_outline,
                  onTap: () {
                    Get.to(() => MonyPage());
                  },
                ),
                ProfileGridItem(
                  title: 'Search a Flight',
                  icon: Ionicons.search,
                  onTap: () {
                    Get.to(() => TravelFormScreen());
                  },
                ),
                ProfileGridItem(
                  title: 'Welcome Page',
                  icon: Icons.home,
                  onTap: () {
                    Get.to(() => CoHome());
                  },
                ),
              ],
            ),

            SizedBox(height: 20.h),
            Container(
              padding: EdgeInsets.only(bottom: 20.h),
              width: double.infinity,
              child: CustomButton(
                onTap: () {
                  c.logout();
                },
                color: kRed,
                text: 'Logout',
                btnheigh: 45,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Flights',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

// Grid Item Widget for Profile Options
class ProfileGridItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function()? onTap;

  const ProfileGridItem({Key? key, required this.title, required this.icon, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF8B0000),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 36.sp,
              color: Colors.white,
            ),
            SizedBox(height: 10.h),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
