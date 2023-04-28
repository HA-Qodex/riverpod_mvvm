import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_mvvm/models/weather_model.dart';
import 'package:riverpod_mvvm/ui/view_models/home_view_model.dart';

final weatherProvider =
    FutureProvider.family<WeatherModel, String>((ref, location) {
  return ref.watch(homeProvider).getWeather(location: location);
});

class HomeView extends HookConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController();
    var location = useState('Dhaka');
    var weather = ref.watch(weatherProvider(location.value));
    useMemoized(() => weather, [location.value]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: textController,
            ),
            weather.when(
                data: (data) => Text(data.name.toString()),
                error: (error, _) => Text(error.toString()),
                loading: () => const CircularProgressIndicator()),
            ElevatedButton(
                onPressed: () {
                  location.value = textController.value.text;
                },
                child: const Text('Weather'))
          ],
        ),
      ),
    );
  }
}
