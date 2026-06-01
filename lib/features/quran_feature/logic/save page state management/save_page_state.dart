import 'package:equatable/equatable.dart';

class PageState extends Equatable {
  final int? page;
  final int? verse;

  const PageState({required this.page, required this.verse});

  PageState copyWith({int? page, int? verse}) {
    return PageState(page: page ?? this.page, verse: verse ?? this.verse);
  }

  @override
  List<Object?> get props => [page,verse];
}
