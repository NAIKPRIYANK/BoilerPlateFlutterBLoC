import 'package:bloc/bloc.dart';
import 'package:flutterboilerplateblocpattern/local_user/local_user.dart';


import 'event.dart';
import 'state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashState.initial()) {
    on<SplashInitEvent>(_init);
  }

  /// Handles the initialization event for the Splash screen.
  Future<void> _init(SplashInitEvent event, Emitter<SplashState> emit) async {
    try {
      emit(state.clone(status: SplashStatus.initial));

      //  Check if user data exists in SharedPreferences
      // bool isLoggedIn = await LocalUser().isUserLoggedIn();

      //  Emit success state with login status
      // emit(state.clone(status: SplashStatus.success, isLoggedIn: isLoggedIn));
      emit(state.clone(status: SplashStatus.success));

    } catch (e) {
      //  Handle errors gracefully
      emit(state.clone(status: SplashStatus.failed, errorText: e.toString()));
    }
  }
}
