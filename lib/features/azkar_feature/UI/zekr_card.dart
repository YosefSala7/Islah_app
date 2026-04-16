import 'package:flutter/material.dart';
class ZekrCard extends StatefulWidget {
  final String text;
  final String reference;
  final int count;

  const ZekrCard({
    super.key,
    required this.text,
    required this.reference,
    required this.count,
  });

  @override
  State<ZekrCard> createState() => _ZekrCardState();
}

class _ZekrCardState extends State<ZekrCard> {
  int currentCount = 0;
  bool isFinished = false; 

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: isFinished ? 0.0 : 1.0,
      child: AnimatedSize(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        child: isFinished
            ? const SizedBox(width: double.infinity, height: 0)
            : GestureDetector(
                onTap: () {
                  if (currentCount < widget.count) {
                    setState(() {
                      currentCount++;
                    });

                    if (currentCount == widget.count) {
                      Future.delayed(const Duration(milliseconds: 300), () {
                        setState(() {
                          isFinished = true;
                        });
                      });
                    }
                  }
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(10),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        widget.text,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontSize: 20,
                          height: 1.6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Divider(color: theme.dividerColor.withAlpha(26), thickness: 1),
                      const SizedBox(height: 10),
                      Text(
                        widget.reference,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                          decoration: BoxDecoration(
                            color: theme.scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "$currentCount / ${widget.count}",
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              fontFamily: "monospace",
                            ),
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
