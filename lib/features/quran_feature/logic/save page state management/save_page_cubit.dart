import 'package:app/features/quran_feature/logic/save%20page%20state%20management/save_page_state.dart';
import 'package:app/features/quran_feature/logic/saving_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavePageCubit extends Cubit<PageState> {
  SavePageCubit() : super(InitPage());
  void savePage(int currentPage) {
    saveLastPage(currentPage);
    emit(UpdatePage(page: currentPage));
  }

  void getPage() async {
    int page = await getLastPage();
    emit(UpdatePage(page: page));
  }

  void newKhatma() {
    emit(InitPage());
  }
}
