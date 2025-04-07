import 'package:flutter/material.dart';
import 'package:savory_book/Screens/code_exractions/appbar_theme.dart';

class PrivacyPolicy extends StatelessWidget {
  PrivacyPolicy({super.key});

  final List<String> privacyPolicies = [
    "We do not collect, store, or share any personal information from users.",
    "All data, including recipes and user preferences, is stored locally on the user's device.",
    "The app operates offline and does not require an internet connection.",
    "Users have full control over their data and can delete it at any time.",
    "No third-party services or APIs are used for data processing.",
    "The app does not track or monitor user activity beyond optional app usage time tracking stored locally.",
    "We do not use cookies or other tracking mechanisms.",
    "Updates to this privacy policy will be communicated through version notes when new app versions are released.",
    "By using the app, users agree to these privacy terms.",
    "For any concerns, users can reach out through the provided support contact within the app.",
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
      
            OurAppBarTheme(
              title: 'Privacy & Policy',
              onTap: () {
                Navigator.pop(context);
              },
            ),
            
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 10),
                shrinkWrap: true,
                itemCount: privacyPolicies.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('. ', style: TextStyle(fontSize: 30,height: .6,fontWeight: FontWeight.w600)),
                        Expanded(child: Text(privacyPolicies[index], style: const TextStyle(fontSize: 19)))
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
