import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stage_o_hng/utilities/app_text.dart';
import 'package:stage_o_hng/utilities/app_theme.dart';
import 'package:stage_o_hng/utilities/assets_path.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late PageController _pageController;

  List<bool>? isSelected;

  final List _screens = const [About(), ContactInfo()];

  @override
  void initState() {
    _pageController = PageController(keepPage: true);
    isSelected = [true, false];
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(index) {
    setState(() {
      for (int i = 0; i < isSelected!.length; i++) {
        isSelected![i] = i == index;
      }
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 200),
        curve: Curves.ease,
      );
      isSelected![index] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final text =
        Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
            ? Icon(Icons.nightlight)
            : Icon(Icons.sunny);
    return Scaffold(
      appBar: AppBar(
        actions: [
          Row(
            children: [
              text,
              Switch.adaptive(
                value: themeProvider.isDarkMode,
                onChanged: (value) {
                  final provider = Provider.of<ThemeProvider>(context, listen: false);
                  provider.toggleTheme(value);
                },
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Flex(
            direction: Axis.vertical,
            children: [
              Center(
                child: Container(
                  height: 150.0,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: Image.asset(AssetsPath.avatar),
                ),
              ),
              SizedBox(height: 20.0),
              Center(
                child: ToggleButtons(
                  isSelected: isSelected!,
                  borderRadius: BorderRadius.circular(10.0),
                  constraints: BoxConstraints(minWidth: width / 3),
                  onPressed: (index) => _onPageChanged(index),
                  children: [Center(child: Text('About')), Center(child: Text('Contact Info'))],
                ),
              ),
              Expanded(
                child: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  itemCount: _screens.length,
                  itemBuilder: (context, selectedIndex) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: _screens[selectedIndex],
                    );
                  },
                  onPageChanged: (index) => _onPageChanged(index),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Title(title: 'Name', subtitle: 'Ayodele Gabriel Adeleye'),
        Title(title: 'Occupation', subtitle: 'Flutter Developer'),
        Title(
          title: 'Hobbies',
          subtitle: 'Travelling, Reading, Binge watching, Listening to music, Eating',
        ),
        Title(title: 'Fun Fact', subtitle: 'Loves dry jokes and the colour green'),
      ],
    );
  }
}

class ContactInfo extends StatelessWidget {
  const ContactInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Title(title: 'Phone', subtitle: '+2347060974828', color: true),
        Title(title: 'Email', subtitle: 'gabemandev@gmail.com', color: true),
        Title(title: 'X', subtitle: 'https://x.com/Gab_Ayodele', color: true),
        Title(
          title: 'LinkedIn',
          subtitle: 'https://www.linkedin.com/in/gabriel-ayodele-8a48101b3/',
          color: true,
        ),
        Title(title: 'GitHub', subtitle: 'https://github.com/Ayodele-Gabriel', color: true),
      ],
    );
  }
}

class Title extends StatelessWidget {
  const Title({super.key, required this.title, this.color, this.subtitle});

  final String title;
  final bool? color;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: kTitle),
      subtitle:
          subtitle != null
              ? color == true
                  ? SelectableText(
                    subtitle!,
                    style: kSubtitle.copyWith(color: color == true ? Colors.blueAccent : null),
                  )
                  : Text(
                    subtitle!,
                    style: kSubtitle.copyWith(color: color == true ? Colors.blueAccent : null),
                  )
              : null,
    );
  }
}
