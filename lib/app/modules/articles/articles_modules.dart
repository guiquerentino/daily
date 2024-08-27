import 'package:daily/app/modules/articles/pages/articles_page.dart';
import 'package:daily/app/modules/articles/pages/detailed_article_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ArticlesModule extends Module{

  @override
  void binds(Injector i) {}

  @override
  void routes(r) {
    r.child(Modular.initialRoute, child: (context) => ArticlesPage());
    r.child('/details', child: (context) => DetailedArticlePage(article: r.args.data, isFromList: r.args.queryParams['isFromList'] == 'true'));
  }

}