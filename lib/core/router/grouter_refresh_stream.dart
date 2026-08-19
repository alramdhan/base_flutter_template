import 'dart:async';

import 'package:flutter/foundation.dart';

class GrouterRefreshStream extends ChangeNotifier {
  GrouterRefreshStream(Stream<dynamic> stream)  {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
      (_) => notifyListeners()
    );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}