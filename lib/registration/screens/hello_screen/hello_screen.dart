import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:auto_route/auto_route.dart';
import 'package:whats_app/router/router.gr.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:whats_app/constants.dart';

class HelloScreen extends StatelessWidget {
  const HelloScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.helloWhatsApp)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Image.asset(Constants.imageWatsApp),
            ),
          ),
          Center(
            child: SizedBox(
              width: 300,
              child: RichText(
                textAlign: TextAlign.center,
                softWrap: true,
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: AppLocalizations.of(context)!.agreementPathOne,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context)!.agreementPathTwo,
                      style: const TextStyle(color: Colors.lightBlue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => launch(Constants.businessTerms),
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context)!.agreementPathThree,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context)!.agreementPathFour,
                      style: const TextStyle(color: Colors.lightBlue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => launch(Constants.privacyPolicy),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ElevatedButton(
              onPressed: () => context.replaceRoute(const InputPhoneScreen()),
              child: Text(
                AppLocalizations.of(context)!.acceptAndContinue,
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }
}
