import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:whats_app/registration/screens/barrel_widgets.dart';

class InputPhoneScreen extends StatefulWidget {
  const InputPhoneScreen({Key? key}) : super(key: key);

  @override
  State<InputPhoneScreen> createState() => _InputPhoneScreenState();
}

class _InputPhoneScreenState extends State<InputPhoneScreen> {
  late String phoneNumber;

  final maskFormatter = MaskTextInputFormatter(
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );
  static const _border = Border(bottom: BorderSide(width: 1));

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return BlocBuilder<InputPhoneBloc, InputPhoneState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text(localization.numberConfirmation)),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Spacer(flex: 15),
              SizedBox(
                width: 300,
                child: Text(
                  AppLocalizations.of(context)!.smsMessage,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              const Spacer(flex: 1),
              Container(
                width: 300,
                decoration: const BoxDecoration(border: _border),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        state.country.name,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    InkWell(
                      child: const Icon(Icons.arrow_drop_down),
                      onTap: () => chooseCountry(),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 18),
                    width: 70,
                    decoration: const BoxDecoration(border: _border),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add, color: Colors.grey.shade700),
                        Text(
                          state.country.dialCode,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 220,
                    child: TextFormField(
                      maxLength: state.country.maxLength,
                      keyboardType: TextInputType.number,
                      inputFormatters: [maskFormatter],
                      style: Theme.of(context).textTheme.subtitle1,
                      onChanged: (text) => inputPhoneNumber(
                        text: text,
                        country: state.country,
                      ),
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.phoneNumber,
                        contentPadding: const EdgeInsets.only(top: 22),
                        counter: const Offstage(),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(flex: 50),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: ElevatedButton(
                  child: Text(AppLocalizations.of(context)!.next),
                  onPressed: () => pressNextButton(state),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  AppLocalizations.of(context)!.smsFee,
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void chooseCountry() {
    showDialog<Country>(
      context: context,
      builder: (_) {
        return const AlertDialog(content: Countries());
      },
    );
  }

  void inputPhoneNumber({required String text, required Country country}) {
    if (text.length == country.maxLength) {
      BlocProvider.of<InputPhoneBloc>(context, listen: false).add(
        PhoneIntroduced(country.dialCode + text),
      );
    } else {
      BlocProvider.of<InputPhoneBloc>(context, listen: false).add(
        ResetPhoneNumber(),
      );
    }
  }

  void pressNextButton(InputPhoneState state) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return const NextButton();
      },
    );
  }
}
