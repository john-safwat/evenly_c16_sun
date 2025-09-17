import 'package:evently_c16_sun/data/firebase/firebase_auth_service.dart';
import 'package:evently_c16_sun/ui/home/tabs/home/widgets/user_data_card.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UserDataCard(user: FirebaseAuthService.getUerData())
      ],
    );
  }
}
