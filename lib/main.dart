import 'package:flutter/material.dart';

void main() => runApp(const TipApp());

class TipApp extends StatelessWidget {
  const TipApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tip Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
      ),
      home: const TipPage(),
    );
  }
}

double? parseBill(String input) => double.tryParse(input.trim());

({double tip, double total}) computeTip(double bill, int percent) {
  final tip = bill * percent / 100;
  return (tip: tip, total: bill + tip);
}

class TipPage extends StatefulWidget {
  const TipPage({super.key});

  @override
  State<TipPage> createState() => _TipPageState();
}

class _TipPageState extends State<TipPage> {
  final input = TextEditingController();
  int percent = 15;

  @override
  void dispose() {
    input.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double? bill = parseBill(input.text);

    Widget output;
    if (bill == null || bill < 0) {
      output = const Text('Enter a valid amount');
    } else {
      var answer = computeTip(bill, percent);
      String tip = answer.tip.toStringAsFixed(2);
      String total = answer.total.toStringAsFixed(2);
      output = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Tip: $tip'),
          Text('Total: $total'),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Tip Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: input,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Bill amount',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
            const SizedBox(height: 16),
            SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 10, label: Text('10%')),
                ButtonSegment(value: 15, label: Text('15%')),
                ButtonSegment(value: 20, label: Text('20%')),
              ],
              selected: {percent},
              onSelectionChanged: (chosen) {
                setState(() {
                  percent = chosen.first;
                });
              },
            ),
            const SizedBox(height: 16),
            output,
          ],
        ),
      ),
    );
  }
}
