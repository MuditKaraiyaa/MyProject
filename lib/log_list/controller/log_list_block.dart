import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/log_list_repositories.dart';
import '../presentation/widget/log_list_state.dart';
import 'log_list_event.dart';

class LogListBlock extends Bloc<LogListEvent, LogListState> {
  LogListRepository repository;

  LogListBlock({required this.repository}) : super(LogListState()) {
    on<LogListEvent>((event, emit) async {});
  }
}
