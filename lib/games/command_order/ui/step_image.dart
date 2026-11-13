import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Görev ve kart görseli. Web sürümünden gelen görseller `.svg` veya `.webp` olabilir.
/// Görseller süs amaçlıdır; anlamı yanındaki yazı taşır.
final class StepImage extends StatelessWidget {
  const StepImage(this.asset, {required this.size, super.key});

  final String asset;
  final double size;

  static const _svgExtension = '.svg';

  @override
  Widget build(BuildContext context) => ExcludeSemantics(
    child: asset.endsWith(_svgExtension)
        ? SvgPicture.asset(asset, width: size, height: size)
        : Image.asset(asset, width: size, height: size),
  );
}
