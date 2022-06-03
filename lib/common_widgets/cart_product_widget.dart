import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:salesforce_spo/design_system/design_system.dart';

class CartProductWidget extends StatelessWidget {
  final String productName;
  final double productPrice;
  final String productImage;
  const CartProductWidget({
    Key? key,
    required this.productName,
    required this.productPrice,
    required this.productImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(15),
            color: ColorSystem.culturedGrey,
          ),
          child: SizedBox(
            width: 150,
            height: 150,
            child: CachedNetworkImage(
              imageUrl: productImage,
            ),
          ),
        ),
        const SizedBox(
          height: SizeSystem.size5,
        ),
        SizedBox(
          width: 150,
          child: Text(
            productName,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: SizeSystem.size12,
              color: ColorSystem.primaryTextColor,
            ),
          ),
        ),
        const SizedBox(
          height: SizeSystem.size8,
        ),
        Text(
          productPrice.toString(),
          style: const TextStyle(
            fontSize: SizeSystem.size12,
            color: ColorSystem.primaryTextColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
