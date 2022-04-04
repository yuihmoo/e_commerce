/*
 * Copyright 2018 Eric Windmill. All rights reserved.
 * Use of this source code is governed by the MIT license that can be found in the LICENSE file.
 */

import 'package:e_commerce/blocs/app_state.dart';
import 'package:e_commerce/blocs/cart_bloc.dart';
import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;

  const ProductDetailPage({Key key, this.product}) : super(key: key);

  @override
  ProductDetailPageState createState() {
    return ProductDetailPageState();
  }
}

class ProductDetailPageState extends State<ProductDetailPage> {
  int _quantity = 0;

  @override
  Widget build(BuildContext context) {
    var _cartBloc = AppStateContainer.of(context).blocProvider.cartBloc;

    return Stack(
      children: <Widget>[
        Positioned(
          bottom: 100.0,
          left: 20.0, // half of the "padding" we added in the containers width
          child: Container(
            padding: EdgeInsets.all(Spacing.matGridUnit(scale: 3)),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25.0),
                boxShadow: [
                  BoxShadow(color: Colors.black26, offset: Offset(1.0, 1.0), blurRadius: 1.0),
                ]),
            width: MediaQuery.of(context).size.width - 10.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  fit: FlexFit.loose,
                  child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.product.title,
                          textScaleFactor: 0.5, // 크기 넘침으로 인해 추가
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              .copyWith(color: AppColors.displayTextColor),
                        ),
                        Text(
                          widget.product.category.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Text(
                      '\$ ${widget.product.cost} / lb',
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(color: AppColors.displayTextColor),
                    ),
                  ],
                ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: Spacing.matGridUnit(scale: 2)),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: Hero(
                          tag: widget.product.uniqueId,
                          child: Image.asset(widget.product.imageUrl),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                              'This is a nice ${widget.product.title} thing you can buy and eat to grow strong.'),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        if (_quantity > 0) {
                          setState(() => _quantity--);
                        }
                      },
                      icon: Icon(Icons.remove),
                    ),
                    Text(
                      _quantity.toString(),
                      style: Theme.of(context).primaryTextTheme.headline6,
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() => _quantity++);
                      },
                      icon: Icon(Icons.add),
                    ),
                    RaisedButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
                      onPressed: () =>
                          _cartBloc.addProductSink.add(AddToCartEvent(widget.product, _quantity)),
                      textColor: Colors.white,
                      child: Text('Add to Cart'),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
