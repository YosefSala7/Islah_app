import 'package:app/Global%20State%20Managment/darkModeState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DarkCubit extends Cubit<DarkModeState> {
  DarkCubit() : super(DarkModeInitial());
  void onClick() {
    emit(DarkModeUpdated(DarkStatus: !state.isDark));
  }
}
