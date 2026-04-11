import 'package:equatable/equatable.dart';

sealed class TasbihState extends Equatable {
  final int count;

  const TasbihState({required this.count});

  @override
  List<Object> get props => [count];
}
class InitTasbih extends TasbihState {
  const InitTasbih() : super(count: 0);
}

class UpdateTasbih extends TasbihState {
  const UpdateTasbih({required super.count});
}