import 'package:calm_aura/Common/color.dart';
import 'package:calm_aura/Home/HeartRate/HeartRateMonitor.dart';
import 'package:calm_aura/Home/Meditation/MeditationHome.dart';
import 'package:calm_aura/Meditation/BreathingPage.dart';
import 'package:calm_aura/SubPages/AnalysisPage.dart';

import 'package:calm_aura/SubPages/ConatctsDeatils.dart';
import 'package:calm_aura/SubPages/MoodTracker.dart';
import 'package:calm_aura/SubPages/MotivationPage.dart';
import 'package:calm_aura/SubPages/Music/MusicHome.dart';
import 'package:calm_aura/SubPages/Profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  void _launchPhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Could not launch $phoneUri';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: const Text(
          'Calm Aura',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Coloors.purple,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 18),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: "Welcome to CALM AURA ✨, ",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Coloors.blue,
                      ),
                    ),
                    TextSpan(
                      text:
                          "\n where your peace shines like the stars. Enjoy your experience!",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _SmallBox(
                    icon: Icons.music_note,
                    label: 'Music',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MusicHome()),
                      );
                    },
                  ),
                  _SmallBox(
                    icon: Icons.accessibility,
                    label: 'Meditation',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BreathingEXPage()),
                      );
                    },
                  ),
                  _SmallBox(
                    icon: Icons.person,
                    label: 'Profile',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfilePage(),
                        ),
                      );
                    },
                  ),
                  _SmallBox(
                    icon: Icons.call,
                    label: 'Emergency',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ConatctsPage(),
                        ),
                      );
                    },
                  ),
                  /* _SmallBox(
                    icon: Icons.trending_up,
                    label: 'Analysis',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AnalysisPage(),
                        ),
                      );
                    },
                  ),*/
                ],
              ),
              const SizedBox(height: 16.0),
              _WellnessCard(
                title: 'Meditation',
                description: 'Techniques, benefits, and beginners guide',
                icon: Icons.spa,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MeditationHomePage()),
                  );
                },
              ),
              const SizedBox(height: 16.0),
              _WellnessCard(
                title: 'Heart Rate',
                description: 'Heart-healthy breathing techniques',
                icon: CupertinoIcons.heart_solid,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HeartRateMonitor()),
                  );
                },
              ),
              const SizedBox(height: 16.0),
              _WellnessCard(
                title: 'Daily Dose of Motivation',
                description: 'Inspiring quotes to ignite ambition',
                icon: Icons.all_inclusive,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MotivationPage()),
                  );
                },
              ),
              const SizedBox(height: 16.0),
              _WellnessCard(
                title: "How's your day today?",
                description: 'Wishing you a joyful day!',
                icon: Icons.mood,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MoodTrackerPage()),
                  );
                },
              ),
              const SizedBox(height: 16.0),
              _WellnessCard(
                title: "Analytics",
                description: 'View your progress and trends',
                icon: Icons.trending_up,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AnalysisPage()),
                  );
                },
              ),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    const TextSpan(
                        text: 'The National Mental Health Hotline: '),
                    TextSpan(
                      text: '1926',
                      style: const TextStyle(color: Coloors.blue, fontSize: 19),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => _launchPhoneCall('1926'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    const TextSpan(text: 'Alokaya Counselling Unit: '),
                    TextSpan(
                      text: '0779895252',
                      style: const TextStyle(color: Coloors.blue, fontSize: 19),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => _launchPhoneCall('0779895252'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _WellnessCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onTap;

  _WellnessCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Coloors.purple.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: Coloors.blue,
              size: 32.0,
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
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

class _SmallBox extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  _SmallBox({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Coloors.purple.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: Coloors.blue,
              size: 40.0,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            label,
            style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
