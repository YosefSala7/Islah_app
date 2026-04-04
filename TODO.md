# Fix Quran Page Save Bug

## Steps:
- [x] Step 1: Edit `lib/features/quran_feature/UI/quran_page.dart` to use stateful `_currentPage` with `onPageChanged` listener.
- [ ] Step 2: Verify save button now saves correct current page.
- [ ] Step 3: Test in app: swipe pages, save, restart - should resume correctly.

Current progress: Edits to quran_page.dart completed - save button now correctly saves current page using _currentPage state variable and onPageChanged listener. No more Dart errors.

- [x] Step 1
- [x] Step 2

Additional fix needed: Make quranPage.dart update FAB immediately after returning from reader.

- [x] Step 4: Edit lib/Pages/quranPage.dart to StatefulWidget with Navigator.then to reload lastPage after pop.
