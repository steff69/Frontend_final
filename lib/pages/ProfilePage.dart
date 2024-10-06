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
        preferredSize: Size.fromHeight(50.h),
        child: ProfileAppBar(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: Column(
              children: [
                // User Info Section
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: kLightwhite,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 35.r,
                        backgroundColor: kSecondary,
                        backgroundImage: NetworkImage(
                          user == null || user["profile"] == null || user["profile"].isEmpty
                              ? 'https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436188.jpg'
                              : user["profile"],
                        ),
                      ),
                      SizedBox(width: 20.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user != null && user["username"] != null
                                ? '${user['username']}'
                                : "Username",
                            style: TextStyle(
                              color: kDark,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            ),
                          ),
                          Text(
                            user != null && user["email"] != null
                                ? '${user['email']}'
                                : "email",
                            style: TextStyle(
                              color: kGray,
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Obx(() => Text(
                                'Qual Miles: ${c.points.value}',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: kDark,
                                ),
                              )),
                          Obx(() => Text(
                                'Prime Miles: ${c.miles.value}',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: kDark,
                                ),
                              )),
                        ],
                      )
                    ],
                  ),
                ),

                SizedBox(height: 20.h),

                // Profile Action Buttons Section
                Container(
                  decoration: BoxDecoration(
                    color: kLightwhite,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      ProfileTitleWidget(
                        title: 'Edit Profile',
                        icon: Icons.person,
                        onTap: () {
                          Get.to(() => EditProfileScreen());
                        },
                      ),
                      Divider(),
                      ProfileTitleWidget(
                        title: 'Flight History',
                        icon: Ionicons.planet,
                      ),
                      Divider(),
                      ProfileTitleWidget(
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
                      Divider(),
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

                SizedBox(height: 20.h),

                // Logout Button
                CustomButton(
                  onTap: () {
                    c.logout();
                  },
                  color: kRed,
                  text: 'Logout',
                  btnheigh: 45.h,
                  fontSize: 16.sp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileTitleWidget extends StatelessWidget {
  const ProfileTitleWidget({
    Key? key,
    required this.title,
    required this.icon,
    this.onTap,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
      onTap: onTap,
      leading: Icon(
        icon,
        size: 22.sp,
        color: kSecondary,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: kDark,
          fontWeight: FontWeight.w500,
          fontSize: 14.sp,
        ),
      ),
      trailing: Icon(
        AntDesign.right,
        size: 16.sp,
        color: kGray,
      ),
    );
  }
}
