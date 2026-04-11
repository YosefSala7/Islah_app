import 'package:app/features/azkar_feature/logic/tasbih_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TasbihCubit extends Cubit<TasbihState> {
  TasbihCubit():super(InitTasbih());

  void increaseTasbih(){
    emit(UpdateTasbih(count: state.count + 1));
  }
  void resetTasbih(){
    emit(InitTasbih());
  }
}