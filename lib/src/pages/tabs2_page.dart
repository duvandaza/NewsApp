import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:newsapp/src/models/category_model.dart';
import 'package:newsapp/src/services/news_service.dart';
import 'package:newsapp/src/theme/tema.dart';
import 'package:newsapp/src/widgets/lista_noticias.dart';

class Tab2Page extends StatelessWidget {
  const Tab2Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final newsService = Provider.of<NewsService>(context);
    
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            _ListaCategorias(),
            Expanded(
              child: ListaNoticias(noticias: newsService.getListaArticuloSeleccionado!),
            )
          ],
        ),
      ),
    );
  }
}

class _ListaCategorias extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final categories = Provider.of<NewsService>(context).categories;

    return SizedBox(
      width: double.infinity,
      height: 80,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {

          final cName = categories[index].name;

          return Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                _CategoryButton(categoria: categories[index]),
                const SizedBox(height: 5,),
                Text('${cName[0].toUpperCase()}${cName.substring(1)} ')
              ],
            ), 
          );
        },
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  
  final Category categoria;

  const _CategoryButton({Key? key, required this.categoria}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final newsService = Provider.of<NewsService>(context, listen: false);

    return GestureDetector(
      onTap: (){
        newsService.selectedCategory = categoria.name;
      },
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Icon(categoria.icon,
         color: ( newsService.selectedCategory == categoria.name  ) 
         ? miTema.colorScheme.secondary
         : Colors.black87,
        ),
      ),
    );
  }
}