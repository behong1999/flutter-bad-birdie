import 'package:flutter/material.dart';

extension NavigatorX on BuildContext {
  Future<T?> push<T>(Widget screen) =>
      Navigator.of(this).push(MaterialPageRoute<T>(builder: (_) => screen));
}
