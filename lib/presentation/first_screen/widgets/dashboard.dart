import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rive/rive.dart' as rive;

class Dashboard extends ConsumerWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size screenDimens = MediaQuery.of(context).size;
    return Container(
        width: screenDimens.width,
        height: screenDimens.width / 1.2,
        padding: const EdgeInsets.all(8),
        child: rive.RiveAnimation.asset("assets/tree_anim.riv"));
  }
}
