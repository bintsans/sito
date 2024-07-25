import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StudioPage extends StatefulWidget {
  @override
  _StudioPageState createState() => _StudioPageState();
}

class _StudioPageState extends State<StudioPage> {
  PageController _pageController = PageController();
  FocusNode _focusNode = FocusNode();
  int _currentPage = 0;

  final List<String> _imagePaths = [
    'assets/studio/foto1.jpg',
    'assets/studio/foto2.jpg',
    'assets/studio/foto3.jpg',
    'assets/studio/foto4.jpg',
    'assets/studio/foto5.jpg',
    'assets/studio/foto6.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _handleKeyboardEvent(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        _pageController.previousPage(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        _pageController.nextPage(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  List<Widget> _buildPaginationDots() {
    int startIndex = (_currentPage - 1).clamp(0, _imagePaths.length - 3);
    int endIndex = (_currentPage + 1).clamp(2, _imagePaths.length - 1);

    List<Widget> dots = [];
    for (int i = startIndex; i <= endIndex; i++) {
      dots.add(Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: i == _currentPage ? Colors.blue : Colors.grey,
        ),
      ));
    }

    return dots;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/', // Nome della route per la homepage
              (Route<dynamic> route) =>
                  false, // Rimuove tutte le route precedenti
            );
          },
          child: const Text(
            'BLOND',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                letterSpacing: 10,
                color: Colors.black),
          ),
        ),
        automaticallyImplyLeading:
            false, // Disabilita il pulsante di ritorno automatico
        actions: [
          IconButton(
            onPressed: () {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _showPopupMenu(context);
              });
            },
            icon: const Icon(Icons.dehaze_outlined, color: Colors.black),
          ),
        ],
      ),
      body: RawKeyboardListener(
        focusNode: _focusNode,
        onKey: _handleKeyboardEvent,
        child: Stack(
          children: [
            PageView(
              controller: _pageController,
              children: _imagePaths.map((path) => Image.asset(path)).toList(),
            ),
            Positioned(
              left: 0,
              top: MediaQuery.of(context).size.height / 2 - 30,
              child: IconButton(
                icon: Icon(Icons.arrow_left, color: Colors.black),
                onPressed: () {
                  _pageController.previousPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ),
            Positioned(
              right: 0,
              top: MediaQuery.of(context).size.height / 2 - 30,
              child: IconButton(
                icon: Icon(Icons.arrow_right, color: Colors.black),
                onPressed: () {
                  _pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: _buildPaginationDots(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _showPopupMenu(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black.withOpacity(0.5),
            child: GestureDetector(
              onTap: () {},
              child: Center(
                child: MenuItems(),
              ),
            ),
          ),
        ),
      );
    },
  );
}

class MenuItems extends StatefulWidget {
  @override
  _MenuItemsState createState() => _MenuItemsState();
}

class _MenuItemsState extends State<MenuItems> {
  bool _showItem1 = false;
  bool _showItem2 = false;
  bool _showItem3 = false;

  @override
  void initState() {
    super.initState();
    _showItems();
  }

  void _showItems() async {
    await Future.delayed(const Duration(seconds: 0));
    if (mounted) {
      setState(() {
        _showItem1 = true;
      });
    }
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() {
        _showItem2 = true;
      });
    }
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() {
        _showItem3 = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.1,
      padding: const EdgeInsets.all(20),
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedOpacity(
            opacity: _showItem1 ? 1.0 : 0.0,
            duration: const Duration(seconds: 1),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/studio');
                },
                child: const Text(
                  'Studio',
                  style:
                      TextStyle(fontFamily: 'RobotoMono', color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          AnimatedOpacity(
            opacity: _showItem2 ? 1.0 : 0.0,
            duration: const Duration(seconds: 1),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/eventi');
                },
                child: const Text(
                  'Eventi',
                  style:
                      TextStyle(fontFamily: 'RobotoMono', color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          AnimatedOpacity(
            opacity: _showItem3 ? 1.0 : 0.0,
            duration: const Duration(seconds: 1),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/contatti');
                },
                child: const Text(
                  'Contatti',
                  style:
                      TextStyle(fontFamily: 'RobotoMono', color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
