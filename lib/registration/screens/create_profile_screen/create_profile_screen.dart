import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:whats_app/registration/data_provider/data_provider.dart';
import 'package:whats_app/registration/screens/create_profile_screen/create_profile_bloc/create_profile_bloc.dart';
import 'package:whats_app/router/router.gr.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  String profileName = '';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateProfileBloc, CreateProfileState>(
      listener: (context, state) {
        if (state is NextPage) {
          context.replaceRoute(const MainScreen());
        }
        if (state is Error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.redAccent,
              duration: const Duration(seconds: 10),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text(state.errorText)],
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
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            elevation: 0,
            title: Text(
              AppLocalizations.of(context)!.profile,
              style: const TextStyle(
                color: Colors.teal,
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  AppLocalizations.of(context)!.enterYourName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 17),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: const Icon(Icons.photo_camera, color: Colors.white),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  SizedBox(
                    width: 250,
                    child: TextFormField(
                      onChanged: (text) {
                        profileName = text;
                      },
                      maxLength: 25,
                      cursorColor: Colors.teal,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.ivanIvanov,
                        contentPadding: const EdgeInsets.only(top: 10),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(Icons.emoji_emotions_outlined),
                  ),
                ],
              ),
              const Spacer(flex: 1),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ElevatedButton(
                  child: Text(AppLocalizations.of(context)!.next),
                  onPressed: () => next(context),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.teal,
                    ),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    ),
                    textStyle: MaterialStateProperty.all<TextStyle>(
                      const TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void next(BuildContext context) {
    BlocProvider.of<CreateProfileBloc>(context).add(
      ProfileNameEntered(profileName),
    );
  }
}
