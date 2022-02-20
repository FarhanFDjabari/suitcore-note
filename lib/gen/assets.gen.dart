/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// ignore_for_file: directives_ordering,unnecessary_import

import 'package:flutter/widgets.dart';

class $LibGen {
  const $LibGen();

  $LibResourcesGen get resources => const $LibResourcesGen();
}

class $LibResourcesGen {
  const $LibResourcesGen();

  $LibResourcesImagesGen get images => const $LibResourcesImagesGen();
}

class $LibResourcesImagesGen {
  const $LibResourcesImagesGen();

  /// File path: lib/resources/images/empty_state_code.png
  AssetGenImage get emptyStateCode =>
      const AssetGenImage('lib/resources/images/empty_state_code.png');

  /// File path: lib/resources/images/ic_logo_suitcore_main.png
  AssetGenImage get icLogoSuitcoreMain =>
      const AssetGenImage('lib/resources/images/ic_logo_suitcore_main.png');

  /// File path: lib/resources/images/img_empty.png
  AssetGenImage get imgEmpty =>
      const AssetGenImage('lib/resources/images/img_empty.png');

  /// File path: lib/resources/images/img_error.png
  AssetGenImage get imgError =>
      const AssetGenImage('lib/resources/images/img_error.png');

  /// File path: lib/resources/images/user_placeholder.png
  AssetGenImage get userPlaceholder =>
      const AssetGenImage('lib/resources/images/user_placeholder.png');
}

class Assets {
  Assets._();

  static const $LibGen lib = $LibGen();
}

class AssetGenImage extends AssetImage {
  const AssetGenImage(String assetName) : super(assetName);

  Image image({
    Key? key,
    ImageFrameBuilder? frameBuilder,
    ImageLoadingBuilder? loadingBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? width,
    double? height,
    Color? color,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    FilterQuality filterQuality = FilterQuality.low,
  }) {
    return Image(
      key: key,
      image: this,
      frameBuilder: frameBuilder,
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      width: width,
      height: height,
      color: color,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      filterQuality: filterQuality,
    );
  }

  String get path => assetName;
}
