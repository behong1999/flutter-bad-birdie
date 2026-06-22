import 'package:flutter/material.dart';
import '../../../../core/extensions/l10n_extension.dart';

class SavePresetDialog extends StatefulWidget {
  const SavePresetDialog({
    required this.suggestedName,
    required this.existingNames,
    super.key,
  });

  final String suggestedName;
  final List<String> existingNames;

  @override
  State<SavePresetDialog> createState() => _SavePresetDialogState();
}

class _SavePresetDialogState extends State<SavePresetDialog> {
  late final TextEditingController _controller;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.suggestedName)
      ..selection = TextSelection(
        baseOffset: 0,
        extentOffset: widget.suggestedName.length,
      );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final name = _controller.text.trim();
    if (name.isEmpty) return;
    final exists = widget.existingNames.any(
      (n) => n.toLowerCase() == name.toLowerCase(),
    );
    if (exists) {
      setState(() => _errorText = context.l10n.presetNameExists);
      return;
    }
    Navigator.of(context).pop(name);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.l10n.savePreset),
      content: TextField(
        controller: _controller,
        autofocus: true,
        decoration: InputDecoration(
          labelText: context.l10n.presetNameLabel,
          errorText: _errorText,
        ),
        onChanged: (_) {
          if (_errorText != null) setState(() => _errorText = null);
        },
        onSubmitted: (_) => _submit(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(context.l10n.cancel),
        ),
        FilledButton(onPressed: _submit, child: Text(context.l10n.save)),
      ],
    );
  }
}
