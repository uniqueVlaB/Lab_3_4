import 'package:flutter/material.dart';

class PortTitleWidget extends StatefulWidget {
  final List<String> names;
  final List<String> addresses;
  final void Function() onNextPressed;
  final void Function() onPrevPressed;

  const PortTitleWidget({
    Key? key,
    required this.names,
    required this.addresses,
    required this.onNextPressed,
    required this.onPrevPressed,
  }) : super(key: key);

  @override
  PortTitleWidgetState createState() => PortTitleWidgetState();
}

class PortTitleWidgetState extends State<PortTitleWidget> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RawMaterialButton(
                onPressed: () {
                  widget.onPrevPressed();
                  setState(() {
                    currentIndex = (currentIndex - 1 + widget.names.length) % widget.names.length;
                  });
                },
                child: const Icon(Icons.arrow_back_ios),
              ),
              Expanded(
                child: Column(
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (Widget child, Animation<double> animation) {
                        return SlideTransition(
                          position: Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0)).animate(animation),
                          child: child,
                        );
                      },
                      child: Text(
                        widget.names[currentIndex],
                        key: ValueKey<String>(widget.names[currentIndex]),
                        style: const TextStyle(fontSize: 30),
                        softWrap: true,
                      ),
                    ),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (Widget child, Animation<double> animation) {
                        return SlideTransition(
                          position: Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0)).animate(animation),
                          child: child,
                        );
                      },
                      child: Text(
                        widget.addresses[currentIndex],
                        key: ValueKey<String>(widget.addresses[currentIndex]),
                        style: const TextStyle(fontSize: 20),
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
              ),
              RawMaterialButton(
                onPressed: () {
                  widget.onNextPressed();
                  setState(() {
                    currentIndex = (currentIndex + 1) % widget.names.length;
                  });
                },
                child: const Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),
          Text("${currentIndex + 1} of ${widget.names.length}")
        ],
      ),
    );
  }
}
