import 'package:flutter/material.dart';

class PortActionsButtonArrayWidget extends StatelessWidget {
  final void Function() onIncrementPressed;
  final void Function() onDeletePressed;
  final void Function() onCopyPressed;
  final void Function() onEditPressed;

  const PortActionsButtonArrayWidget({super.key, required this.onIncrementPressed, required this.onDeletePressed,
    required this.onCopyPressed, required this.onEditPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 125,
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RawMaterialButton(
                padding: const EdgeInsets.all(15),
                fillColor: Colors.amberAccent,
                shape: const CircleBorder(),
                onPressed: onIncrementPressed,
                child: const Icon(Icons.plus_one),
              ),
              RawMaterialButton(
                padding: const EdgeInsets.all(15),
                fillColor: Colors.amberAccent,
                shape: const CircleBorder(),
                onPressed: onCopyPressed,
                child: const Icon(Icons.copy),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RawMaterialButton(
                padding: const EdgeInsets.all(15),
                fillColor: Colors.amberAccent,
                shape: const CircleBorder(),
                onPressed: onEditPressed,
                child: const Icon(Icons.edit),
              ),
              RawMaterialButton(
                padding: const EdgeInsets.all(15),
                fillColor: Colors.amberAccent,
                shape: const CircleBorder(),
                onPressed: onDeletePressed,
                child: const Icon(Icons.delete),
              ),
            ],
          ),
        ],
      ),
    );
  }
}