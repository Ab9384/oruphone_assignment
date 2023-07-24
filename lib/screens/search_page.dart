import 'package:assignment/functions/helper_methods.dart';
import 'package:assignment/utils/app_provider.dart';
import 'package:assignment/widgets/custom_child_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/app_colors.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Image.asset(
            'images/menu.png',
            color: AppColors.backgroundColor,
            height: 30,
          ),
          onPressed: () {},
        ),
        title: Image.asset(
          'images/app_icon.png',
          height: 35,
        ),
        centerTitle: false,
        actions: [
          // location icon with country name
          Row(
            children: [
              const Text(
                'India',
                style: TextStyle(
                  color: AppColors.backgroundColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.location_on,
                  color: AppColors.backgroundColor,
                  size: 25,
                ),
                onPressed: () {},
              ),
            ],
          ),

          Stack(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.notifications_none_outlined,
                  color: AppColors.backgroundColor,
                  size: 30,
                ),
                onPressed: () {},
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  height: 15,
                  width: 15,
                  decoration: BoxDecoration(
                    color: AppColors.backgroundColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      '2',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
          child: Column(
        children: [
          Container(
            height: 70,
            color: AppColors.primaryColor,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColors.primaryColor,
                  width: 1,
                ),
              ),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  if (value.length > 2) {
                    HelperMethods.getSearchResponse(context, value);
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Search for products, brands and more',
                  hintStyle: const TextStyle(
                    color: AppColors.secondaryTextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    onPressed: () {
                      searchController.clear();
                      Provider.of<AppProvider>(context, listen: false)
                          .updateSearchResponse(null);
                    },
                    icon: const Icon(
                      Icons.close,
                      color: AppColors.secondaryTextColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: CustomChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Visibility(
                        visible:
                            (Provider.of<AppProvider>(context).searchResponse !=
                                    null) &&
                                Provider.of<AppProvider>(context)
                                    .searchResponse!
                                    .makes!
                                    .isNotEmpty,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Brands',
                              style: TextStyle(
                                  color: AppColors.textColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: Provider.of<AppProvider>(context)
                                      .searchResponse
                                      ?.makes
                                      ?.length ??
                                  0,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(
                                    Provider.of<AppProvider>(context)
                                            .searchResponse
                                            ?.makes?[index] ??
                                        '',
                                    style: const TextStyle(
                                      color: AppColors.secondaryTextColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible:
                            (Provider.of<AppProvider>(context).searchResponse !=
                                    null) &&
                                Provider.of<AppProvider>(context)
                                    .searchResponse!
                                    .models!
                                    .isNotEmpty,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Models',
                              style: TextStyle(
                                  color: AppColors.textColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: Provider.of<AppProvider>(context)
                                      .searchResponse
                                      ?.models
                                      ?.length ??
                                  0,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(
                                    Provider.of<AppProvider>(context)
                                            .searchResponse
                                            ?.models?[index] ??
                                        '',
                                    style: const TextStyle(
                                      color: AppColors.secondaryTextColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ]),
              ),
            ),
          )
        ],
      )),
    );
  }
}
