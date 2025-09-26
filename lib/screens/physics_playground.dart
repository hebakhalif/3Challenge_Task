import 'package:flutter/material.dart';

class PhysicsPlayground extends StatefulWidget {
  const PhysicsPlayground({super.key});

  @override
  State<PhysicsPlayground> createState() => _PhysicsPlaygroundState();
}

class _PhysicsPlaygroundState extends State<PhysicsPlayground> {
  bool amberMatched = false;
  bool blackMatched = false;
  bool redMatched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text("PhysicsPlayground"),
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // الكور
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Draggable<String>(
                data: "black",
                child: buildBall(Colors.black),
                feedback: buildBall(Colors.black, opacity: 0.7),
                childWhenDragging: buildBall(Colors.grey),
              ),
              const SizedBox(width: 20),
              Draggable<String>(
                data: "amber",
                child: buildBall(Colors.amber),
                feedback: buildBall(Colors.amber, opacity: 0.7),
                childWhenDragging: buildBall(Colors.grey),
              ),
              const SizedBox(width: 20),
              Draggable<String>(
                data: "red",
                child: buildBall(Colors.red),
                feedback: buildBall(Colors.red, opacity: 0.7),
                childWhenDragging: buildBall(Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 70),

          // البوكسات
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildTargetBox(
                color: Colors.amber,
                label: "Drop Amber",
                acceptKey: "amber",
                matched: amberMatched,
                onAccept: () {
                  setState(() {
                    amberMatched = true;
                  });
                },
              ),
              const SizedBox(width: 20),
              buildTargetBox(
                color: Colors.black,
                label: "Drop Black",
                acceptKey: "black",
                matched: blackMatched,
                onAccept: () {
                  setState(() {
                    blackMatched = true;
                  });
                },
              ),
              const SizedBox(width: 20),
              buildTargetBox(
                color: Colors.red,
                label: "Drop Red",
                acceptKey: "red",
                matched: redMatched,
                onAccept: () {
                  setState(() {
                    redMatched = true;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget buildTargetBox({
  required Color color,
  required String label,
  required String acceptKey,
  required bool matched,
  required VoidCallback onAccept,
}) {
  return DragTarget<String>(
    onWillAccept: (data) => data == acceptKey,
    onAccept: (data) => onAccept(),
    builder: (context, candidateData, rejectedData) {
      return Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: matched
              ? const Icon(Icons.check, color: Colors.white, size: 30) 
              : Text(
                  label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
        ),
      );
    },
  );
}

Widget buildBall(Color color, {double opacity = 1.0}) {
  return Opacity(
    opacity: opacity,
    child: Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    ),
  );
}

