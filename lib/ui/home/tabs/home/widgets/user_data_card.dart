import 'package:evently_c16_sun/core/providers/app_config_provider.dart';
import 'package:evently_c16_sun/core/theme/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserDataCard extends StatefulWidget {
  final User? user;

  const UserDataCard({this.user, super.key});

  @override
  State<UserDataCard> createState() => _UserDataCardState();
}

class _UserDataCardState extends State<UserDataCard> {
  late AppConfigProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppConfigProvider>(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: provider.isDark() ? AppColors.darkPurple : AppColors.purple,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(24),
          bottomLeft: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome Back ✨",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color:
                              provider.isDark()
                                  ? AppColors.offWhite
                                  : AppColors.lightBlue,
                        ),
                      ),
                      Text(
                        widget.user?.displayName ?? "No Name",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color:
                              provider.isDark()
                                  ? AppColors.offWhite
                                  : AppColors.lightBlue,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    provider.changeTheme(
                      provider.isDark() ? ThemeMode.light : ThemeMode.dark,
                    );
                  },
                  icon: Icon(
                    provider.isDark() ? Icons.dark_mode : Icons.light_mode,
                    color:
                        provider.isDark()
                            ? AppColors.offWhite
                            : AppColors.lightBlue,
                  ),
                ),
                InkWell(
                  onTap: () {
                    provider.changeLocale(provider.isEn() ? "ar" : "en");
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color:
                          provider.isDark()
                              ? AppColors.offWhite
                              : AppColors.lightBlue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      provider.isEn() ? "En" : "ع",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(
                  Icons.location_on_sharp,
                  color:
                      provider.isDark()
                          ? AppColors.offWhite
                          : AppColors.lightBlue,
                ),
                SizedBox(width: 8,),
                Text(
                  "Cairo , Egypt",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color:
                    provider.isDark()
                        ? AppColors.offWhite
                        : AppColors.lightBlue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
