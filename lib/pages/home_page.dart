import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final list = List<int>.generate(100, (index) => index + 1);
  late var low;
  late var high;
  late var guess;
  late var mid;

  @override
  void initState() {
    super.initState();
    low = list[0];
    high = list.last;
    guess = (low + high) ~/ 2;
    //mid = (low + high) / 2;
    setState(() {});
  }

  void _restart() {
    low = list[0];
    high = list.last;
    guess = (low + high) ~/ 2;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Binary search'),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Think about a number between 1 and 100, my guess:',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Text(
              '$guess',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () {
                    high = guess - 1;
                    guess = (low + high) ~/ 2;
                    setState(() {});
                  },
                  child: const Text('Less'),
                ),

                const SizedBox(width: 8.0),

                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        behavior: SnackBarBehavior.floating,
                        content: Text('Done! your number is $guess')));
                    _restart();
                  },
                  child: const Text('RIGHT!'),
                ),

                // ElevatedButton(
                //   onPressed: () {
                //     //print(list);

                //   },
                //   child: Text('Right'),
                // ),

                const SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () {
                    low = guess + 1;
                    guess = (low + high) ~/ 2;
                    setState(() {});
                  },
                  child: const Text('More'),
                ),

                const SizedBox(width: 8.0),
              ],
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              'Searching between $low and $high',
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              behavior: SnackBarBehavior.floating, content: Text('Restarted')));
          _restart();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
