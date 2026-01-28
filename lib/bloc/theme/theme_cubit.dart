import 'package:bloc/bloc.dart';
import '../../data/repositories/settings/settings_repository.dart';

class ThemeCubit extends Cubit<bool> {
  final SettingsRepository repo;

  ThemeCubit(this.repo) : super(repo.loadTheme());

  void toggle() {
    final newValue = !state;
    repo.saveTheme(newValue);
    emit(newValue);
  }
}
