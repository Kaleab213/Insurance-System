import 'package:flutter/material.dart';
import 'dart:typed_data';

class PremiumDetailPage extends StatefulWidget {
  final String name;
  final String premiumStatus;
  final String insuranceId;
  final String insuranceLevel;
  final double premiumAmount;
  final String imageUrl;

  const PremiumDetailPage({
    required this.name,
    required this.premiumStatus,
    required this.insuranceId,
    required this.insuranceLevel,
    required this.premiumAmount,
    required this.imageUrl,
  });

  @override
  _PremiumDetailPageState createState() => _PremiumDetailPageState();
}

class _PremiumDetailPageState extends State<PremiumDetailPage> {
  late bool _isPremiumApproved;

  void _approvePremium() {
    setState(() {
      _isPremiumApproved = true;
    });
    // TODO: Update premium status in the database
  }

  void _declinePremium() {
    setState(() {
      _isPremiumApproved = false;
    });
    // TODO: Update premium status in the database
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Premium Detail'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            Text(
              'Name: ${widget.name}',
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Premium Status: ${widget.premiumStatus}',
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Insurance ID: ${widget.insuranceId}',
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Insurance Level: ${widget.insuranceLevel}',
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Premium Amount: ${widget.premiumAmount}',
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FutureBuilder(
              future: fetchImage(widget.imageUrl),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return Image.memory(
                    snapshot.data!,
                    height: 200,
                    fit: BoxFit.cover,
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  // onPressed: _isPremiumApproved ? null : _approvePremium,
                  onPressed: () {},
                  child: const Text('Approve Premium'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {},
                  // onPressed: _isPremiumApproved ? _declinePremium : null,
                  child: const Text('Decline Premium'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<Uint8List?> fetchImage(String imageUrl) async {
    // TODO: Fetch image from the database
    // For example:
    // var response = await http.get(Uri.parse(imageUrl));
    // return response.bodyBytes;
    return null;
  }
}
