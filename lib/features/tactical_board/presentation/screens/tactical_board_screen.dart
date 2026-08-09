import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/models/board_element.dart';
import '../../domain/models/draw_tool.dart';
import '../painters/board_painter.dart';
import '../painters/court_painter.dart';
import '../widgets/board_toolbar.dart';
import '../widgets/rename_marker_dialog.dart';
import '../widgets/tactical_board_help_dialog.dart';

class TacticalBoardScreen extends StatefulWidget {
  const TacticalBoardScreen({super.key});

  @override
  State<TacticalBoardScreen> createState() => _TacticalBoardScreenState();
}

class _TacticalBoardScreenState extends State<TacticalBoardScreen> {
  static const _markerHitRadius = 24.0;
  static const _strokeWidth = 3.5;
  static const _markerRenameHoldDuration = Duration(milliseconds: 600);

  // Regulation court is 6.1 m × 13.4 m; scale width slightly for phone screens.
  static const _courtWidthM = 6.1;
  static const _courtLengthM = 13.4;
  static const _courtDisplayWidthScale = 1.12;
  static const _courtAspectRatio =
      (_courtWidthM * _courtDisplayWidthScale) / _courtLengthM;

  static const _markerColors = [Color(0xFF2196F3), Color(0xFFF44336)];

  static const _strokeColors = [
    Colors.white,
    Color(0xFFF44336),
    Color(0xFF2196F3),
    Color(0xFFFFEB3B),
    Color(0xFFAC51B4),
  ];

  static List<PlayerMarker> get _defaultMarkers => [
    PlayerMarker(
      id: 'marker_t1_1',
      label: '1',
      position: const Offset(0.88, 0.17),
      color: _markerColors[0],
    ),
    PlayerMarker(
      id: 'marker_t1_2',
      label: '2',
      position: const Offset(0.88, 0.33),
      color: _markerColors[0],
    ),
    PlayerMarker(
      id: 'marker_t2_1',
      label: '1',
      position: const Offset(0.88, 0.62),
      color: _markerColors[1],
    ),
    PlayerMarker(
      id: 'marker_t2_2',
      label: '2',
      position: const Offset(0.88, 0.78),
      color: _markerColors[1],
    ),
  ];

  late var _elements = <BoardElement>[..._defaultMarkers];
  final _history = <List<BoardElement>>[];

  FreehandStroke? _currentStroke;
  Offset? _arrowStart;
  Offset? _arrowCurrent;
  String? _draggingMarkerId;
  Offset? _lastDragNorm;

  var _tool = DrawTool.pencil;
  Color _color = _strokeColors.first;
  var _courtSize = Size.zero;

  List<PlayerMarker> get _markers =>
      _elements.whereType<PlayerMarker>().toList();

  // ── history ───────────────────────────────────────────────────────────────

  void _saveHistory() => _history.add(List.of(_elements));

  void _undo() {
    if (_currentStroke != null || _arrowStart != null) {
      setState(() {
        _currentStroke = null;
        _arrowStart = null;
        _arrowCurrent = null;
      });
      return;
    }
    if (_history.isEmpty) return;
    setState(() => _elements = _history.removeLast());
  }

  void _clearBoard() {
    final hasDrawings = _elements.any((e) => e is! PlayerMarker);
    if (!hasDrawings) return;
    _saveHistory();
    setState(() {
      _elements = _elements.whereType<PlayerMarker>().toList();
      _currentStroke = null;
      _arrowStart = null;
      _arrowCurrent = null;
    });
  }

  // ── coordinate helpers ────────────────────────────────────────────────────

  Offset _normalize(Offset local) => Offset(
    (local.dx / _courtSize.width).clamp(0.0, 1.0),
    (local.dy / _courtSize.height).clamp(0.0, 1.0),
  );

  PlayerMarker? _markerAt(Offset localPos) {
    for (final marker in _markers.reversed) {
      final center = Offset(
        marker.position.dx * _courtSize.width,
        marker.position.dy * _courtSize.height,
      );
      if ((center - localPos).distance <= _markerHitRadius) return marker;
    }
    return null;
  }

  // ── gestures ──────────────────────────────────────────────────────────────

  void _onPanStart(DragStartDetails d) {
    final local = d.localPosition;
    final norm = _normalize(local);

    final hit = _markerAt(local);
    if (hit != null) {
      _saveHistory();
      setState(() {
        _draggingMarkerId = hit.id;
        _lastDragNorm = norm;
      });
      return;
    }

    _draggingMarkerId = null;
    switch (_tool) {
      case DrawTool.pencil:
        setState(
          () => _currentStroke = FreehandStroke(
            points: [norm],
            color: _color,
            strokeWidth: _strokeWidth,
          ),
        );
      case DrawTool.arrow:
        setState(() {
          _arrowStart = norm;
          _arrowCurrent = norm;
        });
    }
  }

  void _onPanUpdate(DragUpdateDetails d) {
    final norm = _normalize(d.localPosition);

    if (_draggingMarkerId != null) {
      final delta = norm - (_lastDragNorm ?? norm);
      setState(() {
        _lastDragNorm = norm;
        _elements = _elements.map((e) {
          if (e is PlayerMarker && e.id == _draggingMarkerId) {
            return e.copyWith(
              position: Offset(
                (e.position.dx + delta.dx).clamp(0.0, 1.0),
                (e.position.dy + delta.dy).clamp(0.0, 1.0),
              ),
            );
          }
          return e;
        }).toList();
      });
      return;
    }

    switch (_tool) {
      case DrawTool.pencil:
        if (_currentStroke == null) return;
        setState(
          () => _currentStroke = _currentStroke!.withPoints([
            ..._currentStroke!.points,
            norm,
          ]),
        );
      case DrawTool.arrow:
        if (_arrowStart != null) setState(() => _arrowCurrent = norm);
    }
  }

