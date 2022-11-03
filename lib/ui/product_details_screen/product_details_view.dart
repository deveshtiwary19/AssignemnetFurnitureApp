import 'dart:ffi';

import 'package:assignment/config/size_config.dart';
import 'package:assignment/config/ui_constants.dart';
import 'package:assignment/model/response_model.dart';
import 'package:assignment/ui/product_details_screen/product_details_vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stacked/stacked.dart';

class ProductDetailsView extends StatelessWidget {
  ProductDetailsView({required this.response, super.key});

  Response response;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductDetailsViewModel>.reactive(
      viewModelBuilder: () => ProductDetailsViewModel(),
      onModelReady: (viewModel) => viewModel.init(response),
      builder: ((context, viewModel, child) {
        return Scaffold(
          backgroundColor: UiConstants.mainColor,
          appBar: AppBar(
            elevation: 0.0,
            titleSpacing: 0,
            backgroundColor: Colors.white,
            title: Text(
              "BACK",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: SizeConfig.body3),
            ),
            leading: IconButton(
              onPressed: () {
                if (Navigator.canPop(context)) Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
            actions: [
              Padding(
                padding:
                    EdgeInsets.only(right: SizeConfig.pageHorizontalMargins),
                child: const Icon(
                  Icons.shopping_bag_outlined,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: Container(
                  width: SizeConfig.screenWidth,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(SizeConfig.roundness32),
                          bottomRight:
                              Radius.circular(SizeConfig.roundness32))),
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.network(
                          viewModel.currentImage,
                          width: SizeConfig.screenWidth,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: SizeConfig.pageHorizontalMargins,
                            vertical: SizeConfig.pageHorizontalMargins +
                                SizeConfig.padding12),
                        height: SizeConfig.padding32,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: response.variants.length,
                          itemBuilder: ((context, index) {
                            return GestureDetector(
                              onTap: () => viewModel.changeImageToShow(
                                  response.variants[index].url),
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: SizeConfig.padding10),
                                width: SizeConfig.padding20,
                                height: SizeConfig.padding20,
                                decoration: BoxDecoration(
                                    color: Color(int.parse(
                                        response.variants[index].color)),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.grey.withOpacity(0.5),
                                        width: 2.0)),
                              ),
                            );
                          }),
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.all(SizeConfig.pageHorizontalMargins),
                        child: Column(
                          children: [
                            SizedBox(
                              width: SizeConfig.screenWidth,
                              child: Text(
                                response.name,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: SizeConfig.title4),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.pageHorizontalMargins,
                            ),
                            SizedBox(
                              width: SizeConfig.screenWidth,
                              child: Text(
                                "\$ ${response.price}",
                                style: TextStyle(
                                    color: UiConstants.mainColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: SizeConfig.body1),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.pageHorizontalMargins,
                            ),
                            SizedBox(
                              width: SizeConfig.screenWidth,
                              child: Text(
                                response.about,
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.6),
                                    fontWeight: FontWeight.normal,
                                    fontSize: SizeConfig.body4),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.pageHorizontalMargins,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              _BottomOptionBar()
            ],
          ),
        );
      }),
    );
  }
}

//Widget to render the diffrent options on th bottom
class _BottomOptionBar extends StatelessWidget {
  const _BottomOptionBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: SizeConfig.pageHorizontalMargins),
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenWidth * 0.15,
      margin: EdgeInsets.symmetric(
        horizontal: SizeConfig.pageHorizontalMargins + SizeConfig.padding10,
        vertical: SizeConfig.pageHorizontalMargins + SizeConfig.padding12,
      ),
      decoration: BoxDecoration(
          color: UiConstants.secondaryColor,
          borderRadius:
              BorderRadius.all(Radius.circular(SizeConfig.roundness56))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                Icons.local_offer_outlined,
                color: Colors.white,
              ),
              SizedBox(
                width: SizeConfig.padding10,
              ),
              const Text(
                "Offers",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
          Row(
            children: [
              const Icon(
                Icons.shopping_bag_outlined,
                color: Colors.white,
              ),
              SizedBox(
                width: SizeConfig.padding10,
              ),
              const Text(
                "Add to cart",
                style: TextStyle(color: Colors.white),
              )
            ],
          )
        ],
      ),
    );
  }
}
