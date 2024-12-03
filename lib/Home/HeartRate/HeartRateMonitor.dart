import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:calm_aura/Common/color.dart';
import 'package:calm_aura/Meditation/BreathingPage.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';

class HeartRateMonitor extends StatefulWidget {
  @override
  _HeartRateMonitorState createState() => _HeartRateMonitorState();
}

class _HeartRateMonitorState extends State<HeartRateMonitor>
    with SingleTickerProviderStateMixin {
  int heartRate = 0;
  final int elevatedAnxietyThreshold = 110;
  final int criticalThreshold = 120;
  late AnimationController _controller;
  late Animation<double> _breathAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _breathAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.repeat(reverse: true);

    simulateHeartRateChanges();
  }

  void simulateHeartRateChanges() {
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        heartRate = Random().nextInt(140);
      });
      checkHeartRate();
      simulateHeartRateChanges();
    });
  }

  void checkHeartRate() {
    if (heartRate <= 40) {
      triggerEmergencyAlert();
      return;
    }

    if (heartRate >= criticalThreshold) {
      triggerEmergencyAlert();
    } else if (heartRate >= elevatedAnxietyThreshold &&
        heartRate < criticalThreshold) {
      showPopup(
        "Your heart rate is elevated! Try calming down with some breathing exercises.",
        () => navigateToBreathingPage(),
      );
    }
  }

  void showPopup(String message, VoidCallback onOkPressed) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Heart Rate Alert"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onOkPressed();
              },
              child: const Text("OK"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  Future<String> getEmergencyContact() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('emergency_contact')
          .doc('vkyZ84FexSN6Zp4EtYkI')
          .get();

      if (snapshot.exists) {
        return snapshot['phone_number'];
      } else {
        throw 'Emergency contact not found';
      }
    } catch (e) {
      throw 'Error retrieving emergency contact: $e';
    }
  }

  Future<void> triggerEmergencyAlert() async {
    String emergencyContactNumber = await getEmergencyContact();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Emergency!"),
          content: const Text(
              "Your heart rate indicates a critical state! Calling your emergency contact."),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _makeEmergencyCall(emergencyContactNumber);
              },
              child: const Text("Call Now"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _makeEmergencyCall(String contact) async {
    String emergencyContact = "tel:$contact";
    if (await canLaunch(emergencyContact)) {
      await launch(emergencyContact);
    } else {
      throw 'Could not launch $emergencyContact';
    }
  }

  Future<void> navigateToBreathingPage() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const BreathingEXPage()),
    );
  }

  Future<void> saveHeartRateToFirestore() async {
    try {
      FirebaseFirestore.instance.collection('heart_rate_data').add({
        'heart_rate': heartRate,
        'timestamp': FieldValue.serverTimestamp(),
        'status': getStatus(),
        'alert_triggered': heartRate >= criticalThreshold || heartRate <= 40,
      });
    } catch (e) {
      print("Error saving heart rate data to Firestore: $e");
    }
  }

  String getStatus() {
    if (heartRate <= 40) {
      return "Critical Condition";
    } else if (heartRate >= criticalThreshold) {
      return "Emergency";
    } else if (heartRate >= elevatedAnxietyThreshold) {
      return "Elevated Anxiety";
    } else {
      return "Normal";
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double severityLevel = min(1.0, heartRate / criticalThreshold);
    Color ringColor = (heartRate >= criticalThreshold)
        ? Colors.red
        : (heartRate >= elevatedAnxietyThreshold)
            ? Colors.orange
            : Colors.green;

    Color criticalTextColor =
        heartRate == 0 || heartRate <= 40 ? Colors.red : ringColor;

    saveHeartRateToFirestore();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: const Text(
          'My Heart Rate',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Coloors.purple,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularPercentIndicator(
              radius: 120.0 * _breathAnimation.value,
              lineWidth: 15.0,
              percent: severityLevel,
              center: Text(
                "$heartRate bpm",
                style:
                    const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              progressColor: ringColor,
              circularStrokeCap: CircularStrokeCap.round,
            ),
            const SizedBox(height: 20),
            Text(
              heartRate == 0 || heartRate <= 40
                  ? "Critical Condition!"
                  : heartRate >= criticalThreshold
                      ? "Emergency"
                      : heartRate >= elevatedAnxietyThreshold
                          ? "Elevated Anxiety"
                          : "Normal",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: criticalTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
