import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': _enUS,
        'pt_BR': _ptBR,
      };

  static const Map<String, String> _enUS = {
    // Exercise 1
    'loading_file': 'Loading File',

    // Exercise 2
    'heres_your_landing_page': "Here's your landing page:",
    'landing_page_title': 'Form&Fun Landing Page',
    'landing_page_subtitle': 'HTML',
    'view_button': 'View',
    'press_back_again': 'Press back again to exit',
    'could_not_open_website': 'Could not open the website',
    'error_opening_link': 'An error occurred while opening the link',

    // Footer
    'footer_title': 'Form&Fun',
    'footer_subtitle': 'formandfun.co',

    // Lorem ipsum (mantém original)
    'long_description': '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras at odio quam. Etiam sed lorem id ligula egestas ornare non ac mauris. Proin non sagittis justo. Sed id viverra est. Integer enim sem, scelerisque vitae tristique sit amet, ullamcorper vel arcu. Nullam mollis posuere turpis, ac dignissim quam sodales eget. Aenean congue fringilla pretium. Morbi volutpat fringilla luctus. Donec et ligula sit amet mauris sodales tristique a ac quam. Donec vel libero a libero laoreet eleifend a ut nisi. Donec ut sem in orci gravida mattis eget ut nibh. Ut faucibus sollicitudin magna, ac sollicitudin ex tristique at.

Pellentesque vehicula nisl et augue commodo, id bibendum urna tristique. Morbi in malesuada libero. Nullam rhoncus ex quis urna fringilla euismod vel imperdiet justo. Quisque condimentum cursus facilisis. Donec ex sem, efficitur sed sagittis ac, accumsan mattis libero. Pellentesque vulputate eget odio vel convallis. Proin malesuada pulvinar felis, sed lobortis sem porttitor ac. Vivamus molestie vehicula orci, efficitur rutrum nulla semper ac. Phasellus ut ligula tortor. In augue est, elementum a sodales eu, sodales id lectus. Sed ac luctus leo. Nullam a nulla pellentesque, scelerisque dolor in, mattis turpis.''',
  };

  static const Map<String, String> _ptBR = {
    // Exercise 1
    'loading_file': 'Carregando Arquivo',

    // Exercise 2
    'heres_your_landing_page': 'Aqui está sua landing page:',
    'landing_page_title': 'Landing Page Form&Fun',
    'landing_page_subtitle': 'HTML',
    'view_button': 'Ver',
    'press_back_again': 'Pressione voltar novamente para sair',
    'could_not_open_website': 'Não foi possível abrir o site',
    'error_opening_link': 'Ocorreu um erro ao abrir o link',

    // Footer
    'footer_title': 'Form&Fun',
    'footer_subtitle': 'formandfun.co',

    // Lorem ipsum (mantém original)
    'long_description': '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras at odio quam. Etiam sed lorem id ligula egestas ornare non ac mauris. Proin non sagittis justo. Sed id viverra est. Integer enim sem, scelerisque vitae tristique sit amet, ullamcorper vel arcu. Nullam mollis posuere turpis, ac dignissim quam sodales eget. Aenean congue fringilla pretium. Morbi volutpat fringilla luctus. Donec et ligula sit amet mauris sodales tristique a ac quam. Donec vel libero a libero laoreet eleifend a ut nisi. Donec ut sem in orci gravida mattis eget ut nibh. Ut faucibus sollicitudin magna, ac sollicitudin ex tristique at.

Pellentesque vehicula nisl et augue commodo, id bibendum urna tristique. Morbi in malesuada libero. Nullam rhoncus ex quis urna fringilla euismod vel imperdiet justo. Quisque condimentum cursus facilisis. Donec ex sem, efficitur sed sagittis ac, accumsan mattis libero. Pellentesque vulputate eget odio vel convallis. Proin malesuada pulvinar felis, sed lobortis sem porttitor ac. Vivamus molestie vehicula orci, efficitur rutrum nulla semper ac. Phasellus ut ligula tortor. In augue est, elementum a sodales eu, sodales id lectus. Sed ac luctus leo. Nullam a nulla pellentesque, scelerisque dolor in, mattis turpis.''',
  };
}

/// Extension para facilitar acesso às traduções
extension TranslationKeys on String {
  String get tr => TranslationKeys(this).tr;
}
