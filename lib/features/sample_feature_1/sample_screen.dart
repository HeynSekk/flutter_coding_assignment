import 'package:flutter/material.dart';
import 'package:flutter_sample_app/features/sample_feature_1/sample_cubit.dart';

class SampleScreen extends StatelessWidget {
  final SampleCubit sampleCubit;
  const SampleScreen({super.key, required this.sampleCubit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            ElevatedButton(
                onPressed: () {
                  sampleCubit.init();
                },
                child: const Text('go')),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // context.read<SampleCubit>().increment();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class SampleScreen2 extends StatelessWidget {
  final SampleCubit2 sampleCubit;
  const SampleScreen2({super.key, required this.sampleCubit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Screen2'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            ElevatedButton(
                onPressed: () {
                  sampleCubit.init();
                },
                child: const Text('go')),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // context.read<SampleCubit>().increment();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class SampleScreen3 extends StatelessWidget {
  final SampleCubit3 sampleCubit;
  const SampleScreen3({super.key, required this.sampleCubit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Screen3'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            ElevatedButton(
                onPressed: () {
                  sampleCubit.init();
                },
                child: const Text('go')),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // context.read<SampleCubit>().increment();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class SampleScreen4 extends StatelessWidget {
  final SampleCubit4 sampleCubit;
  const SampleScreen4({super.key, required this.sampleCubit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Screen4'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            ElevatedButton(
                onPressed: () {
                  sampleCubit.init();
                },
                child: const Text('go')),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // context.read<SampleCubit>().increment();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class SampleScreen5 extends StatelessWidget {
  final SampleCubit5 sampleCubit;
  const SampleScreen5({super.key, required this.sampleCubit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Screen5'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            ElevatedButton(
                onPressed: () {
                  sampleCubit.init();
                },
                child: const Text('go')),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // context.read<SampleCubit>().increment();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
