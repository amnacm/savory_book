import 'package:flutter/material.dart';
import 'package:fluttericon/linecons_icons.dart';

class CodedItemScreen extends StatefulWidget {
  final Map<String, String> food;
  const CodedItemScreen({super.key, required this.food});

  @override
  State<CodedItemScreen> createState() => _CodedItemScreenState();
}

class _CodedItemScreenState extends State<CodedItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isLargeScreen = constraints.maxWidth > 600;
          if (isLargeScreen) {
            //----------------Large
            return Row(
              children: [
                Expanded(
                  flex: 1,
                  child: SizedBox(height: double.infinity, child: imageStack()),
                ),
                //----------Details
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: contentItems(context),
                  ),
                ),
              ],
            );
          } else {
            // -----------Small
            return ListView(
              padding: EdgeInsets.zero,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 390,
                  child: imageStack(),
                ),
                const SizedBox(height: 15),
                contentItems(context)
              ],
            );
          }
        },
      ),
    );
  }

  Padding contentItems(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            widget.food["name"] ?? "No Name",
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Category : ${widget.food["category"]}',
            style: const TextStyle(fontSize: 17),
          ),
          Text(
            'Cook Time : ${widget.food["cookTime"]}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 25),
          const Text(
            'Ingredients',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w500,
              height: 1,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            widget.food["ingredients"] ?? "Nothing",
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 40),
          const Text(
            'How to Prepare?',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w500,
              height: 1,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            widget.food["preparation"] ?? "Nothing",
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Stack imageStack() {
    return Stack(
      fit: StackFit.expand,
      children: [
        if (widget.food["image"] != null)
          Image.asset(
            widget.food["image"]!,
            fit: BoxFit.cover,
          ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(0.8),
                widget.food["image"] != null
                    ? Colors.transparent
                    : const Color.fromARGB(119, 30, 30, 30),
              ],
              begin: Alignment.topCenter,
              end: Alignment.center,
            ),
          ),
          child: widget.food["image"] == null
              ? const Icon(
                  Linecons.food,
                  size: 130,
                  color: Colors.white,
                )
              : null,
        ),
        Positioned(
            top: 40,
            left: 10,
            child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                  size: 30,
                ))),
      ],
    );
  }
}
