import 'package:xbridge/setting/controller/settings_event.dart';
import 'package:xbridge/setting/controller/settings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/settings_repositories.dart';

class SettingsBlock extends Bloc<SettingsEvent, SettingsState> {
  SettingsRepository repository;

  SettingsBlock({required this.repository}) : super(SettingsLoadingState()) {
    on<SettingsEvent>((event, emit) async {});
  }
}
