import 'dart:async';

import 'package:flutter/material.dart';

import '../../app/app_theme.dart';
import 'parental_gate.dart';
import 'parental_question.dart';

/// Ebeveyn doğrulama penceresi. Yazıyla verilen bir çarpma sorusu sorulur, cevap rakam tuşlarıyla
/// girilir. Doğru cevapta `true`, vazgeçmede `false` ile kapanır. Yanlış cevapta yeni bir soru
/// gelir ve tuşlar kısa bir süre kilitlenir; böylece rastgele denemelerle geçmek zorlaşır.
final class ParentalGateDialog extends StatefulWidget {
  const ParentalGateDialog({required this.action, required this.questions, super.key});

  final ParentalAction action;
  final ParentalQuestionGenerator questions;

  static const title = 'Ebeveyn onayı';
  static const intro = 'Bu işlem için bir yetişkinin onayı gerekiyor:';
  static const answerHint = 'Cevabı rakamlarla yazın.';
  static const cancelLabel = 'Vazgeç';
  static const confirmLabel = 'Onayla';
  static const deleteLabel = 'Sil';
  static const answerLabel = 'Cevap';
  static const wrongAnswer = 'Cevap yanlış. Biraz bekleyin, sonra yeni soruyu cevaplayın.';

  /// Yanlış cevaptan sonra tuşların kilitli kaldığı süre.
  static const wrongAnswerDelay = Duration(seconds: 3);

  /// Pencereyi açar; doğrulama geçilirse `true`, aksi halde (vazgeçme, dışarı dokunma) `false` döner.
  static Future<bool> show(BuildContext context, ParentalAction action, ParentalQuestionGenerator questions) async =>
      await showDialog<bool>(
        context: context,
        builder: (_) => ParentalGateDialog(action: action, questions: questions),
      ) ??
      false;

  @override
  State<ParentalGateDialog> createState() => _ParentalGateDialogState();
}

final class _ParentalGateDialogState extends State<ParentalGateDialog> {
  late ParentalQuestion _question = widget.questions.next();
  String _answer = '';
  Timer? _lock;

  bool get _isLocked => _lock?.isActive ?? false;

  @override
  void dispose() {
    _lock?.cancel();
    super.dispose();
  }

  void _type(int digit) {
    if (_answer.length < ParentalQuestionGenerator.maxAnswerDigits) {
      setState(() => _answer += '$digit');
    }
  }

  void _delete() {
    if (_answer.isNotEmpty) {
      setState(() => _answer = _answer.substring(0, _answer.length - 1));
    }
  }

  void _confirm() {
    if (int.tryParse(_answer) == _question.answer) {
      Navigator.of(context).pop(true);
      return;
    }
    setState(() {
      _question = widget.questions.next();
      _answer = '';
      _lock = Timer(ParentalGateDialog.wrongAnswerDelay, () => setState(() {}));
    });
  }

  /// Yatay ekranda soru solda, tuş takımı sağda durur; böylece pencere alçak ekranlara da sığar.
  static const _wideContentWidth = 600.0;
  static const _wideKeypadWidth = 260.0;
  static const _gap = 12.0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isLandscape = size.width > size.height;
    final keypad = _Keypad(
      enabled: !_isLocked,
      canConfirm: _answer.isNotEmpty,
      onDigit: _type,
      onDelete: _delete,
      onConfirm: _confirm,
    );
    return AlertDialog(
      title: const Text(ParentalGateDialog.title),
      content: SingleChildScrollView(
        child: isLandscape
            ? SizedBox(
                width: _wideContentWidth,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: _gap * 2,
                  children: [
                    Expanded(child: _questionColumn(context)),
                    SizedBox(width: _wideKeypadWidth, child: keypad),
                  ],
                ),
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: _gap,
                children: [_questionColumn(context), keypad],
              ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text(ParentalGateDialog.cancelLabel),
        ),
      ],
    );
  }

  /// İşlem açıklaması, soru, cevap kutusu ve yanlış cevap uyarısı.
  Widget _questionColumn(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('${ParentalGateDialog.intro} ${widget.action.description}.', style: text.bodyMedium),
        const SizedBox(height: _gap),
        Text(
          _question.text,
          style: text.titleLarge?.copyWith(color: AppColors.navy, fontWeight: FontWeight.w800),
        ),
        Text(ParentalGateDialog.answerHint, style: text.bodySmall),
        const SizedBox(height: _gap),
        _AnswerBox(answer: _answer),
        if (_isLocked) ...[
          const SizedBox(height: _gap),
          Semantics(
            liveRegion: true,
            child: Text(ParentalGateDialog.wrongAnswer, style: text.bodyMedium?.copyWith(color: AppColors.redDark)),
          ),
        ],
      ],
    );
  }
}

/// Girilen cevabın göründüğü kutu.
final class _AnswerBox extends StatelessWidget {
  const _AnswerBox({required this.answer});

  final String answer;

  static const _height = 56.0;
  static const _borderWidth = 3.0;

  @override
  Widget build(BuildContext context) => Semantics(
    label: ParentalGateDialog.answerLabel,
    value: answer,
    excludeSemantics: true,
    child: Container(
      height: _height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppMetrics.mediumRadius),
        border: Border.all(color: AppColors.blue, width: _borderWidth),
      ),
      child: Text(
        answer,
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: AppColors.navy, fontWeight: FontWeight.w800),
      ),
    ),
  );
}

/// Rakam tuşları: üç satırda 1–9, altında sil, 0 ve onayla.
final class _Keypad extends StatelessWidget {
  const _Keypad({
    required this.enabled,
    required this.canConfirm,
    required this.onDigit,
    required this.onDelete,
    required this.onConfirm,
  });

  final bool enabled;
  final bool canConfirm;
  final ValueChanged<int> onDigit;
  final VoidCallback onDelete;
  final VoidCallback onConfirm;

  static const _columns = 3;
  static const _gap = 8.0;
  static const _keyHeight = 52.0;
  static const _highestDigit = 9;

  @override
  Widget build(BuildContext context) {
    final keys = [
      for (var digit = 1; digit <= _highestDigit; digit++) _digitKey(digit),
      _Key(label: ParentalGateDialog.deleteLabel, icon: Icons.backspace_rounded, onPressed: enabled ? onDelete : null),
      _digitKey(0),
      _Key(
        label: ParentalGateDialog.confirmLabel,
        icon: Icons.check_rounded,
        onPressed: enabled && canConfirm ? onConfirm : null,
      ),
    ];
    return Column(
      spacing: _gap,
      children: [
        for (var row = 0; row < keys.length; row += _columns)
          SizedBox(
            height: _keyHeight,
            child: Row(
              spacing: _gap,
              children: [for (final key in keys.sublist(row, row + _columns)) Expanded(child: key)],
            ),
          ),
      ],
    );
  }

  _Key _digitKey(int digit) => _Key(label: '$digit', onPressed: enabled ? () => onDigit(digit) : null);
}

/// Tek tuş. Simgeli tuşlarda [label] ekran okuyucuya söylenir.
final class _Key extends StatelessWidget {
  const _Key({required this.label, required this.onPressed, this.icon});

  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;

  static const _fontSize = 22.0;

  @override
  Widget build(BuildContext context) => FilledButton.tonal(
    onPressed: onPressed,
    style: FilledButton.styleFrom(padding: EdgeInsets.zero),
    child: icon == null
        ? Text(
            label,
            style: const TextStyle(fontSize: _fontSize, fontWeight: FontWeight.w800),
          )
        : Icon(icon, semanticLabel: label),
  );
}
