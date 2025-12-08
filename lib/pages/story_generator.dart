import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class StoryGeneratorPage extends StatefulWidget {
  const StoryGeneratorPage({super.key});

  @override
  State<StoryGeneratorPage> createState() => _StoryGeneratorPageState();
}

class _StoryGeneratorPageState extends State<StoryGeneratorPage> {
  @override
  Widget build(BuildContext context) {
    double aspectRatio = MediaQuery.of(context).size.aspectRatio;
    return Center();
  }
}
