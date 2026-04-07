import 'package:app_tp2/models/pointage.dart';
import 'package:app_tp2/screens/app_scaffolding.dart';
import 'package:app_tp2/services/pointage_service.dart';
import 'package:flutter/material.dart';

class DebugScreen extends StatefulWidget {
  const DebugScreen({super.key});

  @override
  State<StatefulWidget> createState() => _DebugScreenState();
}

class _DebugScreenState extends State<DebugScreen> {
  Future<List<Pointage>> getPointages() async {
    return await PointageService.getPointages();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffolding(
      title: 'Debug',
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ElevatedButton(
            onPressed: () async {PointageService.clearPointages();},
            child: Row(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  padding: const EdgeInsets.all(12),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.delete_outline_rounded,
                    color: Colors.blue,
                  ),
                ),
                Expanded(
                  child: Text("Clear pointages")
                ),
              ],
            )
          )
        ],
      )
    );
  }
}