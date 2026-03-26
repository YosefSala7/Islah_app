import 'package:app/core/Global%20State%20Managment/darkModeCubit.dart';
import 'package:app/core/Global%20State%20Managment/darkModeState.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Dark Mode".tr()),
              BlocBuilder<DarkCubit, DarkModeState>(
                builder: (context, state) {
                  return Switch(
                    value: state.isDark,
                    onChanged: (_) => context.read<DarkCubit>().onClick(),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
