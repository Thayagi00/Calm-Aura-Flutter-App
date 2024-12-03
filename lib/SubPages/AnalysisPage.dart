import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:calm_aura/Common/color.dart';
import 'package:flutter/material.dart';

class AnalysisPage extends StatefulWidget {
  const AnalysisPage({super.key});

  @override
  _AnalysisPageState createState() => _AnalysisPageState();
}

class _AnalysisPageState extends State<AnalysisPage> {
  List<double> moodData = [];
  List<double> heartRateData = [];
  int panicAttacks = 0;
  String statusMessage = '';
  List<String> tips = [];

  double averageMood = 0;
  double averageHeartRate = 0;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final moodSnapshot =
          await FirebaseFirestore.instance.collection('mood_data').get();
      List<double> fetchedMoodData = [];
      for (var doc in moodSnapshot.docs) {
        fetchedMoodData.add(doc['mood_level'].toDouble());
      }

      final heartRateSnapshot =
          await FirebaseFirestore.instance.collection('heart_rate_data').get();
      List<double> fetchedHeartRateData = [];
      for (var doc in heartRateSnapshot.docs) {
        var rate = doc['rate'];
        if (rate != null) {
          fetchedHeartRateData.add(rate.toDouble());
        }
      }

      // Fetching panic data
      final panicSnapshot = await FirebaseFirestore.instance
          .collection('panic_data')
          .doc('weekly_summary')
          .get();
      panicAttacks = panicSnapshot['count'];
      statusMessage = panicSnapshot['status_message'];

      final tipsSnapshot =
          await FirebaseFirestore.instance.collection('improvement_tips').get();
      List<String> fetchedTips = [];
      for (var doc in tipsSnapshot.docs) {
        fetchedTips.add(doc['tip']);
      }

      setState(() {
        moodData = fetchedMoodData;
        heartRateData = fetchedHeartRateData;
        tips = fetchedTips;

        if (moodData.isNotEmpty) {
          averageMood = moodData.reduce((a, b) => a + b) / moodData.length;
        }

        if (heartRateData.isNotEmpty) {
          averageHeartRate =
              heartRateData.reduce((a, b) => a + b) / heartRateData.length;
        }
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: const Text(
          'Your Well-Being Analysis',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: Coloors.purple,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 30),
                Image.asset(
                  'assets/images/analysis.jpg',
                  height: 250,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 20),

                const Text(
                  'Mood Analysis Over the Past Week',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                moodData.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : Text(
                        'Average Mood Level: ${averageMood.toStringAsFixed(2)}\n'
                        'Based on your mood data, you are generally in a good state of mind. Keep practicing mindfulness techniques to maintain this positive trend.',
                        style: const TextStyle(fontSize: 16),
                      ),
                const SizedBox(height: 20),

                // Heart Rate Analysis
                const Text(
                  'Heart Rate Analysis Over the Past Week',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                heartRateData.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : Text(
                        'Average Heart Rate: ${averageHeartRate.toStringAsFixed(2)} bpm\n'
                        'Your heart rate is within a normal range. Keep up with your meditation and relaxation techniques to help regulate your heart rate.',
                        style: const TextStyle(fontSize: 16),
                      ),
                const SizedBox(height: 20),

                const Text(
                  'Panic Attack Analysis Over the Past Week',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                panicAttacks == 0
                    ? const Text(
                        'No panic attacks reported over the past week. Keep up with your relaxation techniques!',
                        style: TextStyle(fontSize: 16),
                      )
                    : Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.red.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.warning_amber_rounded,
                                color: Colors.red.shade800,
                                size: 30,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'You had a total of $panicAttacks panic attacks over the past week. $statusMessage',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                const SizedBox(height: 20),

                // Overall Status
                const Text(
                  'Overall Status',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Your overall well-being is improving. Keep up with your meditation and relaxation techniques!',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
