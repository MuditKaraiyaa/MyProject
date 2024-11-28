

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xbridge/sd_agent/controller/sd_agent_event.dart';

import '../data/repository/sd_agent_repository.dart';
import '../presentation/widget/sd_agent_state.dart';


class SdAgentBloc extends Bloc<SDAgentEvent, SDAgentState> {
  SdAgentBloc({required SDAgentRepositoryImpl repository}) : super(SDAgentState()) {
    on<SDAgentEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
