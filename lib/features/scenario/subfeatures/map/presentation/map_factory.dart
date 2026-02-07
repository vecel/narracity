import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class MapFactory {

  static Widget Function(MapOptions options, List<Widget> children)? _builder;

  static void setMockBuilder(Widget Function(MapOptions options, List<Widget> children) builder) {
    _builder = builder;
  }

  static void clearMockBuilder() {
    _builder = null;
  }

  static Widget build({
    Key? key,
    required MapOptions options,
    required List<Widget> children
  }) {

    if (_builder != null) {
      return _builder!(options, children);
    }

    return FlutterMap(
      key: key,
      options: options,
      children: children
    );
  }
}