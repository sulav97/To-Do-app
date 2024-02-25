import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:to_do_app/utils/app_style.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import '../utils/app_style.dart';

class Timer extends StatefulWidget {
  const Timer({super.key});

  @override
  State<Timer> createState() => _TimerState();
}

class _TimerState extends State<Timer> with TickerProviderStateMixin {
  late AnimationController controller;
  bool play = false;

  String get count {
    Duration count = controller.duration! * controller.value;
    return controller.isDismissed
        ? '${(controller.duration!.inHours % 60).toString().padLeft(2, '0')}:${(controller.duration!.inMinutes % 60).toString().padLeft(2, '0')}:${(controller.duration!.inSeconds % 60).toString().padLeft(2, '0')}'
        : '${(count.inHours % 60).toString().padLeft(2, '0')}:${(count.inMinutes % 60).toString().padLeft(2, '0')}:${(count.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  void not() {
    if (controller == '0:00:00') {
      FlutterRingtonePlayer.playNotification();
    }
  }

  double progrss = 1.0;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 60));

    //run when controller value change
    controller.addListener(() {
      not();
      if (controller.isAnimating) {
        setState(() {
          progrss = controller.value;
        });
      } else {
        progrss = 1.0;
        play = false;
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          height: size.height * 0.18,
          width: double.infinity,
          decoration: BoxDecoration(
            color: style.green,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              'Set timer',
              style: style.textStyleWhite,
            ),
          ),
        ),
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            SizedBox(
              width: size.width * 0.8,
              height: size.height * 0.4,
              child: CircularProgressIndicator(
                backgroundColor: Colors.grey[400],
                value: progrss,
                color: style.yellow,
                strokeWidth: 5,
              ),
            ),
            GestureDetector(
              onTap: (() {
                if (controller.isDismissed || play == false) {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => SizedBox(
                      height: size.height * 0.3,
                      child: CupertinoTimerPicker(
                        initialTimerDuration: controller.duration!,
                        onTimerDurationChanged: (value) {
                          setState(() {
                            controller.duration = value;
                          });
                        },
                      ),
                    ),
                  );
                }
              }),
              child: AnimatedBuilder(
                animation: controller,
                builder: (context, child) => Text(
                  count,
                  style: style.textStyleBlack,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            timerbutton(const Duration(minutes: 30)),
            timerbutton(const Duration(minutes: 15)),
            timerbutton(const Duration(minutes: 5)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              onPressed: () {
                if (controller.isAnimating) {
                  controller.stop();
                  setState(() {
                    play = false;
                  });
                } else {
                  controller.reverse(
                      from: controller.value == 0 ? 1.0 : controller.value);
                  setState(() {
                    play = true;
                  });
                }
              },
              child:
                  Icon(play == false ? Icons.play_arrow_outlined : Icons.pause),
            ),
            const SizedBox(
              width: 20,
            ),
            ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all(style.yellow),
              ),
              onPressed: () {
                controller.reset();
                setState(() {
                  play = false;
                });
              },
              child: const Icon(Icons.restore_outlined),
            ),
          ],
        ),
      ],
    );
  }

  Widget timerbutton(Duration text) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            controller.duration = text;
          });
        },
        child: Text(
          '${text.inMinutes} min',
        ),
      ),
    );
  }
}
