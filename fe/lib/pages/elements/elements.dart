import 'package:flutter/material.dart';
const white = Colors.white;
const black = Colors.black;
const accentColour = Color(0xFF333C64);
const double profileButtonSize = 32.0;
const primaryColour = Color(0xFFEA6D79);
const onPrimaryColour = Colors.black;
const secondaryColour = Color(0xFFFDA187);
const onSecondaryColour = Colors.black;
const errorColour = Colors.red;
const onErrorColour = Colors.black;
const backgroundColour = Colors.white;
const onBackgroundColour = Colors.black;
var surfaceColour = Colors.grey.shade200;
const onSurfaceColour = Colors.black;

ThemeData mainTheme = ThemeData(
  dialogTheme: const DialogTheme(
    backgroundColor: Colors.white
  ),
  cardTheme: const CardTheme(
    surfaceTintColor: Colors.white,
    color: Colors.white
  ),
  cardColor: Colors.white,
  datePickerTheme: const DatePickerThemeData(
    headerBackgroundColor: primaryColour,
    backgroundColor: Colors.white,
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(color: Colors.grey.shade500)
  ),
  buttonTheme: const ButtonThemeData(
    hoverColor: black,
    focusColor: black
  ),
  drawerTheme: const DrawerThemeData(
    backgroundColor: white
  ),
  appBarTheme: const AppBarTheme(
    color: primaryColour,
    toolbarTextStyle: TextStyle(fontSize: 16, color: white),
    actionsIconTheme: IconThemeData(color: white, size: 32),
    iconTheme: IconThemeData(color: white)
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(secondaryColour),
    overlayColor: MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed)) {
          return accentColour;
        }
        return null;
      },
    ),
    ),
  ),
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: primaryColour,
    onPrimary: onPrimaryColour,
    secondary: secondaryColour,
    onSecondary: onSecondaryColour,
    error: errorColour,
    onError: onErrorColour,
    background: backgroundColour,
    onBackground: onBackgroundColour,
    surface: surfaceColour,
    onSurface: onSurfaceColour
  ),
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder()
    },
  ),
);

final darkTheme = ThemeData.dark(
  

);

class SectionHeading extends StatefulWidget {
  String text;
  Alignment? alignment = Alignment.topLeft;
  SectionHeading({super.key, required this.text,  this.alignment});

  @override
  SectionHeadingState createState() => SectionHeadingState();
}

class SectionHeadingState extends State<SectionHeading> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.alignment != null? widget.alignment!: Alignment.topLeft,
      child: Container(
        child: Column(
          children: [
            Text(
              widget.text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: secondaryColour
              ),
            ),
            const SizedBox(height: 16),
          ],
        )
      )
    );
  }
}

class SectionContainer extends StatefulWidget {
  final child;
  const SectionContainer({super.key, required this.child});

  @override
  SectionContainerState createState() => SectionContainerState();
}

class SectionContainerState extends State<SectionContainer> {
  @override
  Widget build(BuildContext context) {
    return HoverEffect(child:Container(
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.surface
      ),
      child: widget.child,
    ));
  }
}

class SectionTextFormField extends StatefulWidget {
  final child;
  const SectionTextFormField({super.key, required this.child});

  @override
  SectionTextFormFieldState createState() => SectionTextFormFieldState();
}

class SectionTextFormFieldState extends State<SectionTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.child,
    );
  }
}

class SectionHeadingBar extends StatefulWidget {
  List<Widget>? children = [];
  List<Widget>? actions = [];
  SectionHeadingBar({super.key, required this.children, this.actions});

  @override
  SectionHeadingBarState createState() => SectionHeadingBarState();
}

class SectionHeadingBarState extends State<SectionHeadingBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ...widget.children!
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ...widget.actions!
            ],
          )
        ]
      )
    );
  }
}

class SectionInput extends StatefulWidget {
  final TextEditingController controller;
  String? hint = "";
  double? fontSize;
  double? height;
  double? width;
  int? maxLength;
  SectionInput({super.key, required this.controller, this.hint, this.fontSize, this.height, this.width, this.maxLength});
  @override
  SectionInputState createState() => SectionInputState();
}

class SectionInputState extends State<SectionInput> {
  TextStyle? hintStyle;
  @override
  void initState() {
    hintStyle = TextStyle(fontSize: widget.fontSize, color: Colors.grey.shade500);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: TextFormField(
        maxLength: widget.maxLength??90000,
        controller: widget.controller, 
        textAlign: TextAlign.right, 
        style:  widget.fontSize != null ? TextStyle(fontSize: widget.fontSize) : Theme.of(context).textTheme.titleMedium,
        decoration: InputDecoration(
          counterText: "",
          border: InputBorder.none,
          hintStyle: hintStyle,
          hintText: widget.hint,
        )
      )
    );
  }
}

class HoverEffect extends StatelessWidget {
  final Widget child;
  const HoverEffect({super.key, required this.child});

  @override
  Widget build(BuildContext buildContext) {
    return InkWell(
      highlightColor: primaryColour,
      hoverColor: primaryColour,
      child: child,
    );
  }
}