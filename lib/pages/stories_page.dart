import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myitihas/utils/constants.dart';

class StoriesPage extends StatefulWidget {
  const StoriesPage({super.key});

  @override
  State<StoriesPage> createState() => _StoriesPageState();
}

class _StoriesPageState extends State<StoriesPage> {
  @override
  Widget build(BuildContext context) {
    double aspectRatio = MediaQuery.of(context).size.aspectRatio;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 5,
              child: TextFormField(
                autofocus: false,
                decoration: InputDecoration(
                  hintText: "Search by title or author...",
                  prefixIcon: Icon(
                    Icons.search,
                    color: Theme.of(context).primaryColor,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: aspectRatio > 0.5 ? 14 : 10,
                    horizontal: aspectRatio > 0.5 ? 20 : 16,
                  ),
                  filled: true,
                  fillColor: Theme.of(context).canvasColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: aspectRatio > 0.5 ? 16 : 10),
            Expanded(
              flex: 1,
              child: PopupMenuButton<String>(
                onSelected: (value) {
                  // handle sort change here
                },
                splashRadius: 0,
                itemBuilder:
                    (context) => [
                      PopupMenuItem(
                        value: "newest",
                        child: Text("Newest First"),
                      ),
                      PopupMenuItem(
                        value: "oldest",
                        child: Text("Oldest First"),
                      ),
                      PopupMenuItem(
                        value: "popular",
                        child: Text("Most Popular"),
                      ),
                    ],
                offset: const Offset(0, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Theme.of(context).cardColor,
                child: Container(
                  width: aspectRatio > 0.5 ? 50 : 45,
                  height: aspectRatio > 0.5 ? 50 : 45,
                  decoration: BoxDecoration(
                    gradient:
                        Theme.of(context).brightness == Brightness.dark
                            ? DarkColors.messageUserGradient
                            : LightColors.messageUserGradient,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.sort_rounded,
                    color: Colors.white,
                    size: aspectRatio > 0.5 ? 28 : 24,
                    weight: 700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
