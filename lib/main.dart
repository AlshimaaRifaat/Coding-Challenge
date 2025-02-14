import 'package:challenge/features/clock/presentation/bloc/clock_bloc.dart';
import 'package:challenge/features/clock/presentation/bloc/clock_event.dart';
import 'package:challenge/features/clock/presentation/widgets/clock_screen.dart';
import 'package:challenge/features/clock/presentation/widgets/prime_screen.dart';
import 'package:challenge/features/number/presentation/bloc/number_bloc.dart';
import 'package:challenge/features/number/presentation/bloc/number_event.dart';
import 'package:challenge/features/number/presentation/bloc/number_state.dart';
import 'package:challenge/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<ClockBloc>()..add(StartClock())),
        BlocProvider(create: (_) => getIt<NumberBloc>()..add(LoadNumber())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<NumberBloc, NumberState>(
      listener: (context, state) {
        if (state is PrimeFound) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PrimeScreen(
                    number: state.number,
                    elapsedTime: state.timeElapsed,
                  ),
                ),
              );
            }
          });
        }
      },
      child: const ClockScreen(),
    );
  }
}
