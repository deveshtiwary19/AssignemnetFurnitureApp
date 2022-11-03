import 'package:assignment/config/size_config.dart';
import 'package:assignment/config/ui_constants.dart';
import 'package:assignment/ui/home_screen/home_vm.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => HomeViewModel(),
        onModelReady: (viewModel) => viewModel.init(),
        builder: (context, viewModel, child) {
          return Scaffold(
            backgroundColor: UiConstants.mainColor,
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: UiConstants.mainColor,
              title: const Text(
                "DashBoard",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: SizeConfig.padding12),
                  child: const Icon(
                    Icons.notifications_outlined,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _SearchBar(),
                _TabsBuilder(
                  viewModel: viewModel,
                ),
                Expanded(
                  child: Stack(children: [
                    Container(
                      margin:
                          EdgeInsets.only(top: SizeConfig.screenWidth * 0.2),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft:
                                  Radius.circular(SizeConfig.roundness56))),
                    ),
                    (viewModel.productsToShow.isEmpty)
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : _ProductsList(
                            viewModel: viewModel,
                          )
                  ]),
                )
              ],
            ),
          );
        });
  }
}

//Renders the products list according to the category
class _ProductsList extends StatelessWidget {
  _ProductsList({
    required this.viewModel,
    Key? key,
  }) : super(key: key);

  HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: viewModel.productsToShow.length,
      itemBuilder: (ctx, i) {
        return GestureDetector(
          onTap: (() => viewModel.navigateToDetailsPage(
              context, viewModel.productsToShow[i])),
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              Container(
                height: SizeConfig.screenWidth * 0.35,
                decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(color: Colors.black26, blurRadius: 4.0)
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                        Radius.circular(SizeConfig.roundness32))),
                margin: EdgeInsets.all(SizeConfig.pageHorizontalMargins),
                child: Row(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: SizeConfig.padding24,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: SizeConfig.padding12),
                          child: Text(
                            viewModel.productsToShow[i].name,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: SizeConfig.body2),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.padding28,
                              vertical: SizeConfig.padding14),
                          decoration: BoxDecoration(
                              color: UiConstants.primaryColor,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(
                                    SizeConfig.roundness32,
                                  ),
                                  topRight: Radius.circular(
                                    SizeConfig.roundness24,
                                  ))),
                          child: Text(
                            "\$ ${viewModel.productsToShow[i].price}",
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    bottom: SizeConfig.pageHorizontalMargins,
                    right: SizeConfig.padding54),
                child: Image.network(
                  viewModel.productsToShow[i].variants[0].url,
                  width: SizeConfig.screenWidth * 0.4,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

//Renders the tabs for categories
class _TabsBuilder extends StatelessWidget {
  _TabsBuilder({
    required this.viewModel,
    Key? key,
  }) : super(key: key);

  HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.padding64,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: viewModel.options.length,
        itemBuilder: (context, index) {
          return Center(
            child: GestureDetector(
              onTap: () {
                viewModel.changeCategory(viewModel.options[index]);
              },
              child: Container(
                margin: EdgeInsets.only(
                  left: index == 0
                      ? SizeConfig.pageHorizontalMargins
                      : SizeConfig.padding10,
                  right: index == viewModel.options.length
                      ? SizeConfig.pageHorizontalMargins
                      : SizeConfig.padding10,
                ),
                padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.padding10,
                    horizontal: SizeConfig.padding16),
                decoration: BoxDecoration(
                  color: viewModel.currentCategory == viewModel.options[index]
                      ? Colors.white.withOpacity(0.4)
                      : Colors.transparent,
                  borderRadius:
                      BorderRadius.all(Radius.circular(SizeConfig.roundness12)),
                ),
                child: Text(
                  viewModel.options[index],
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

//Renders the serah bar at the etop
class _SearchBar extends StatelessWidget {
  const _SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          SizeConfig.pageHorizontalMargins,
          SizeConfig.padding24,
          SizeConfig.pageHorizontalMargins,
          SizeConfig.padding12),
      padding: EdgeInsets.all(SizeConfig.padding16),
      width: SizeConfig.screenWidth,
      height: SizeConfig.padding54,
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.4),
          borderRadius:
              BorderRadius.all(Radius.circular(SizeConfig.roundness16))),
      child: Row(
        children: [
          const Icon(
            Icons.search_sharp,
            color: Colors.white,
          ),
          SizedBox(
            width: SizeConfig.padding16,
          ),
          const Text(
            "Search",
            style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }
}
