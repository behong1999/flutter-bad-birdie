import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';

class RenameMarkerDialog extends StatefulWidget {
  const RenameMarkerDialog({required this.initialLabel, super.key});

  final String initialLabel;

  @override
  State<RenameMarkerDialog> createState() => _RenameMarkerDialogState();
}

class _RenameMarkerDialogState extends State<RenameMarkerDialog> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.initialLabel,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() => Navigator.of(context).pop(_controller.text.trim());

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Text(l10n.renamePlayerTitle),
      content: TextField(
        controller: _controller,
        autofocus: true,
        maxLength: 3,
        textCapitalization: TextCapitalization.characters,
        onSubmitted: (_) => _submit(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.cancel),
        ),
        TextButton(onPressed: _submit, child: const Text('OK')),
      ],
    );
  }
}
