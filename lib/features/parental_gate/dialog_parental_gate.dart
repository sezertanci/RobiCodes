import 'package:flutter/widgets.dart';

import 'parental_gate.dart';
import 'parental_gate_dialog.dart';
import 'parental_question.dart';

/// Uygulamanın gerçek ebeveyn kapısı: her doğrulamada yeni bir matematik sorusuyla pencereyi açar.
final class DialogParentalGate implements ParentalGate {
  const DialogParentalGate(this._questions);

  final ParentalQuestionGenerator _questions;

  @override
  Future<bool> verify(BuildContext context, ParentalAction action) =>
      ParentalGateDialog.show(context, action, _questions);
}
