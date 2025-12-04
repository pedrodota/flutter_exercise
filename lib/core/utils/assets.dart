const String base = 'assets';
const String baseFonts = '$base/fonts';
const String baseImages = '$base/images';
const String baseSvg = '$base/svg';
const String baseAnimations = '$base/animations';

String font(String name) => '$baseFonts/$name.ttf';
String image(String name) => '$baseImages/$name.png';
String svg(String name) => '$baseSvg/$name.svg';
String animation(String name) => '$baseAnimations/$name.json';

// Images
final ffLogo = image('ff_logo');
final ffWebsite = image('ff_website');

// SVG
final iconHtml = svg('icon_html');
final tagsIcon = svg('tags_icon');

// Animations (Lottie)
final searchingAnimation = animation('searching');
final formAndFunAnimation = animation('formAndFun_lottie');
