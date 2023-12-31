import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// [Title] is required to show the [AppBar].
/// If there is no title, use empty string instead of null to show the [AppBar]
///
class AppPage extends StatelessWidget {
  final Widget body;
  final String? title;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final ImageProvider? backgroundImage;
  final Widget? backgroundWidget;
  final Future<bool> Function()? onWillPop;

  const AppPage({
    required this.body,
    this.title,
    this.actions,
    this.backgroundColor,
    this.backgroundImage,
    this.backgroundWidget,
    this.onWillPop,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: WillPopScope(
        onWillPop: onWillPop ?? () => Future.value(true),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: backgroundColor,
          appBar: title == null
              ? null
              : AppBar(
                  leading: Container(),
                  leadingWidth: 0,
                  title: Stack(
                    children: [
                      Center(child: Text(title ?? '')),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => Get.back(),
                            child: const Icon(Icons.arrow_back_ios_new),
                          ),
                          const Spacer(),
                          ...?actions,
                        ],
                      ),
                    ],
                  ),
                ),
          body: Stack(
            children: [
              if (backgroundImage != null)
                Positioned.fill(
                  child: Image(
                    image: backgroundImage!,
                    fit: BoxFit.cover,
                  ),
                ),
              if (backgroundWidget != null) Positioned.fill(child: backgroundWidget!),
              SafeArea(child: body),
            ],
          ),
        ),
      ),
    );
  }
}

class DarkGradientOverlay extends StatelessWidget {
  const DarkGradientOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromRGBO(7, 26, 49, 0.76),
            Color.fromRGBO(1, 9, 18, 0.8),
          ],
        ),
      ),
    );
  }
}

class LightGradientOverlay extends StatelessWidget {
  const LightGradientOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromRGBO(7, 26, 49, 0.665),
            Color.fromRGBO(1, 9, 18, 0.7),
          ],
        ),
      ),
    );
  }
}
