import 'package:flutter/material.dart';
import '../widgets/custom_appbar.dart';

class GifConverterScreen extends StatefulWidget {
  const GifConverterScreen({super.key});

  @override
  State<GifConverterScreen> createState() => _GifConverterScreenState();
}

class _GifConverterScreenState extends State<GifConverterScreen> {
  bool _isConverting = false;
  bool _isCompleted = false;
  double _quality = 0.8;
  int _fps = 15;
  String? _errorMessage;

  Future<void> _convertToGif() async {
    setState(() {
      _isConverting = true;
      _errorMessage = null;
    });

    try {
      // Simulating GIF conversion process
      await Future.delayed(const Duration(seconds: 2));
      
      setState(() {
        _isConverting = false;
        _isCompleted = true;
      });
    } catch (e) {
      setState(() {
        _isConverting = false;
        _errorMessage = 'Error converting to GIF: $e';
      });
    }
  }

  Future<void> _shareGif() async {
    // Implementation for sharing GIF via WhatsApp would go here
    // Using share_plus package in actual implementation
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Convert to GIF'),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.1),
              Theme.of(context).colorScheme.surface,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'GIF Settings',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Quality',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Slider(
                        value: _quality,
                        onChanged: (value) {
                          setState(() {
                            _quality = value;
                          });
                        },
                        label: '${(_quality * 100).round()}%',
                        divisions: 10,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Frame Rate (FPS)',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Slider(
                        value: _fps.toDouble(),
                        min: 5,
                        max: 30,
                        onChanged: (value) {
                          setState(() {
                            _fps = value.round();
                          });
                        },
                        label: '$_fps FPS',
                        divisions: 25,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    _errorMessage!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              if (_isConverting)
                Column(
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 16),
                    Text(
                      'Converting video to GIF...',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                )
              else if (_isCompleted)
                Column(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Theme.of(context).colorScheme.primary,
                      size: 64,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'GIF Created Successfully!',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: _shareGif,
                      icon: const Icon(Icons.share),
                      label: const Text('Share via WhatsApp'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                      ),
                    ),
                  ],
                )
              else
                ElevatedButton.icon(
                  onPressed: _convertToGif,
                  icon: const Icon(Icons.gif),
                  label: const Text('Convert to GIF'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}