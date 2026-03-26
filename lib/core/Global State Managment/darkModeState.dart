import 'package:app/core/Global%20State%20Managment/darkModeCubit.dart';
import 'package:equatable/equatable.dart';

sealed class DarkModeState extends Equatable {
  final bool isDark; 

  const DarkModeState({required this.isDark});

  @override
  List<Object?> get props => [isDark];
}

class DarkModeInitial extends DarkModeState {
  DarkModeInitial(bool isDark) : super(isDark: isDark);
}

class DarkModeUpdated extends DarkModeState {
  const DarkModeUpdated({required bool DarkStatus}) : super(isDark: DarkStatus);
}