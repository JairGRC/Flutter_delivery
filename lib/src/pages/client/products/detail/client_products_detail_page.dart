@override
Widget build(BuildContext context) {
  Return Container(
      Height: MediaQuery.of(context).size.height*0.9
  Child: Column(
    Children: [
      imageSlideshow()
    ],
  ),
  );
}


Widget imageSlideShow() {
  Return ImageSlideshow(


      width: double.infinity,
      height: MediaQuery.of(context).size.height*0.4,

  initialPage: 0,

  indicatorColor: MyColors.primaryColor,

  indicatorBackgroundColor: Colors.grey,
  children: [
  FadeInImage(
  image: product.image1 != null
  ? NetworkImage(product.image1)
      : AssetImage('assets/img/pizza2.png'),
  fit: BoxFit.contain,
  fadeInDuration: Duration(milliseconds: 50),
  placeholder: AssetImage('assets/img/no-image.png'),
  ),
  Image.asset(
  'images/sample_image_2.jpg',
  fit: BoxFit.cover,
  ),
  Image.asset(
  'images/sample_image_3.jpg',
  fit: BoxFit.cover,
  ),
  ],


  onPageChanged: (value) {
  print('Page changed: $value');
  },
  autoPlayInterval: 3000,

  isLoop: true,
  );
}
