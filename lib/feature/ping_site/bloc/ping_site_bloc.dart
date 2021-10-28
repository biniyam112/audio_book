import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

class PingSiteBloc extends Bloc<PingSiteEvent, PingSiteState> {
  PingSiteBloc() : super(PingSiteState.idle);

  @override
  Stream<PingSiteState> mapEventToState(PingSiteEvent event) async* {
    yield PingSiteState.inProcess;
    try {
      final result =
          await InternetAddress.lookup('http://www.marakigebeya.com.et');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        yield PingSiteState.success;
      }
    } on SocketException catch (_) {
      yield PingSiteState.failed;
    } catch (e) {
      yield PingSiteState.failed;
    }
  }
}

enum PingSiteState {
  idle,
  success,
  inProcess,
  failed,
}

class PingSiteEvent {
  final String address;

  PingSiteEvent({required this.address});
}
