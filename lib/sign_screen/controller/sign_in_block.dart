import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xbridge/common/utils/NotificationServices.dart';
import 'package:xbridge/sign_screen/controller/sign_in_event.dart';
import 'package:xbridge/sign_screen/controller/sign_in_state.dart';
import 'package:xbridge/sign_screen/data/repositories/sign_in_repositories.dart';

import '../../common/constants/globals.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignInRepository repository;

  SignInBloc({required this.repository}) : super(SignInInitState()) {
    on<SignInInitEvent>((event, emit) {
      emit(SignInInitState());
    });

    on<SignInVerificationEvent>((event, emit) async {
      emit(SignInLoadingState());

      try {
        final result = await repository.verifyUser(event.email, event.password);

        if (result.result.result == "error") {
          emit(SignInErrorState(message: result.result.message));
        } else {
          getJson(result.result.toJson());
          emit(SignInLoadedState(response: result));

          await repository.updateUserDeviceToken(
            result.result.sysId,
            await NotificationService.getDeviceToken(),
          );
        }
      } catch (e) {
        emit(SignInErrorState(message: e.toString()));
      }
    });

    on<GetAccessTokenEvent>((event, emit) async {
      try {
        final result = await repository.getAccessToken();
        emit(AccessToeknLoadedState(response: result));
      } catch (e) {
        emit(AccessToeknErrorState(message: e.toString()));
      }
    });

    on<LogoutEvent>((event, emit) async {
      try {
        await repository.updateUserDeviceToken(event.sysId, "");
        emit(SignInInitState());
      } catch (e) {
        emit(SignInErrorState(message: e.toString()));
      }
    });
  }
}
