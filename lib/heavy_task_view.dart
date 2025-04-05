
// heavy_task_view.dart
import 'dart:async';
import 'dart:isolate';
import 'package:flutter/material.dart';

class HeavyTaskView extends StatefulWidget {
  const HeavyTaskView({super.key});

  @override
  State<HeavyTaskView> createState() => _HeavyTaskViewLogic();
}

class _HeavyTaskViewLogic extends State<HeavyTaskView> {
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    debugPrint("🟢 HeavyTaskView initialized");
  }

  void _runHeavyComputation() async {
    if (_isProcessing) return;

    setState(() => _isProcessing = true);
    debugPrint("⚙️ Starting isolate task");

    final outcome = await _computeInIsolate();

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Resultado: $outcome")),
    );

    setState(() => _isProcessing = false);
  }

  Future<int> _computeInIsolate() async {
    final port = ReceivePort();
    await Isolate.spawn(_intensiveSumTask, port.sendPort);
    return await port.first as int;
  }

  static void _intensiveSumTask(SendPort port) {
    int total = 0;
    for (int i = 1; i <= 2000000; i++) {
      total += i;
    }
    port.send(total);
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("🟡 Rendering HeavyTaskView");
    return Scaffold(
      appBar: AppBar(title: const Text("Tarea Pesada (Isolate)")),
      body: Center(
        child: ElevatedButton(
          onPressed: _isProcessing ? null : _runHeavyComputation,
          child: const Text("Ejecutar tarea"),
        ),
      ),
    );
  }

  @override
  void dispose() {
    debugPrint("🔴 HeavyTaskView disposed");
    super.dispose();
  }
}

