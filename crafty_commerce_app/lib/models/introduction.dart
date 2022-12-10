class Introduction {
  String title;
  String imagePath;
  String description;
  Introduction({
    required this.title,
    required this.imagePath,
    required this.description,
  });
}

List<Introduction> introductionContents = [
  Introduction(
    title: 'Welcome to\n Crafty Commerce',
    imagePath: 'assets/images/logo crafty.png',
    description:
        'We provide quality products for customer first priority policy',
  ),
  Introduction(
    title: 'Get any things online',
    imagePath: 'assets/images/firstScreen.png',
    description:
        'You can buy anything ranging from digital products to hardware with in few steps !',
  ),
  Introduction(
    title: 'Shipping to anywhare',
    imagePath: 'assets/images/secondScreen.png',
    description:
        'We will ship to anywhare in the bangladesh with in 5 working days and 100% money back policy.',
  ),
  Introduction(
    title: 'On-time delivery',
    imagePath: 'assets/images/thirdScreen.png',
    description:
        'You can track your product with our powerfull traking service.',
  ),
];
