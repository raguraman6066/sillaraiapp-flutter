import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4285488398),
      surfaceTint: Color(4285488398),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4294632071),
      onPrimaryContainer: Color(4280425216),
      secondary: Color(4282411062),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4290834352),
      onSecondaryContainer: Color(4278198784),
      tertiary: Color(4282672718),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4291226829),
      onTertiaryContainer: Color(4278198542),
      error: Color(4290386458),
      onError: Color(4294967295),
      errorContainer: Color(4294957782),
      onErrorContainer: Color(4282449922),
      background: Color(4294965743),
      onBackground: Color(4280163091),
      surface: Color(4294965743),
      onSurface: Color(4280163091),
      surfaceVariant: Color(4293583567),
      onSurfaceVariant: Color(4283123513),
      outline: Color(4286347111),
      outlineVariant: Color(4291675828),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281544743),
      inverseOnSurface: Color(4294439138),
      inversePrimary: Color(4292724334),
      primaryFixed: Color(4294632071),
      onPrimaryFixed: Color(4280425216),
      primaryFixedDim: Color(4292724334),
      onPrimaryFixedVariant: Color(4283713024),
      secondaryFixed: Color(4290834352),
      onSecondaryFixed: Color(4278198784),
      secondaryFixedDim: Color(4289057686),
      onSecondaryFixedVariant: Color(4280832032),
      tertiaryFixed: Color(4291226829),
      onTertiaryFixed: Color(4278198542),
      tertiaryFixedDim: Color(4289384626),
      onTertiaryFixedVariant: Color(4281159223),
      surfaceDim: Color(4292925900),
      surfaceBright: Color(4294965743),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294636517),
      surfaceContainer: Color(4294241759),
      surfaceContainerHigh: Color(4293912538),
      surfaceContainerHighest: Color(4293518036),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme lightMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4283449856),
      surfaceTint: Color(4285488398),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4287001381),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4280568605),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4283793226),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4280896051),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4284120163),
      onTertiaryContainer: Color(4294967295),
      error: Color(4287365129),
      onError: Color(4294967295),
      errorContainer: Color(4292490286),
      onErrorContainer: Color(4294967295),
      background: Color(4294965743),
      onBackground: Color(4280163091),
      surface: Color(4294965743),
      onSurface: Color(4280163091),
      surfaceVariant: Color(4293583567),
      onSurfaceVariant: Color(4282860341),
      outline: Color(4284768080),
      outlineVariant: Color(4286610027),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281544743),
      inverseOnSurface: Color(4294439138),
      inversePrimary: Color(4292724334),
      primaryFixed: Color(4287001381),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4285291275),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4283793226),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4282213940),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4284120163),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4282540875),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292925900),
      surfaceBright: Color(4294965743),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294636517),
      surfaceContainer: Color(4294241759),
      surfaceContainerHigh: Color(4293912538),
      surfaceContainerHighest: Color(4293518036),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme lightHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4280951296),
      surfaceTint: Color(4285488398),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4283449856),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4278331649),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4280568605),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4278528020),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4280896051),
      onTertiaryContainer: Color(4294967295),
      error: Color(4283301890),
      onError: Color(4294967295),
      errorContainer: Color(4287365129),
      onErrorContainer: Color(4294967295),
      background: Color(4294965743),
      onBackground: Color(4280163091),
      surface: Color(4294965743),
      onSurface: Color(4278190080),
      surfaceVariant: Color(4293583567),
      onSurfaceVariant: Color(4280755224),
      outline: Color(4282860341),
      outlineVariant: Color(4282860341),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281544743),
      inverseOnSurface: Color(4294967295),
      inversePrimary: Color(4294962089),
      primaryFixed: Color(4283449856),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4281740288),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4280568605),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4279055368),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4280896051),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4279317278),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292925900),
      surfaceBright: Color(4294965743),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294636517),
      surfaceContainer: Color(4294241759),
      surfaceContainerHigh: Color(4293912538),
      surfaceContainerHighest: Color(4293518036),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4292724334),
      surfaceTint: Color(4292724334),
      onPrimary: Color(4282003456),
      primaryContainer: Color(4283713024),
      onPrimaryContainer: Color(4294632071),
      secondary: Color(4289057686),
      onSecondary: Color(4279318539),
      secondaryContainer: Color(4280832032),
      onSecondaryContainer: Color(4290834352),
      tertiary: Color(4289384626),
      onTertiary: Color(4279580450),
      tertiaryContainer: Color(4281159223),
      onTertiaryContainer: Color(4291226829),
      error: Color(4294948011),
      onError: Color(4285071365),
      errorContainer: Color(4287823882),
      onErrorContainer: Color(4294957782),
      background: Color(4279636747),
      onBackground: Color(4293518036),
      surface: Color(4279636747),
      onSurface: Color(4293518036),
      surfaceVariant: Color(4283123513),
      onSurfaceVariant: Color(4291675828),
      outline: Color(4288123008),
      outlineVariant: Color(4283123513),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293518036),
      inverseOnSurface: Color(4281544743),
      inversePrimary: Color(4285488398),
      primaryFixed: Color(4294632071),
      onPrimaryFixed: Color(4280425216),
      primaryFixedDim: Color(4292724334),
      onPrimaryFixedVariant: Color(4283713024),
      secondaryFixed: Color(4290834352),
      onSecondaryFixed: Color(4278198784),
      secondaryFixedDim: Color(4289057686),
      onSecondaryFixedVariant: Color(4280832032),
      tertiaryFixed: Color(4291226829),
      onTertiaryFixed: Color(4278198542),
      tertiaryFixedDim: Color(4289384626),
      onTertiaryFixedVariant: Color(4281159223),
      surfaceDim: Color(4279636747),
      surfaceBright: Color(4282136879),
      surfaceContainerLowest: Color(4279242247),
      surfaceContainerLow: Color(4280163091),
      surfaceContainer: Color(4280426263),
      surfaceContainerHigh: Color(4281149985),
      surfaceContainerHighest: Color(4281873707),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  static MaterialScheme darkMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4292987506),
      surfaceTint: Color(4292724334),
      onPrimary: Color(4280030720),
      primaryContainer: Color(4288974910),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4289320857),
      onSecondary: Color(4278197248),
      secondaryContainer: Color(4285635684),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4289647798),
      onTertiary: Color(4278197003),
      tertiaryContainer: Color(4285897086),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294949553),
      onError: Color(4281794561),
      errorContainer: Color(4294923337),
      onErrorContainer: Color(4278190080),
      background: Color(4279636747),
      onBackground: Color(4293518036),
      surface: Color(4279636747),
      onSurface: Color(4294966005),
      surfaceVariant: Color(4283123513),
      onSurfaceVariant: Color(4292004536),
      outline: Color(4289307282),
      outlineVariant: Color(4287202163),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293518036),
      inverseOnSurface: Color(4281149985),
      inversePrimary: Color(4283844352),
      primaryFixed: Color(4294632071),
      onPrimaryFixed: Color(4279636224),
      primaryFixedDim: Color(4292724334),
      onPrimaryFixedVariant: Color(4282463488),
      secondaryFixed: Color(4290834352),
      onSecondaryFixed: Color(4278195712),
      secondaryFixedDim: Color(4289057686),
      onSecondaryFixedVariant: Color(4279713297),
      tertiaryFixed: Color(4291226829),
      onTertiaryFixed: Color(4278195463),
      tertiaryFixedDim: Color(4289384626),
      onTertiaryFixedVariant: Color(4280040743),
      surfaceDim: Color(4279636747),
      surfaceBright: Color(4282136879),
      surfaceContainerLowest: Color(4279242247),
      surfaceContainerLow: Color(4280163091),
      surfaceContainer: Color(4280426263),
      surfaceContainerHigh: Color(4281149985),
      surfaceContainerHighest: Color(4281873707),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme darkHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4294966005),
      surfaceTint: Color(4292724334),
      onPrimary: Color(4278190080),
      primaryContainer: Color(4292987506),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4294049768),
      onSecondary: Color(4278190080),
      secondaryContainer: Color(4289320857),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4293918703),
      onTertiary: Color(4278190080),
      tertiaryContainer: Color(4289647798),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294965753),
      onError: Color(4278190080),
      errorContainer: Color(4294949553),
      onErrorContainer: Color(4278190080),
      background: Color(4279636747),
      onBackground: Color(4293518036),
      surface: Color(4279636747),
      onSurface: Color(4294967295),
      surfaceVariant: Color(4283123513),
      onSurfaceVariant: Color(4294966005),
      outline: Color(4292004536),
      outlineVariant: Color(4292004536),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293518036),
      inverseOnSurface: Color(4278190080),
      inversePrimary: Color(4281542912),
      primaryFixed: Color(4294960779),
      onPrimaryFixed: Color(4278190080),
      primaryFixedDim: Color(4292987506),
      onPrimaryFixedVariant: Color(4280030720),
      secondaryFixed: Color(4291097780),
      onSecondaryFixed: Color(4278190080),
      secondaryFixedDim: Color(4289320857),
      onSecondaryFixedVariant: Color(4278197248),
      tertiaryFixed: Color(4291490001),
      onTertiaryFixed: Color(4278190080),
      tertiaryFixedDim: Color(4289647798),
      onTertiaryFixedVariant: Color(4278197003),
      surfaceDim: Color(4279636747),
      surfaceBright: Color(4282136879),
      surfaceContainerLowest: Color(4279242247),
      surfaceContainerLow: Color(4280163091),
      surfaceContainer: Color(4280426263),
      surfaceContainerHigh: Color(4281149985),
      surfaceContainerHighest: Color(4281873707),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme().toColorScheme());
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

