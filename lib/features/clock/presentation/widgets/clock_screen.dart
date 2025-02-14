import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/clock_bloc.dart';
import '../bloc/clock_state.dart';

class DateFormatter {
  /// Formats the time in HH:mm format
  static String formatTime(DateTime dateTime) {
    return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  }

  /// Formats the date in 'E. d. MMM' format, e.g., "So. 2. Feb"
  static String formatDate(DateTime dateTime) {
    return DateFormat('E. d. MMM').format(dateTime);
  }

  /// Calculates the approximate week number in the month
  static String formatWeekNumber(DateTime dateTime) {
    return "KW ${((dateTime.day - 1) ~/ 7) + 1}";
  }
}

class ClockScreen extends StatelessWidget {
  const ClockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: BlocBuilder<ClockBloc, ClockState>(
          builder: (context, state) {
            if (state is ClockUpdated) {
              DateTime now = state.currentTime;
              String formattedTime = DateFormatter.formatTime(now);
              String formattedDate = DateFormatter.formatDate(now);
              String weekNumber = DateFormatter.formatWeekNumber(now);

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    formattedTime,
                    style: const TextStyle(
                      fontSize: 80,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "$formattedDate $weekNumber",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      color: Colors.white70,
                    ),
                  ),
                ],
              );
            }
            return const CircularProgressIndicator(color: Colors.white);
          },
        ),
      ),
    );
  }
}
