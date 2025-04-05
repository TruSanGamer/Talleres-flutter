// counter_view.dart
import 'dart:async';
import 'package:flutter/material.dart';

class CounterView extends StatefulWidget {
  const CounterView({super.key});

  @override
  State<CounterView> createState() => _CounterViewLogic();
}

class _CounterViewLogic extends State<CounterView> {
  int _count = 0;
  Timer? _timerHandler;

  @override
  void initState() {
    super.initState();
    debugPrint("🟢 CounterView initialized");
  }

  void _startCounting() {
    if (_timerHandler?.isActive != true) {
      _timerHandler = Timer.periodic(
        const Duration(seconds: 1),
        (_) {
          debugPrint("⚡ Updating count");
          setState(() => _count++);
        },
      );
    }
  }

  void _pauseCounting() {
    debugPrint("⏸ Count paused");
    _timerHandler?.cancel();
  }

  void _resetCounting() {
    debugPrint("🔄 Count reset");
    _timerHandler?.cancel();
    setState(() => _count = 0);
    _startCounting();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("🟡 Rendering CounterView");
    return Scaffold(
      appBar: AppBar(title: const Text("Automatic counter")),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Contador: $_count", style: const TextStyle(fontSize: 32)),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _startCounting, child: const Text("Start")),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: _pauseCounting, child: const Text("Pause")),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: _resetCounting, child: const Text("Restart")),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timerHandler?.cancel();
    debugPrint("🔴 CounterView disposed");
    super.dispose();
  }
}