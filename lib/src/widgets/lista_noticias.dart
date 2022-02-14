import 'package:flutter/material.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:newsapp/src/theme/tema.dart';

class ListaNoticias extends StatelessWidget {
  
  final List<Article> noticias;

  const ListaNoticias({Key? key, required this.noticias}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: noticias.length,
      itemBuilder: (BuildContext context, int index){
        return _Noticias(noticia: noticias[index], index: index,);
      },
    );
  }
}

class _Noticias extends StatelessWidget {

  final Article noticia;
  final int index;

  const _Noticias({Key? key, required this.noticia, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TarjetaTopBar(noticia: noticia, index: index,),
        _TarjetaTitulo(noticia: noticia,),
        _TarjetaImagen(noticia: noticia,),
        _TarjetaBody(noticia: noticia,),
        _TarjetaBotones(),
      ],
    );
  }
}

class _TarjetaTopBar extends StatelessWidget {
  
  final Article noticia;
  final int index; 
  const _TarjetaTopBar({Key? key, required this.noticia, required this.index, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text('${index + 1}. ', style: TextStyle(color: miTema.colorScheme.secondary, fontSize: 20),),
          Text('${ noticia.source.name }.', style: const TextStyle(fontSize: 20),)
        ],
      ),
    );
      
  }
}


class _TarjetaTitulo extends StatelessWidget {

  final Article noticia;
  const _TarjetaTitulo({Key? key, required this.noticia}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(noticia.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
    );
  }
}

class _TarjetaImagen extends StatelessWidget {

  final Article noticia;

  const _TarjetaImagen({Key? key, required this.noticia}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: (noticia.urlToImage != null) 
        ? FadeInImage(
          placeholder: const AssetImage( 'assets/giphy.gif' ),
          image: NetworkImage( noticia.urlToImage! ),
        )
        : const Image(image: AssetImage('assets/no-image.png')),
      ),
    );
  }
}

class _TarjetaBody extends StatelessWidget {

  final Article noticia;
  const _TarjetaBody({Key? key, required this.noticia}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.only(bottom: 10),
      child: Text( (noticia.description != null) ? noticia.description! : '' ),
    );
  }
}

class _TarjetaBotones extends StatelessWidget {

  const _TarjetaBotones({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RawMaterialButton(
          onPressed: (){},
          fillColor: miTema.colorScheme.secondary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: const Icon(Icons.star_border),
        ),
        const SizedBox(width: 20,),
        RawMaterialButton(
          onPressed: (){},
          fillColor: Colors.blue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: const Icon(Icons.more_horiz),
        ),
        const SizedBox(height: 20,)
      ],
    );
  }
}