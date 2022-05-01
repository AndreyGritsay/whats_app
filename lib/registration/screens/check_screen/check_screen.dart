import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:auto_route/auto_route.dart';
import 'package:whats_app/router/router.gr.dart';
import 'package:whats_app/registration/screens/check_screen/check_bloc/check_bloc.dart';

class CheckScreen extends StatefulWidget {
  final String phoneNumber;

  const CheckScreen({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<CheckScreen> createState() => _CheckScreenState();
}

class _CheckScreenState extends State<CheckScreen> {
  @override
  void initState() {
    sendCode(context, SendCode.sms);
    super.initState();
  }

  final maskFormatter = MaskTextInputFormatter(
    mask: '#######',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  int second = 0;

  late Timer timer;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CheckBloc, CheckState>(
      listener: (context, state) {
        if (state is TheCodeIsCorrect) {
          context.replaceRoute(const CreateProfileScreen());
        }
        if (state is Error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.redAccent,
              duration: const Duration(seconds: 10),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text(state.textError)],
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is InProgress) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        final local = AppLocalizations.of(context)!;
        return Scaffold(
          appBar: AppBar(
            title: Text(local.confirm + ' ' + widget.phoneNumber),
          ),
          body: Center(
            child: Column(
              children: [
                SizedBox(
                  width: 300,
                  child: RichText(
                    textAlign: TextAlign.center,
                    softWrap: true,
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: local.searchSms + ' ' + widget.phoneNumber,
                          style: const TextStyle(color: Colors.grey),
                        ),
                        TextSpan(
                          text: ' ' + local.wrongNumber,
                          style: const TextStyle(color: Colors.lightBlue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => onTapText(context),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Column(
                  children: [
                    SizedBox(
                      width: 180,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        onChanged: (text) => codeEntry(context, text),
                        maxLength: 6,
                        keyboardType: TextInputType.number,
                        inputFormatters: [maskFormatter],
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 25,
                          letterSpacing: 10,
                        ),
                        decoration: const InputDecoration(
                          hintText: '--- ---',
                          contentPadding: EdgeInsets.only(top: 10),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      local.enterDigitCode,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 300,
                  child: Row(
                    children: [
                      TextButton.icon(
                        icon:Icon(Icons.message, color: stateColor()),
                        onPressed: () => sendCode(context, SendCode.sms),
                        label: Text(
                          AppLocalizations.of(context)!.sendAgain,
                          style: TextStyle(color: stateColor()),
                        ),
                      ),
                      const Spacer(flex: 1),
                      Text(viewTimer()),
                    ],
                  ),
                ),
                const SizedBox(width: 300, child: Divider(color: Colors.grey)),
                SizedBox(
                  width: 300,
                  child: Row(
                    children: [
                      TextButton.icon(
                        icon: Icon(Icons.call, color: stateColor()),
                        onPressed: () => sendCode(context, SendCode.sms),
                        label: Text(
                          AppLocalizations.of(context)!.call,
                          style: TextStyle(color: stateColor()),
                        ),
                      ),
                      const Spacer(flex: 1),
                      Text(viewTimer()),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void onTapText(BuildContext context) {
    context.replaceRoute(const InputPhoneScreen());
  }

  void codeEntry(BuildContext context, String smsCode) {
    if (smsCode.length == 6) {
      BlocProvider.of<CheckBloc>(context).add(ResendCode(smsCode));
    }
  }

  void sendCode(BuildContext context, SendCode sendCode) {
    if (second != 0) {
    } else {
      second = 10;
      BlocProvider.of<CheckBloc>(context).add(
        ToGetTheCode(sendCode: sendCode, phoneNumber: widget.phoneNumber),
      );
      timer = Timer.periodic(
        const Duration(seconds: 1),
        (Timer timer) {
          if (second == 0) {
            setState(() => timer.cancel());
          } else {
            setState(() => second--);
          }
        },
      );
    }
  }

  Color stateColor() {
    if (second != 0) {
      return Colors.grey;
    }
    return Colors.teal;
  }

  String viewTimer() {
    if (second != 0) {
      final minStr = ((second / 60) % 60).floor().toString().padLeft(2, '0');
      final secStr = (second % 60).floor().toString().padLeft(2, '0');
      return '$minStr:$secStr';
    }
    return '';
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
