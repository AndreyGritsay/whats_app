import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app/router/router.gr.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:whats_app/registration/screens/barrel_widgets.dart';


class NextButton extends StatelessWidget {
  const NextButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InputPhoneBloc, InputPhoneState>(
      builder: (context, state) {
        if (state is ConfirmPhone) {
          return _CorrectPhoneWidget(phoneNumber: state.phoneNumber);
        }
        return const _UnCorrectPhoneWidget();
      },
    );
  }
}

class _CorrectPhoneWidget extends StatelessWidget {
  final String phoneNumber;

  const _CorrectPhoneWidget({
    Key? key,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      titlePadding: const EdgeInsets.all(10),
      buttonPadding: EdgeInsets.zero,
      title: Text(
        AppLocalizations.of(context)!.confirmNumber,
        style: Theme.of(context).textTheme.headline6,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(phoneNumber, style: Theme.of(context).textTheme.headline5),
          const SizedBox(height: 5),
          Text(
            AppLocalizations.of(context)!.changeTheNumber,
            style: Theme.of(context).textTheme.headline6,
          ),
        ],
      ),
      actions: <Widget>[
        Row(
          children: [
            TextButton(
              onPressed: () => pressCorrect(context),
              child: Text(
                AppLocalizations.of(context)!.correct,
                style: const TextStyle(color: Colors.teal),
              ),
            ),
            const Spacer(flex: 1),
            TextButton(
              onPressed: () => pressOk(context),
              child: Text(
                AppLocalizations.of(context)!.ok,
                style: const TextStyle(color: Colors.teal),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void pressCorrect(BuildContext context) {
    Navigator.of(context).pop();
  }

  void pressOk(BuildContext context) {
    context.replaceRoute(CheckScreen(phoneNumber: '+' + phoneNumber));
  }
}

class _UnCorrectPhoneWidget extends StatelessWidget {
  const _UnCorrectPhoneWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      content: Text(
        AppLocalizations.of(context)!.enterAValidPhone,
        style: Theme.of(context).textTheme.headline6,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            AppLocalizations.of(context)!.ok,
            style: const TextStyle(color: Colors.teal),
          ),
        ),
      ],
    );
  }
}
