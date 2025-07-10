import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PinCodeInput extends StatefulWidget {
  final int length;
  final Function(String) onCompleted;
  final Function(String) onChanged;
  final String? initialValue;

  const PinCodeInput({
    super.key,
    this.length = 6,
    required this.onCompleted,
    required this.onChanged,
    this.initialValue,
  });

  @override
  State<PinCodeInput> createState() => _PinCodeInputState();
}

class _PinCodeInputState extends State<PinCodeInput> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;
  String _pinCode = '';

  @override
  void initState() {
    super.initState();
    _controllers =
        List.generate(widget.length, (index) => TextEditingController());
    _focusNodes = List.generate(widget.length, (index) => FocusNode());

    if (widget.initialValue != null &&
        widget.initialValue!.length == widget.length) {
      for (int i = 0; i < widget.length; i++) {
        _controllers[i].text = widget.initialValue![i];
      }
      _pinCode = widget.initialValue!;
    }

    // Definir foco no primeiro campo após a construção do widget
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_focusNodes.isNotEmpty) {
        _focusNodes[0].requestFocus();
      }
    });
  }

  @override
  void didUpdateWidget(PinCodeInput oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Atualizar campos quando initialValue mudar externamente
    if (widget.initialValue != oldWidget.initialValue &&
        widget.initialValue != null &&
        widget.initialValue!.length <= widget.length) {
      for (int i = 0; i < widget.length; i++) {
        _controllers[i].clear();
      }

      for (int i = 0; i < widget.initialValue!.length; i++) {
        _controllers[i].text = widget.initialValue![i];
      }

      _pinCode = widget.initialValue!;
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    setState(() {
      _pinCode = _controllers.map((controller) => controller.text).join();
    });

    widget.onChanged(_pinCode);

    if (value.isNotEmpty) {
      if (index < widget.length - 1) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
      }

      if (_pinCode.length == widget.length) {
        widget.onCompleted(_pinCode);
      }
    }
  }

  void _onKeyEvent(KeyEvent event, int index) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace) {
      if (_controllers[index].text.isEmpty && index > 0) {
        _focusNodes[index - 1].requestFocus();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        widget.length,
        (index) {
          return Container(
            constraints: const BoxConstraints(maxWidth: 50),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color.fromARGB(255, 246, 246, 248)
                  .withValues(alpha: 0.5),
              border: Border.all(
                color: const Color.fromARGB(255, 231, 231, 239)
                    .withValues(alpha: 0.5),
                width: 2,
              ),
            ),
            child: AspectRatio(
              aspectRatio: 0.90,
              child: Center(
                child: KeyboardListener(
                  focusNode: FocusNode(),
                  onKeyEvent: (event) => _onKeyEvent(event, index),
                  child: TextFormField(
                    controller: _controllers[index],
                    focusNode: _focusNodes[index],
                    autofocus: index == 0,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                    decoration: const InputDecoration(
                      counterText: '',
                      fillColor: Colors.transparent,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      filled: true,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(1),
                    ],
                    onChanged: (value) => _onChanged(value, index),
                    onTap: () {
                      _controllers[index].selection =
                          TextSelection.fromPosition(
                        TextPosition(offset: _controllers[index].text.length),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
