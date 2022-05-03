import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

class SessionManger extends StatefulWidget {
  const SessionManger({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  State<SessionManger> createState() => _SessionMangerState();
}

class _SessionMangerState extends State<SessionManger>
    with WidgetsBindingObserver {
  late Timer sessionTimer;
  late Timer refereshTokenTimer;
  int refereshTimerCounter = 60;
  int timoutCount = 30;
  // ideal time out count
  // int timoutCount = 1500;
  int count = 0;
  int refershCount = 0;
  @override
  void initState() {
    refereshTokenTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        refershCount += 0;
      });
    });
    sessionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        count += 1;
      });
    });
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    sessionTimer.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        if (count >= timoutCount) {
          log('logging you out');
        }
        break;
      default:
    }
    log('AppLifecycleState: $state seconds = $count');
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
