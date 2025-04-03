import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_screen.dart';
import 'screens/video_upload_screen.dart';
import 'screens/video_edit_screen.dart';
import 'screens/gif_converter_screen.dart';
import 'screens/sticker_pack_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WhatsApp Media Editor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        textTheme: GoogleFonts.poppinsTextTheme(),
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.light,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/videoUpload': (context) => const VideoUploadScreen(),
        '/videoEdit': (context) => const VideoEditScreen(),
        '/gifConverter': (context) => const GifConverterScreen(),
        '/stickerPack': (context) => const StickerPackScreen(),
      },
    );
  }
}