import 'package:flutter/material.dart';
import 'studio_page.dart';

class PreviewPage extends StatelessWidget {
  final String imagePath;

  PreviewPage({required this.imagePath});

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
      body: Stack(
        children: [
          // Posiziona l'anteprima dell'immagine
          Positioned(
            top: 20,
            left: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StudioPage()),
                );
              },
              child: Image.asset(
                imagePath,
                width: 200, // Dimensioni dell'anteprima
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Posiziona il titolo sotto l'anteprima
          const Positioned(
            top:
                230, // Adatta questo valore per posizionare il titolo sotto l'immagine
            left: 20,
            child: Text(
              'GLITZ CLUB',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
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
