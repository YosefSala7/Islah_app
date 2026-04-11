import 'package:app/features/azkar_feature/logic/tasbih_cubit.dart';
import 'package:app/features/azkar_feature/logic/tasbih_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TasbihPage extends StatelessWidget {
  const TasbihPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TasbihCubit(),
      child: Builder(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: context.read<TasbihCubit>().increaseTasbih,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          "assets/imgs/sibhah.png",
                          width: MediaQuery.widthOf(context) / 1.2,
                        ),
                        BlocBuilder<TasbihCubit, TasbihState>(
                          buildWhen: (previous, current) =>
                              previous.count != current.count,
                          builder: (context, state) {
                            return Positioned(
                              top: MediaQuery.widthOf(context) / 6,
                              child: Text(
                                state.count.toString().padLeft(4, "0"),
                                style: TextStyle(
                                  fontFamily: "Digital-7",
                                  color: Color(0xFFC0A040),
                                  fontSize: MediaQuery.widthOf(context) / 5,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<TasbihCubit>().resetTasbih();
                    },
                    child: Text("reset".tr()),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
