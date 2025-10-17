import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stage_o_hng/utilities/app_theme.dart';
import 'package:stage_o_hng/utilities/assets_path.dart';
import 'package:stage_o_hng/utilities/title.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late PageController _pageController;

  List<bool>? isSelected;

  final List _screens = const [_About(), _ContactInfo()];

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
                  decoration: BoxDecoration(shape: BoxShape.circle,),
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

class _About extends StatelessWidget {
  const _About({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleWidget(title: 'Name', subtitle: 'Ayodele Gabriel Adeleye'),
        TitleWidget(title: 'Occupation', subtitle: 'Flutter Developer'),
        TitleWidget(
          title: 'Hobbies',
          subtitle: 'Travelling, Reading, Binge watching, Listening to music, Eating',
        ),
        TitleWidget(title: 'Fun Fact', subtitle: 'Loves dry jokes and the colour green'),
      ],
    );
  }
}

class _ContactInfo extends StatelessWidget {
  const _ContactInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleWidget(title: 'Phone', subtitle: '+2347060974828', color: true),
        TitleWidget(title: 'Email', subtitle: 'gabemandev@gmail.com', color: true),
        TitleWidget(title: 'X', subtitle: 'https://x.com/Gab_Ayodele', color: true),
        TitleWidget(
          title: 'LinkedIn',
          subtitle: 'https://www.linkedin.com/in/gabriel-ayodele-8a48101b3/',
          color: true,
        ),
        TitleWidget(title: 'GitHub', subtitle: 'https://github.com/Ayodele-Gabriel', color: true),
      ],
    );
  }
}


