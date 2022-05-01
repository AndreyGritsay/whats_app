import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app/main_screen/main_screen_bloc/main_screen_bloc.dart';
import 'package:whats_app/router/router.gr.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String userName = '';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainBloc, MainScreenState>(
      listener: (context, state) {
        if (state is UserNotRegistration) {
          context.replaceRoute(const HelloScreen());
        }
        if (state is UserRegistration) {
          userName = state.userName;
        }
      },
      builder: (context, state) {
        if (state is Progress) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }
        return Scaffold(
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 300,
                  child: Text(
                    'Поздравляю, вы успешно прошли регистрацию. Ваше имя - $userName. Вы можете удалить профиль и пройти семь кругов ада заново.',
                    textAlign: TextAlign.center,
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.delete_forever,
                    size: 60,
                    color: Colors.redAccent,
                  ),
                  onPressed: () => BlocProvider.of<MainBloc>(context).add(
                    UserDeleted(),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
