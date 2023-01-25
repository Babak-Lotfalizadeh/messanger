import 'package:flutter/material.dart';
import 'package:messenger/enums/assets.dart';
import 'package:rive/rive.dart';

class TeddyWidget extends StatefulWidget {
  final bool check;
  final bool handsUp;
  final bool success;
  final bool fail;
  final double look;
  final double? size;

  const TeddyWidget({
    this.check = false,
    this.handsUp = false,
    this.success = false,
    this.fail = false,
    this.look = 0.0,
    this.size,
    Key? key,
  }) : super(key: key);

  @override
  State<TeddyWidget> createState() => _TeddyWidgetState();
}

class _TeddyWidgetState extends State<TeddyWidget> {
  final String _stateMachine = "State Machine 1";
  StateMachineController? controller;
  SMIInput<bool>? check;
  SMIInput<bool>? handsUp;
  SMIInput<bool>? success;
  SMIInput<bool>? fail;
  SMIInput<double>? look;

  @override
  void didUpdateWidget(covariant TeddyWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.check != widget.check) {
      check?.change(widget.check);
    }
    if (oldWidget.handsUp != widget.handsUp) {
      handsUp?.change(widget.handsUp);
    }
    if (oldWidget.success != widget.success) {
      success?.change(widget.success);
    }
    if (oldWidget.fail != widget.fail) {
      fail?.change(widget.fail);
    }
    if (oldWidget.look != widget.look) {
      look?.change(widget.look);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = widget.size ?? MediaQuery.of(context).size.height * 0.3;
    return Column(
      children: [
        SizedBox(
          width: size,
          height: size,
          child: RiveAnimation.asset(
            Assets.teddy.value,
            fit: BoxFit.cover,
            onInit: (artboard) {
              controller = StateMachineController.fromArtboard(
                artboard,
                _stateMachine,
              );
              if (controller == null) return;

              artboard.addController(controller!);
              check = controller?.findInput("Check");
              handsUp = controller?.findInput("hands_up");
              success = controller?.findInput("success");
              fail = controller?.findInput("fail");
              look = controller?.findInput("Look");
            },
            stateMachines: [_stateMachine],
          ),
        ),
      ],
    );
  }
}
