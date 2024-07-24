import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4284634768),
      surfaceTint: Color(4284634768),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4293385983),
      onPrimaryContainer: Color(4280160328),
      secondary: Color(4284570481),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4293386232),
      onSecondaryContainer: Color(4280097067),
      tertiary: Color(4286403170),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4294957540),
      onTertiaryContainer: Color(4281405726),
      error: Color(4290386458),
      onError: Color(4294967295),
      errorContainer: Color(4294957782),
      onErrorContainer: Color(4282449922),
      surface: Color(4294834175),
      onSurface: Color(4280032032),
      onSurfaceVariant: Color(4282926414),
      outline: Color(4286150015),
      outlineVariant: Color(4291478735),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281413429),
      inversePrimary: Color(4291608063),
      primaryFixed: Color(4293385983),
      onPrimaryFixed: Color(4280160328),
      primaryFixedDim: Color(4291608063),
      onPrimaryFixedVariant: Color(4283055734),
      secondaryFixed: Color(4293386232),
      onSecondaryFixed: Color(4280097067),
      secondaryFixedDim: Color(4291478492),
      onSecondaryFixedVariant: Color(4282991704),
      tertiaryFixed: Color(4294957540),
      onTertiaryFixed: Color(4281405726),
      tertiaryFixedDim: Color(4293834954),
      onTertiaryFixedVariant: Color(4284627786),
      surfaceDim: Color(4292729056),
      surfaceBright: Color(4294834175),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294439674),
      surfaceContainer: Color(4294044916),
      surfaceContainerHigh: Color(4293715694),
      surfaceContainerHighest: Color(4293321193),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4282792562),
      surfaceTint: Color(4284634768),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4286147751),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4282728532),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4286017928),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4284364614),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4287981688),
      onTertiaryContainer: Color(4294967295),
      error: Color(4287365129),
      onError: Color(4294967295),
      errorContainer: Color(4292490286),
      onErrorContainer: Color(4294967295),
      surface: Color(4294834175),
      onSurface: Color(4280032032),
      onSurfaceVariant: Color(4282663242),
      outline: Color(4284570983),
      outlineVariant: Color(4286413187),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281413429),
      inversePrimary: Color(4291608063),
      primaryFixed: Color(4286147751),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4284502925),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4286017928),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4284373358),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4287981688),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4286206047),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292729056),
      surfaceBright: Color(4294834175),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294439674),
      surfaceContainer: Color(4294044916),
      surfaceContainerHigh: Color(4293715694),
      surfaceContainerHighest: Color(4293321193),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4280621135),
      surfaceTint: Color(4284634768),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4282792562),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4280557618),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4282728532),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4281931557),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4284364614),
      onTertiaryContainer: Color(4294967295),
      error: Color(4283301890),
      onError: Color(4294967295),
      errorContainer: Color(4287365129),
      onErrorContainer: Color(4294967295),
      surface: Color(4294834175),
      onSurface: Color(4278190080),
      onSurfaceVariant: Color(4280623915),
      outline: Color(4282663242),
      outlineVariant: Color(4282663242),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281413429),
      inversePrimary: Color(4293978367),
      primaryFixed: Color(4282792562),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4281344858),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4282728532),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4281215549),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4284364614),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4282720560),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292729056),
      surfaceBright: Color(4294834175),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294439674),
      surfaceContainer: Color(4294044916),
      surfaceContainerHigh: Color(4293715694),
      surfaceContainerHighest: Color(4293321193),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4291608063),
      surfaceTint: Color(4291608063),
      onPrimary: Color(4281608030),
      primaryContainer: Color(4283055734),
      onPrimaryContainer: Color(4293385983),
      secondary: Color(4291478492),
      onSecondary: Color(4281478721),
      secondaryContainer: Color(4282991704),
      onSecondaryContainer: Color(4293386232),
      tertiary: Color(4293834954),
      onTertiary: Color(4282983732),
      tertiaryContainer: Color(4284627786),
      onTertiaryContainer: Color(4294957540),
      error: Color(4294948011),
      onError: Color(4285071365),
      errorContainer: Color(4287823882),
      onErrorContainer: Color(4294957782),
      surface: Color(4279505688),
      onSurface: Color(4293321193),
      onSurfaceVariant: Color(4291478735),
      outline: Color(4287860633),
      outlineVariant: Color(4282926414),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293321193),
      inversePrimary: Color(4284634768),
      primaryFixed: Color(4293385983),
      onPrimaryFixed: Color(4280160328),
      primaryFixedDim: Color(4291608063),
      onPrimaryFixedVariant: Color(4283055734),
      secondaryFixed: Color(4293386232),
      onSecondaryFixed: Color(4280097067),
      secondaryFixedDim: Color(4291478492),
      onSecondaryFixedVariant: Color(4282991704),
      tertiaryFixed: Color(4294957540),
      onTertiaryFixed: Color(4281405726),
      tertiaryFixedDim: Color(4293834954),
      onTertiaryFixedVariant: Color(4284627786),
      surfaceDim: Color(4279505688),
      surfaceBright: Color(4282005566),
      surfaceContainerLowest: Color(4279176467),
      surfaceContainerLow: Color(4280032032),
      surfaceContainer: Color(4280295204),
      surfaceContainerHigh: Color(4281018671),
      surfaceContainerHighest: Color(4281742394),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4291871487),
      surfaceTint: Color(4291608063),
      onPrimary: Color(4279831107),
      primaryContainer: Color(4288055494),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4291807200),
      onSecondary: Color(4279768102),
      secondaryContainer: Color(4287925669),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294163662),
      onTertiary: Color(4280945433),
      tertiaryContainer: Color(4290020244),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294949553),
      onError: Color(4281794561),
      errorContainer: Color(4294923337),
      onErrorContainer: Color(4278190080),
      surface: Color(4279505688),
      onSurface: Color(4294900223),
      onSurfaceVariant: Color(4291742164),
      outline: Color(4289110444),
      outlineVariant: Color(4286939531),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293321193),
      inversePrimary: Color(4283187063),
      primaryFixed: Color(4293385983),
      onPrimaryFixed: Color(4279501630),
      primaryFixedDim: Color(4291608063),
      onPrimaryFixedVariant: Color(4281937252),
      secondaryFixed: Color(4293386232),
      onSecondaryFixed: Color(4279373344),
      secondaryFixedDim: Color(4291478492),
      onSecondaryFixedVariant: Color(4281873223),
      tertiaryFixed: Color(4294957540),
      onTertiaryFixed: Color(4280550932),
      tertiaryFixedDim: Color(4293834954),
      onTertiaryFixedVariant: Color(4283444025),
      surfaceDim: Color(4279505688),
      surfaceBright: Color(4282005566),
      surfaceContainerLowest: Color(4279176467),
      surfaceContainerLow: Color(4280032032),
      surfaceContainer: Color(4280295204),
      surfaceContainerHigh: Color(4281018671),
      surfaceContainerHighest: Color(4281742394),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4294900223),
      surfaceTint: Color(4291608063),
      onPrimary: Color(4278190080),
      primaryContainer: Color(4291871487),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4294900223),
      onSecondary: Color(4278190080),
      secondaryContainer: Color(4291807200),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294965753),
      onTertiary: Color(4278190080),
      tertiaryContainer: Color(4294163662),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294965753),
      onError: Color(4278190080),
      errorContainer: Color(4294949553),
      onErrorContainer: Color(4278190080),
      surface: Color(4279505688),
      onSurface: Color(4294967295),
      onSurfaceVariant: Color(4294900223),
      outline: Color(4291742164),
      outlineVariant: Color(4291742164),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293321193),
      inversePrimary: Color(4281147479),
      primaryFixed: Color(4293649407),
      onPrimaryFixed: Color(4278190080),
      primaryFixedDim: Color(4291871487),
      onPrimaryFixedVariant: Color(4279831107),
      secondaryFixed: Color(4293649405),
      onSecondaryFixed: Color(4278190080),
      secondaryFixedDim: Color(4291807200),
      onSecondaryFixedVariant: Color(4279768102),
      tertiaryFixed: Color(4294959080),
      onTertiaryFixed: Color(4278190080),
      tertiaryFixedDim: Color(4294163662),
      onTertiaryFixedVariant: Color(4280945433),
      surfaceDim: Color(4279505688),
      surfaceBright: Color(4282005566),
      surfaceContainerLowest: Color(4279176467),
      surfaceContainerLow: Color(4280032032),
      surfaceContainer: Color(4280295204),
      surfaceContainerHigh: Color(4281018671),
      surfaceContainerHighest: Color(4281742394),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.background,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
