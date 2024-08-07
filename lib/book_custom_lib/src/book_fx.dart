import 'dart:math';
import 'package:flutter/material.dart';
import 'book_controller.dart';
import 'book_painter.dart';
import 'current_paper.dart';
import 'model/paper_point.dart';

class BookFx extends StatefulWidget {
  final Duration? duration;
  final Size size;
  final Widget Function(int index) currentPage;
  final Widget Function(int index) nextPage;
  final Color? currentBgColor;
  final int pageCount;
  final Function(int index)? nextCallBack;
  final Function(int index)? lastCallBack;
  final BookController controller;

  const BookFx({this.duration, required this.size, required this.currentPage, required this.nextPage, this.currentBgColor, this.pageCount = 10000, this.nextCallBack, this.lastCallBack, required this.controller, super.key});

  @override
  _BookFxState createState() => _BookFxState();
}

class _BookFxState extends State<BookFx> with SingleTickerProviderStateMixin {
  late Size size = widget.size;
  late Offset downPos;
  Point<double> currentA = const Point(0, 0);
  AnimationController? _controller;


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration ?? const Duration(milliseconds: 500));
    _controller?.addListener(() {
      if (isNext) {
        _p.value = PaperPoint(Point(currentA.x - (currentA.x + size.width) * _controller!.value, currentA.y + (size.height - currentA.y) * _controller!.value), size);
      } else {
        _p.value = PaperPoint(Point(currentA.x + (size.width - currentA.x) * _controller!.value, currentA.y + (size.height - currentA.y) * _controller!.value), size);
      }
    });
    _controller?.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        isAnimation = false;
        if (isNext) {
          setState(() {
            isAlPath = true;
            widget.controller.currentIndex++;
            widget.nextCallBack?.call(widget.controller.currentIndex + 1);
          });
        }
      }
      if (status == AnimationStatus.dismissed) {}
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _p.value = PaperPoint(Point(size.width, size.height), size));
    widget.controller.addListener(() {
      if (isAnimation == true) {
        return;
      }
      if (widget.controller.nextType == 1) {
        if (widget.controller.currentIndex >= widget.pageCount - 1) {
          widget.nextCallBack?.call(widget.pageCount);
          return;
        }
        next();
      } else if (widget.controller.nextType == -1) {
        if (widget.controller.currentIndex != 0) {
          last();
          return;
        } else {
          widget.lastCallBack?.call(widget.controller.currentIndex);
        }
      } else if (widget.controller.nextType == 0) {
        if (widget.controller.currentIndex == widget.controller.goToIndex - 1 ||
            widget.controller.goToIndex < 0 ||
            widget.controller.goToIndex > widget.pageCount) {
          return;
        } else {
          setState(() {
            widget.controller.currentIndex = widget.controller.goToIndex - 1;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  bool isNext = true;
  bool isAlPath = true;
  bool isAnimation = false;

  final ValueNotifier<PaperPoint> _p = ValueNotifier(PaperPoint(const Point(0, 0), const Size(0, 0)));

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height: size.height,
      child: GestureDetector(
        child: Stack(
          children: [
            widget.controller.currentIndex == widget.pageCount - 1 ? const SizedBox() : widget.nextPage(widget.controller.currentIndex + 1),
            ClipPath(
              clipper: isAlPath ? null : CurrentPaperClipPath(_p, isNext),
              child: widget.currentPage(widget.controller.currentIndex)
            ),
            CustomPaint(
              size: size,
              painter: BookPainter(_p, widget.currentBgColor)
            )
          ]
        ),
        onPanDown: (d) {downPos = d.localPosition;},
        onPanUpdate: (d) {
          if (isAnimation) return;
          if (widget.controller.currentIndex == widget.pageCount - 1) return;
          var move = d.localPosition;
          if (move.dx >= size.width || move.dx < 0 || move.dy >= size.height || move.dy < 0) return;
          if (downPos.dx < size.width / 2) return;
          if (isAlPath == true) {
            setState(() {
              isAlPath = false;
            });
          }
          if (downPos.dy > size.height / 3 &&
              downPos.dy < size.height * 2 / 3) {
            currentA = Point(move.dx, size.height - 1);
            _p.value = PaperPoint(Point(move.dx, size.height - 1), size);
          } else {
            currentA = Point(move.dx, move.dy);
            _p.value = PaperPoint(Point(move.dx, move.dy), size);
          }
          if ((size.width - move.dx) / size.width > 1 / 3) {
            isNext = true;
          } else {
            isNext = false;
          }
        },
        onPanEnd: (d) {
          if (isAnimation) return;
          if (downPos.dx < size.width / 2) {
            if (widget.controller.currentIndex == 0) {
              widget.lastCallBack?.call(widget.controller.currentIndex);
              return;
            }
            widget.lastCallBack?.call(widget.controller.currentIndex);
            last();
            return;
          }
          if (widget.controller.currentIndex == widget.pageCount - 1) {
            widget.nextCallBack?.call(widget.pageCount);
            return;
          }
          setState(() {
            isAlPath = false;
          });
          isAnimation = true;
          _controller?.forward(
            from: 0
          );
        }
      )
    );
  }

  void last() {
    setState(() {
      isAlPath = false;
      isAnimation = true;
      currentA = Point(-200, size.height - 100);
      widget.controller.currentIndex--;
      isNext = false;
      _controller?.forward(
        from: 0
      );
    });
  }

  void next() {
    setState(() => isAlPath = false);
    isAnimation = true;
    isNext = true;
    currentA = Point(size.width - 50, size.height - 50);
    _controller?.forward(
      from: 0
    );
  }
}
