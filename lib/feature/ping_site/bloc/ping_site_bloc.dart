import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';

class PingSiteBloc extends Bloc<PingSiteEvent, PingSiteState> {
  PingSiteBloc() : super(PingSiteState.idle) {
    on<PingSiteEvent>(_onPingSiteEvent);
  }

  Future<void> _onPingSiteEvent(
      PingSiteEvent pingSiteEvent, Emitter<PingSiteState> emitter) async {
    emitter(PingSiteState.inProcess);
    try {
      final client = http.Client();
      final result = await client.get(Uri.parse(pingSiteEvent.address));

      if (result.statusCode == 200) {
        emitter(PingSiteState.success);
      }
    } on SocketException catch (_) {
      emitter(PingSiteState.failed);
    } catch (e) {
      emitter(PingSiteState.failed);
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

  PingSiteEvent({
    this.address = 'http://www.marakigebeya.com.et/swagger/v1/swagger.json',
  });
}
