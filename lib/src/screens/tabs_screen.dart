import 'package:flutter/material.dart';
import 'package:newsapp/src/screens/tab1_screen.dart';
import 'package:newsapp/src/screens/tab2_screen.dart';
import 'package:newsapp/src/services/news_service.dart';
import 'package:provider/provider.dart';

class TabsScreen extends StatelessWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NavegacionModel(),
      child: const Scaffold(
        body: _Paginas(),
        bottomNavigationBar: _Navegacion(),
      ),
    );
  }
}

class _Navegacion extends StatelessWidget {
  const _Navegacion({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);
    return BottomNavigationBar(
      currentIndex: navegacionModel.paginaActual,
      onTap: (index) {
        navegacionModel.paginaActual = index;
        final newsService = Provider.of<NewsService>(context, listen: false);
        newsService.selectedCategory = newsService.selectedCategory;
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Para Ti',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.public),
          label: 'Encabezados',
        ),
      ],
    );
  }
}

class _Paginas extends StatelessWidget {
  const _Paginas({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);
    return PageView(
      controller: navegacionModel.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        Tab1Screen(),
        Tab2Screen(),
      ],
    );
  }
}

class _NavegacionModel extends ChangeNotifier {
  int _paginaActual = 0;
  final PageController _pageController = PageController();

  int get paginaActual => _paginaActual;
  set paginaActual(int valor) {
    _paginaActual = valor;
    _pageController.animateToPage(valor,
        duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
    notifyListeners();
  }

  PageController get pageController => _pageController;
}
