import 'package:app/features/quran_feature/logic/save%20page%20state%20management/save_page_state.dart';
import 'package:app/features/quran_feature/logic/saving_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavePageCubit extends Cubit<PageState> {
  SavePageCubit() : super(PageState(page: 1, verse: 1));
  void savePage(int currentPage) async {
    await saveLastPage(currentPage);
    emit(state.copyWith(page: currentPage));
  }
  void savePageAndVerse(int currentPage,int verse) async {
    await saveLastPage(currentPage);
    await saveVerse(verse);
    emit(state.copyWith(page: currentPage,verse:verse));
  }

  void getPage() async {
    int page = await getLastPage();
    emit(state.copyWith(page: page));
  }
  void getPageAndVerse() async {
    int page = await getLastPage();
    int verse = await getLastVerse();
    emit(state.copyWith(page: page,verse: verse));
  }

  void newKhatma() async {
    await saveLastPage(1);
    emit(state.copyWith(page: 1, verse: 1));
  }
}
