import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:travel_app/common/custom_container.dart';
import 'package:travel_app/common/shimmers/ProfileAppBar.dart';
import 'package:travel_app/common/shimmers/cutomButtomn.dart';
import 'package:travel_app/constants/constants.dart';
import 'package:travel_app/controller/LoginController.dart';
import 'package:travel_app/widgets/EditeProfile.dart';
import 'package:travel_app/widgets/mony.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:travel_app/pages/VoleMain.dart';
import 'package:travel_app/pages/home_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.find<LoginController>();
    final box = GetStorage();
    var user = box.read("user");

    return Scaffold(
      backgroundColor: Colors.white, // Set background to white
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h), child: ProfileAppBar()),
      body: SafeArea(
        child: Column(
          children: [
            // Enhanced Profile Section
            Stack(
              children: [
                // Gradient Background
                Container(
                  height: 180.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF002C3E), Color(0xFF00506A)], // Gradient from dark to lighter blue
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                ),
                // Profile Card
                Positioned(
                  top: 110.h, // Adjusted for better positioning
                  left: 20.w,
                  right: 20.w,

                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: EdgeInsets.all(16.w), // Increased padding
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
                          Expanded( // Wrap this part with Expanded to avoid overflow
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
                          SizedBox(width: 10.w), // Adds spacing between elements
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
            SizedBox(height: 40.h), // Adjusted spacing for visual balance

            // Menu Options in Grid Layout
            GridView.count(
              shrinkWrap: true, // Makes sure the GridView takes only the space it needs
              crossAxisCount: 2, // Two columns
              childAspectRatio: 1.5, // Adjust for height/width ratio
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
                      query:
                      'subject=Reclamation&body=DECLARATION:%0ANº Vol:%0ANº Carte:',
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
                // New Grid Item for Search a Flight (TravelFormScreen)
                ProfileGridItem(
                  title: 'Search a Flight',
                  icon: Ionicons.search,
                  onTap: () {
                    Get.to(() => TravelFormScreen());  // Navigate to TravelFormScreen
                  },
                ),
                // New Grid Item for Return Home
                ProfileGridItem(
                  title: 'Welcome Page',
                  icon: Icons.home,
                  onTap: () {
                    Get.to(() => HomePage());  // Navigate to HomePage
                  },
                ),
              ],
            ),

            // Add space between grid and logout button
            SizedBox(height: 20.h),

            // Logout Button pinned with a little space above
            Container(
              padding: EdgeInsets.only(bottom: 20.h), // Adds padding at the bottom
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
          color: Color(0xFF8B0000), // Background color of the grid item (red)
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3), // Changes position of shadow
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
              color: Colors.white, // Icon color changed to white
            ),
            SizedBox(height: 10.h),
            Text(
              title,
              style: TextStyle(
                color: Colors.white, // Text color changed to white
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
