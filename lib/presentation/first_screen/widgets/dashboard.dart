import 'dart:ffi' as ffi;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rive/rive.dart' as rive;
import 'package:rive/rive.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  SMITrigger? input;

  void _onRiveInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(artboard, 'input');
    artboard.addController(controller!);
    input = controller.findInput<ffi.Float>('input') as SMITrigger;
  }

  @override
  Widget build(BuildContext context) {
    final Size screenDimens = MediaQuery.of(context).size;
    return Container(
        width: screenDimens.width,
        height: screenDimens.width / 1.2,
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: rive.RiveAnimation.asset(
          "assets/tree_anim.riv",
          onInit: (artboard) {
            _onRiveInit(artboard);
          },
        ));
  }
}
