import 'package:equatable/equatable.dart';

sealed class PageState extends Equatable { 
  final int page;

  const PageState({required this.page});

  @override
  List<Object?> get props => [page]; 
}

class InitPage extends PageState {
  const InitPage() : super(page: 1);
}

class UpdatePage extends PageState {
  const UpdatePage({required super.page});
}