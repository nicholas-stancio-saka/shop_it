import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shop_it/features/shared/widgets/button.dart';

typedef OnSubmit = void Function(String text);

class AppSimpleDialog extends StatelessWidget {
  final String? title;
  final String? text;
  final void Function()? onPressed;

  const AppSimpleDialog({
    this.title,
    this.text,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (onPressed != null) {
          onPressed!();
        }
        return Future.value(true);
      },
      child: AlertDialog(
        backgroundColor: Colors.white,
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title ?? '',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Container(
                height: 10,
              ),
              Text(
                text ?? '',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 100,
                child: AppButton(
                  child: const Text('Close'),
                  onTap: () {
                    Navigator.of(context).pop();

                    if (onPressed != null) {
                      onPressed!();
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ----- Stateful -----
class AppTextInputDialog extends StatefulWidget {
  final String? title;
  final Completer<String> completer; // Use a completer to return the result

  const AppTextInputDialog({
    this.title,
    required this.completer,
    super.key,
  });

  @override
  State<AppTextInputDialog> createState() => _AppTextInputDialogState();
}

class _AppTextInputDialogState extends State<AppTextInputDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: widget.title != null ? Text(widget.title!) : null,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(hintText: 'Enter some text'),
            autofocus: true,
            onChanged: (value) {
              setState(() {}); // Call setState to enable/disable the button
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _controller.text.isNotEmpty
                ? () {
                    widget.completer.complete(_controller.text); // Complete with the text
                    Navigator.of(context).pop();
                  }
                : null,
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
