import 'package:flutter/material.dart';
import 'package:flutter_binary_search/pages/settings.dart';

class HomePage extends StatefulWidget {
  final int? maxRange;
  const HomePage({super.key, this.maxRange});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final List list;
  late var low;
  late var high;
  late var guess;
  late var mid;
  late int maxRange;

  List _history = [];
  String answer = '';

  int _count = 1;

  @override
  void initState() {
    super.initState();
    list = List<int>.generate(widget.maxRange ?? 100, (index) => index + 1);
    low = list[0];
    high = list.last;
    guess = (low + high) ~/ 2;
    //mid = (low + high) / 2;
    maxRange = widget.maxRange ?? 100;
    setState(() {});
  }

  void _restart() {
    _count = 1;
    low = list[0];
    high = list.last;
    guess = (low + high) ~/ 2;
    _history = [];
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.floating, content: Text('Restarted')));
    setState(() {});
  }

  void _addHistory() {
    _history.add('guess: $guess | answer: $answer | new range: $low-$high');
  }

  void _showAnswer() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text('Done! your number is $guess, $_count tries')));
    _restart();
  }

  _clickLess() {
    if (guess >= maxRange || guess <= 1) {
      return;
    }
    _count++;
    answer = 'less';
    high = guess - 1;
    _addHistory();
    guess = (low + high) ~/ 2;
    setState(() {});
  }

  _clickMore() {
    if (guess >= maxRange || guess <= 1) {
      return;
    }
    _count++;
    answer = 'more';
    low = guess + 1;
    _addHistory();
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
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const SettingsPage()));
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 16.0,
              ),
              Text(
                'Think of a number between 1 and $maxRange, my guess:',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              Text(
                '$guess',
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _clickLess();
                    },
                    child: const Text('Less'),
                  ),
                  const SizedBox(width: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      _showAnswer();
                    },
                    child: const Text('Right!'),
                  ),
                  const SizedBox(width: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      _clickMore();
                    },
                    child: const Text('More'),
                  ),
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

              const SizedBox(
                height: 16.0,
              ),

              //*history
              if (_history.isNotEmpty)
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _history.length,
                    itemBuilder: (context, index) {
                      return Text('${_history[index]}');
                    }),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: () {
          _restart();
        },
        child: const Icon(
          Icons.refresh,
          color: Colors.white,
        ),
      ),
    );
  }
}
