import 'dart:async';

import 'package:calm_aura/Common/color.dart';
import 'package:flutter/material.dart';

class BreathingEXPage extends StatefulWidget {
  const BreathingEXPage({super.key});

  @override
  State<BreathingEXPage> createState() => _BreathingEXPageState();
}

class _BreathingEXPageState extends State<BreathingEXPage>
    with SingleTickerProviderStateMixin {
  late Timer _timer;
  int _secondsRemaining = 6;
  bool _isBreathingIn = true;
  late AnimationController _animationController;
  late Animation<double> _animation;
  int _cyclesCompleted = 0;
  final int _totalCycles = 15;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animation = Tween<double>(begin: 0.8, end: 1.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  void _startBreathing() {
    if (_isRunning) {
      _timer.cancel();
      _animationController.stop();
      setState(() {
        _isRunning = false;
      });
    } else {
      setState(() {
        _isBreathingIn = true;
        _secondsRemaining = 6;
        _cyclesCompleted = 0;
        _isRunning = true;
      });

      _animationController.repeat(reverse: true);

      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _secondsRemaining--;
        });

        if (_secondsRemaining == 0) {
          if (_isBreathingIn) {
            setState(() {
              _isBreathingIn = false;
              _secondsRemaining = 10;
            });
          } else if (!_isBreathingIn && _secondsRemaining == 0) {
            // Switch to exhaling
            setState(() {
              _isBreathingIn = true;
              _secondsRemaining = 8;
              _cyclesCompleted++;
            });
          }

          if (_cyclesCompleted >= _totalCycles) {
            _timer.cancel();
            _animationController.stop();
            setState(() {
              _isRunning = false;
            });
          }
        }
      });
    }
  }

  double get _progress =>
      _isBreathingIn || (!_isBreathingIn && _secondsRemaining > 0)
          ? _secondsRemaining /
              (_isBreathingIn ? 6 : (_secondsRemaining == 10 ? 10 : 8))
          : 0;

  Color get _progressColor => _isBreathingIn
      ? Colors.green
      : _secondsRemaining == 10
          ? Colors.yellow
          : Colors.red;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: const Text(
          'Meditation',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Coloors.purple,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 16.0),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/yoga.png',
                    height: 280,
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Breathing',
                    style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                      color: Coloors.purple,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Take a deep breath, \n let worries fade, and feel the calm wash over you like a gentle wave.",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16.0),
                  AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Container(
                        width: 300,
                        height: 250,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CircularProgressIndicator(
                              value: _progress,
                              strokeWidth: 12,
                              backgroundColor: Coloors.blue,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(_progressColor),
                            ),
                            ScaleTransition(
                              scale: _animation,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _progressColor.withOpacity(0.2),
                                ),
                                width: 200,
                                height: 200,
                              ),
                            ),
                            Text(
                              '${_secondsRemaining}s',
                              style: const TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                                color: Coloors.purple,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Breathing Rounds: $_cyclesCompleted/$_totalCycles',
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Coloors.purple,
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                color: Coloors.blue,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _isBreathingIn
                        ? 'Inhale'
                        : (_secondsRemaining == 10 ? 'Hold' : 'Exhale'),
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '00:00:${_secondsRemaining.toString().padLeft(2, '0')}',
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _startBreathing,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Coloors.blue,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      _isRunning ? 'Stop' : 'Start Now',
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