  void _onPanEnd(DragEndDetails _) {
    if (_draggingMarkerId != null) {
      setState(() {
        _draggingMarkerId = null;
        _lastDragNorm = null;
      });
      return;
    }

    switch (_tool) {
      case DrawTool.pencil:
        final stroke = _currentStroke;
        if (stroke == null || stroke.points.length < 2) {
          setState(() => _currentStroke = null);
          return;
        }
        _saveHistory();
        setState(() {
          _elements = [..._elements, stroke];
          _currentStroke = null;
        });
      case DrawTool.arrow:
        final start = _arrowStart;
        final end = _arrowCurrent;
        if (start != null && end != null) {
          final dist =
              (Offset(
                        start.dx * _courtSize.width,
                        start.dy * _courtSize.height,
                      ) -
                      Offset(
                        end.dx * _courtSize.width,
                        end.dy * _courtSize.height,
                      ))
                  .distance;
          if (dist > 8) {
            _saveHistory();
            setState(() {
              _elements = [
                ..._elements,
                ArrowElement(
                  start: start,
                  end: end,
                  color: _color,
                  strokeWidth: _strokeWidth,
                ),
              ];
            });
          }
        }
        setState(() {
          _arrowStart = null;
          _arrowCurrent = null;
        });
    }
  }

  Future<void> _onLongPressStart(LongPressStartDetails d) async {
    final marker = _markerAt(d.localPosition);
    if (marker == null) return;

    final result = await showDialog<String>(
      context: context,
      builder: (_) => RenameMarkerDialog(initialLabel: marker.label),
    );
    if (!mounted || result == null || result.isEmpty) return;

    _saveHistory();
    setState(() {
      _elements = _elements.map((e) {
        if (e is PlayerMarker && e.id == marker.id) {
          return e.copyWith(label: result);
        }
        return e;
      }).toList();
    });
  }

  GestureRecognizerFactoryWithHandlers<LongPressGestureRecognizer>
  _longPressFactory() {
    return GestureRecognizerFactoryWithHandlers<LongPressGestureRecognizer>(
      () => LongPressGestureRecognizer(duration: _markerRenameHoldDuration),
      (recognizer) {
        recognizer.onLongPressStart = _onLongPressStart;
      },
    );
  }

  GestureRecognizerFactoryWithHandlers<PanGestureRecognizer> _panFactory() {
    return GestureRecognizerFactoryWithHandlers<PanGestureRecognizer>(
      PanGestureRecognizer.new,
      (recognizer) {
        recognizer
          ..onStart = _onPanStart
          ..onUpdate = _onPanUpdate
          ..onEnd = _onPanEnd;
      },
    );
  }

  // ── build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.tacticalBoard),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            tooltip: l10n.help,
            onPressed: () => TacticalBoardHelpDialog.show(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: AspectRatio(
                aspectRatio: _courtAspectRatio,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    _courtSize = constraints.biggest;
                    return Stack(
                      children: [
                        const CustomPaint(
                          size: Size.infinite,
                          painter: CourtPainter(
                            lineColor: Colors.white,
                            courtColor: Color(0xFF1B5E20),
                          ),
                        ),
                        RawGestureDetector(
                          behavior: HitTestBehavior.opaque,
                          gestures: {
                            LongPressGestureRecognizer: _longPressFactory(),
                            PanGestureRecognizer: _panFactory(),
                          },
                          child: CustomPaint(
                            size: Size.infinite,
                            painter: BoardPainter(
                              elements: _elements,
                              currentStroke: _currentStroke,
                              arrowPreviewStart: _arrowStart,
                              arrowPreviewEnd: _arrowCurrent,
                              previewColor: _color,
                            ),
                          ),
                        ),
                        ..._markers.map((marker) {
                          const r = 18.0;
                          final px = marker.position.dx * _courtSize.width;
                          final py = marker.position.dy * _courtSize.height;
                          return Positioned(
                            left: px - r,
                            top: py - r,
                            child: _MarkerToken(marker: marker, radius: r),
                          );
                        }),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
          BoardToolbar(
            activeTool: _tool,
            activeColor: _color,
            canUndo: _history.isNotEmpty,
            strokeColors: _strokeColors,
            onToolSelected: (tool) => setState(() {
              _tool = tool;
              _arrowStart = null;
              _arrowCurrent = null;
            }),
            onColorSelected: (color) => setState(() => _color = color),
            onUndo: _undo,
            onClear: _clearBoard,
          ),
        ],
      ),
    );
  }
}

class _MarkerToken extends StatelessWidget {
  const _MarkerToken({required this.marker, required this.radius});

  final PlayerMarker marker;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: radius * 2,
        height: radius * 2,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: marker.color,
          border: Border.all(color: Colors.white, width: 1.5),
          boxShadow: const [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 4,
              offset: Offset(1, 2),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          marker.label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 11,
            height: 1,
          ),
        ),
      ),
    );
  }
}
