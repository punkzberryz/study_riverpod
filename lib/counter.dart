import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final counterProvider = StateProvider<int>((ref) => 0);
final counter2Provider = StateProvider<int>((ref) => 2);

class Counter extends ConsumerWidget {
  static String id = 'Counter page';
  const Counter({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countValue = ref.watch(counterProvider);
    final count2Value = ref.watch(counter2Provider);
    return Scaffold(
      appBar: AppBar(title: const Text('Counter !!')),
      body: Center(
          child: Column(
        children: [
          Text('number = $countValue'),
          Text('2nd number = $count2Value'),
          TextButton(
            onPressed: () {
              ref.watch(counterProvider.notifier).state += 1;
              ref.watch(counter2Provider.notifier).state += 2;
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Press to '),
                Icon(Icons.add),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              if (countValue > 0) {
                ref.watch(counterProvider.notifier).state -= 1;
              }
              if (count2Value > 0) {
                ref.watch(counter2Provider.notifier).state -= 2;
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Press to '),
                Icon(Icons.remove),
              ],
            ),
          )
        ],
      )),
    );
  }
}
