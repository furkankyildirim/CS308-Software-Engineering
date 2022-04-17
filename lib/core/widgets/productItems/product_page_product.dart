import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile/core/init/theme/color_theme.dart';
import 'package:mobile/core/widgets/customScrollPhysics.dart';

class PageProduct extends StatelessWidget {
  const PageProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [_content(), _infos(), Container()],
          
        ),
      )
    );
  }
  SizedBox _content() {
    return SizedBox(
      child: Stack(children: [
        _image(),
        Container(
          alignment: Alignment.topRight,
          padding: const EdgeInsets.all(6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: 24),
              _favoriteButton(),
              const SizedBox(height: 24),
              _shoppingCartButton(),
              const SizedBox(height: 230),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _decrementButton(),
                  const SizedBox(width: 8),
                  _cartCounter(),
                  const SizedBox(width: 8),
                  _incrementButton(),
                ],
              ),
            ],
          ),
        )
      ]),
    );
  }

  Expanded _image() {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: CachedNetworkImage(
          imageUrl:
          "http://employee-self-service.de/wp-content/themes/dante/images/default-thumb.png",
          width: double.infinity,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  ClipRRect _smallImage() => ClipRRect(
    borderRadius: const BorderRadius.all(Radius.circular(8)),
    child: CachedNetworkImage(
      imageUrl:
      "http://employee-self-service.de/wp-content/themes/dante/images/default-thumb.png",
      width: 100,
      height: 100,
      fit: BoxFit.fill,
    ),
  );

  InkWell _favoriteButton() => InkWell(
    onTap: (() {
      debugPrint("Favorite Button Clicked...");
    }),
    child: Container(
      height: 28,
      width: 28,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(14)),
        color: AppColors.white,
      ),
      child: const Icon(
        Icons.star_border_rounded,
        size: 16,
      ),
    ),
  );

  InkWell _shoppingCartButton() => InkWell(
    onTap: (() {
      debugPrint("Shopping Cart Button Clicked...");
    }),
    child: Container(
      height: 28,
      width: 28,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(13)),
        color: AppColors.primary,
      ),
      child: const Icon(
        Icons.add_shopping_cart_outlined,
        color: AppColors.white,
        size: 12,
      ),
    ),
  );

  SizedBox _infos() => SizedBox(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [_title(), _price()],
          ),
          _itemNo(),
          _producer(),
          _descriptionTitle(),
          _description(),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Similar Item",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.tertiary,
              fontSize: 18,
            ),
          ),
          _similar(),
        ],
      ),
    ),
  );

  Text _title() => const Text(
    "Wing Chair",
    textAlign: TextAlign.start,
    style: TextStyle(
      color: AppColors.tertiary,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),
  );

  Text _itemNo() => const Text(
    "Item: 309",
    textAlign: TextAlign.start,
    style: TextStyle(
      color: AppColors.tertiary,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ),
  );

  Text _producer() => const Text(
    "Goal Design",
    textAlign: TextAlign.start,
    style: TextStyle(
      color: AppColors.darkGray,
      fontWeight: FontWeight.w200,
      fontSize: 12,
    ),
  );

  Text _price() => const Text(
    "380₺",
    textAlign: TextAlign.start,
    style: TextStyle(
      color: AppColors.primary,
      fontWeight: FontWeight.w900,
      fontSize: 22,
    ),
  );

  InkWell _decrementButton(){
    return InkWell(
      onTap: (){
        debugPrint("Decrement button clicked...");
      },
      child: Container(
        height: 32,
        width: 32,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          color: AppColors.secondary,
        ),
        child: const Icon(
          Icons.remove,
          size: 16,
        ),
      ),
    );
  }
  InkWell _incrementButton() {
    return InkWell(
      onTap: () {
        debugPrint("Increment button clicked...");
      },
      child: Container(
        height: 32,
        width: 32,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          color: AppColors.primary,
        ),
        child: const Icon(
          Icons.add,
          size: 16,
        ),
      ),
    );
  }

  Text _cartCounter() => Text(
    "1",
    style: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: AppColors.white,
    ),
  );

  Row _descriptionTitle() => Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: const [
      SizedBox(
        height: 50,
      ),
         Text(
        "Description",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.tertiary,
          fontSize: 18,
        ),
      ),
    ],
  );

  Row _description() => Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      const SizedBox(
        height: 10,
      ),
      Flexible(
          child: Text(
            "People have been using natural objects, such as tree stumps, rocks and moss, as furniture since the beginning of human civilisation. Archaeological research.",
            style: TextStyle(
              color: AppColors.darkGray,
              fontWeight: FontWeight.w200,
              fontSize: 14,
            ),
          ))
    ],
  );

  SizedBox _similarItem() {
    return SizedBox(
      width: 1000,
      height: 100,
      child: ListView.builder(
        primary: true,
        scrollDirection: Axis.horizontal,
        physics: const CustomScrollPhysics(itemDimension: 120),
        itemCount: 5,
        itemBuilder: (context, index) => _similar(),
      ),
    );
  }

  Padding _similar() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: SizedBox(
      width: 100,
      child: Stack(children: [
        _smallImage(),
      ]),
    ),
  );

}

OutlinedButton addToCart() => OutlinedButton(
  onPressed: (){
    debugPrint("Add to cart button pressed...");
  },
  child: Text(
    "Add To Cart",
    style: TextStyle(
      color: AppColors.white,
      fontSize: 14,
      fontWeight: FontWeight.w700,
    ),
  ),
  style: OutlinedButton.styleFrom(
    primary: AppColors.primary,
    fixedSize: Size(150, 50),
    side: BorderSide(width: 1.0, color: AppColors.white)
  ),
);

OutlinedButton buyNow() => OutlinedButton(
  onPressed: (){
    debugPrint("Buy now button pressed...");
  },
  child: Text(
    "Buy Now",
    style: TextStyle(
      color: AppColors.black,
      fontSize: 14,
      fontWeight: FontWeight.w700,
    ),
  ),
  style: OutlinedButton.styleFrom(
    backgroundColor: AppColors.white,
      primary: AppColors.white,
      fixedSize: Size(150, 50),
      side: BorderSide(width: 1.0, color: AppColors.white)
  ),
);
