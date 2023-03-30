import 'package:flutter/material.dart';
import 'package:uber_app/screens/MainScreens/HomeScreen.dart';

class BikesScreen extends StatefulWidget {
  const BikesScreen({Key? key}) : super(key: key);

  @override
  State<BikesScreen> createState() => _BikesScreenState();
}

class _BikesScreenState extends State<BikesScreen> {
  bool currentBikeState = true;
  int text = 0;
  int text1 = 0;
  int previousElapsedTimeInSeconds = 0;
  DateTime? startTime;
  DateTime? stopTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => const HomeScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
            const Expanded(
              child: SizedBox(),
            ),
            Center(
              child: Text(text.toString()),
            ),
            Center(
              child: Text(text1.toString()),
            ),
            const Expanded(
              child: SizedBox(),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              decoration: BoxDecoration(
                color: currentBikeState
                    ? const Color(0xFF39D4AA)
                    : Colors.redAccent,
                borderRadius: BorderRadius.circular(4),
              ),
              child: TextButton(
                onPressed: () {
                  if (currentBikeState) {
                    // Start timer
                    startTime = DateTime.now();
                    print('Start time: $startTime');
                  } else {
                    // Stop timer and save elapsed time
                    stopTime = DateTime.now();
                    print('Stop time: $stopTime');
                    final elapsedDuration =
                        stopTime?.difference(startTime!) ?? Duration();
                    final elapsedTimeInSeconds = elapsedDuration.inSeconds;
                    previousElapsedTimeInSeconds += elapsedTimeInSeconds;
                    print('Elapsed time: ${elapsedDuration.inSeconds} seconds');
                  }
                  setState(() {
                    currentBikeState = !currentBikeState;
                    if (currentBikeState) {
                      // If starting timer again, show previous elapsed time
                      text = previousElapsedTimeInSeconds ~/ 60;
                      text1 = previousElapsedTimeInSeconds % 60;
                    } else {
                      // If stopping timer, show 0 elapsed time
                      text = 0;
                      text1 = 0;
                    }
                  });
                },
                child: currentBikeState
                    ? const Text(
                        "Activate",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        "Deactivate",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
