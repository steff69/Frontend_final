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
import 'package:travel_app/login/login.dart';
import 'package:travel_app/widgets/EditeProfile.dart';
import 'package:travel_app/widgets/mony.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.find<LoginController>();

    final box = GetStorage();

    var user = box.read("user");

    return Scaffold(
        backgroundColor: kPrimary,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.h), child: ProfileAppBar()),
        body: SafeArea(
          child: CustomContainer(
              containerConrent: Column(
                children: [
                  Container(
                    height: hieght * 0.07,
                    width: widthh,
                    decoration: BoxDecoration(
                        color: kLightwhite,
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(12.w, 0, 16, 0),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(children: [
                            CircleAvatar(
                              radius: 23.r,
                              backgroundColor: kSecondary,
                              backgroundImage: NetworkImage(
                                user == null || user["profile"] == null || user["profile"].isEmpty
                                    ? 'https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436188.jpg'
                                    : user["profile"],
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user != null && user["username"] != null ? '${user['username']}' : "Username",
                                  style: TextStyle(
                                      color: kDark,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14),
                                ),
                                Text(
                                  user != null && user["email"] != null ? '${user['email']}' : "email",
                                  style: TextStyle(
                                      color: kDark,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                            Spacer(),
                            Obx(() => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Qual Miles : ${c.points.value}'),
                                Text('Prime Miles : ${c.miles.value}')
                              ],
                            ))
                          ]),
                        ),
                      )
                    ]),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    height: 200.h,
                    decoration: BoxDecoration(
                      color: kLightwhite,
                    ),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        ProfileTitleWidget(
                          title: 'Edit profil',
                          icon: Icons.person,
                          onTap: () {
                            Get.to(() => EditProfileScreen());
                          },
                        ),
                        ProfileTitleWidget(
                            title: 'Vol History', icon: Ionicons.planet),
                        ProfileTitleWidget(
                            title: 'Reclamation',
                            icon: Ionicons.chatbubble_outline,
                            onTap: () async {
    // Update the email address, subject, and body as needed
                            Uri emailUri = Uri(
                            scheme: 'mailto',
                            path: 'resaonline@tunisair.com.tn', // Replace with the actual email address
                            query: 'subject=Reclamation&body=DECLARATION:%0ANº Vol:%0ANº Carte:', // Optionally add a subject and body
    );
    
    if (!await launchUrl(emailUri)) {
      print('Could not launch $emailUri');
    }
  },
),

                        ProfileTitleWidget(
                          title: 'Convert Miles',
                          icon: MaterialCommunityIcons.tag_outline,
                          onTap: () {
                            Get.to(() => MonyPage());
                          },
                        ),
                      ],
                    ),
                  ),
                 
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomButton(
                    onTap: () {
                      c.logout();
                    },
                    color: kRed,
                    text: 'Logout',
                    btnheigh: 35,
                  )
                ],
              )),
        ));
  }
}

class ProfileTitleWidget extends StatelessWidget {
  const ProfileTitleWidget(
      {super.key, required this.title, required this.icon, this.onTap});

  final String title;
  final IconData icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 3.0),
        child: ListTile(
            visualDensity: VisualDensity.compact,
            onTap: onTap,
            leading: Icon(
              icon,
              size: 18,
            ),
            title: Text(
              title,
              style: const TextStyle(
                  color: KGray, fontWeight: FontWeight.normal, fontSize: 14),
            ),
            trailing: Icon(
              AntDesign.right,
              size: 16,
            )));
  }
}