class MaterialScheme {
  const MaterialScheme({
    required this.brightness,
    required this.primary, 
    required this.surfaceTint, 
    required this.onPrimary, 
    required this.primaryContainer, 
    required this.onPrimaryContainer, 
    required this.secondary, 
    required this.onSecondary, 
    required this.secondaryContainer, 
    required this.onSecondaryContainer, 
    required this.tertiary, 
    required this.onTertiary, 
    required this.tertiaryContainer, 
    required this.onTertiaryContainer, 
    required this.error, 
    required this.onError, 
    required this.errorContainer, 
    required this.onErrorContainer, 
    required this.background, 
    required this.onBackground, 
    required this.surface, 
    required this.onSurface, 
    required this.surfaceVariant, 
    required this.onSurfaceVariant, 
    required this.outline, 
    required this.outlineVariant, 
    required this.shadow, 
    required this.scrim, 
    required this.inverseSurface, 
    required this.inverseOnSurface, 
    required this.inversePrimary, 
    required this.primaryFixed, 
    required this.onPrimaryFixed, 
    required this.primaryFixedDim, 
    required this.onPrimaryFixedVariant, 
    required this.secondaryFixed, 
    required this.onSecondaryFixed, 
    required this.secondaryFixedDim, 
    required this.onSecondaryFixedVariant, 
    required this.tertiaryFixed, 
    required this.onTertiaryFixed, 
    required this.tertiaryFixedDim, 
    required this.onTertiaryFixedVariant, 
    required this.surfaceDim, 
    required this.surfaceBright, 
    required this.surfaceContainerLowest, 
    required this.surfaceContainerLow, 
    required this.surfaceContainer, 
    required this.surfaceContainerHigh, 
    required this.surfaceContainerHighest, 
  });

  final Brightness brightness;
  final Color primary;
  final Color surfaceTint;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color inverseOnSurface;
  final Color inversePrimary;
  final Color primaryFixed;
  final Color onPrimaryFixed;
  final Color primaryFixedDim;
  final Color onPrimaryFixedVariant;
  final Color secondaryFixed;
  final Color onSecondaryFixed;
  final Color secondaryFixedDim;
  final Color onSecondaryFixedVariant;
  final Color tertiaryFixed;
  final Color onTertiaryFixed;
  final Color tertiaryFixedDim;
  final Color onTertiaryFixedVariant;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
}

extension MaterialSchemeUtils on MaterialScheme {
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      background: background,
      onBackground: onBackground,
      surface: surface,
      onSurface: onSurface,
      surfaceVariant: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: inverseOnSurface,
      inversePrimary: inversePrimary,
    );
  }
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
