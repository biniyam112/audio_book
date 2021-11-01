import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';

class PingSiteBloc extends Bloc<PingSiteEvent, PingSiteState> {
  PingSiteBloc() : super(PingSiteState.idle);

  @override
  Stream<PingSiteState> mapEventToState(PingSiteEvent event) async* {
    yield PingSiteState.inProcess;
    try {
      final client = http.Client();
      final result = await client.get(Uri.parse(event.address));

      if (result.statusCode == 200) {
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

  PingSiteEvent({
    this.address = 'http://www.marakigebeya.com.et/swagger/v1/swagger.json',
  });
}
