import 'package:assignment/functions/helper_methods.dart';
import 'package:assignment/screens/notification_screen.dart';
import 'package:assignment/screens/search_page.dart';
import 'package:assignment/utils/app_colors.dart';
import 'package:assignment/utils/global_variable.dart';
import 'package:assignment/widgets/carousel_widget.dart';
import 'package:assignment/widgets/custom_child_scrollview.dart';
import 'package:assignment/widgets/custom_child_scrollview_horizontal.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../functions/push_notification_service.dart';
import '../utils/app_provider.dart';
import '../widgets/brand_icon.dart';
import '../widgets/filter_tile.dart';
import '../widgets/phone_view_widget.dart';
import '../widgets/shop_by_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CarouselController carouselController = CarouselController();
  double currentCarouselIndex = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      PushNotification.initialize(context);
      await HelperMethods.getFilters();
      // ignore: use_build_context_synchronously
      await HelperMethods.getDeviceList(context);
    });
    super.initState();
  }

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
                onPressed: () {
                  HelperMethods.navigateTo(
                      context, const NotificationScreen(), 1);
                },
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // search bar
          GestureDetector(
            onTap: () {
              HelperMethods.navigateTo(context, SearchPage(), 1);
            },
            child: Container(
              height: 70,
              color: AppColors.primaryColor,
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppColors.primaryColor,
                    width: 1,
                  ),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: AppColors.secondaryColor,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Search woth make and model ...',
                        style: TextStyle(
                          color: AppColors.secondaryTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
              child: CustomChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text('Buy Top Brands',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: AppColors.secondaryTextColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                const CustomChildScrollViewHorizontal(
                    child: Row(
                  children: [
                    SizedBox(width: 15),
                    BrandIcon(brandName: 'apple-logo'),
                    SizedBox(width: 15),
                    BrandIcon(brandName: 'samsung'),
                    SizedBox(width: 15),
                    BrandIcon(brandName: 'xiaomi'),
                    SizedBox(width: 15),
                    BrandIcon(brandName: 'vivo'),
                    SizedBox(width: 15),
                  ],
                )),
                const SizedBox(height: 20),
                CarouselSlider(
                    items: // list of widget to be displayed in carousal
                        List.generate(
                      5,
                      (index) => const CarouselWidget(),
                    ),
                    carouselController: carouselController,
                    options: CarouselOptions(
                      height: 200,
                      aspectRatio: 16 / 9,
                      viewportFraction: 1,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      enlargeFactor: 0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          currentCarouselIndex = index.toDouble();
                        });
                      },
                      // onScrolled: (value) {
                      //   setState(() {
                      //     currentCarouselIndex = value!;
                      //   });
                      // },
                      scrollDirection: Axis.horizontal,
                    )),
                const SizedBox(height: 10),
                // dots for carousel
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    5,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      height: 8,
                      width: currentCarouselIndex == index ? 20 : 8,
                      decoration: BoxDecoration(
                        color: currentCarouselIndex == index
                            ? AppColors.primaryColor
                            : AppColors.secondaryTextColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 0),
                const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text('Shop by',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: AppColors.secondaryTextColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                const CustomChildScrollViewHorizontal(
                  child: Row(
                    children: [
                      SizedBox(width: 15),
                      ShopByTile(
                        imageName: 'bestselling',
                        title: 'Best Selling\nPhones',
                      ),
                      SizedBox(width: 15),
                      ShopByTile(
                        imageName: 'verified',
                        title: 'Verified\nDevices Only',
                      ),
                      SizedBox(width: 15),
                      ShopByTile(
                        imageName: 'like_new',
                        title: 'Like New\nConditions',
                      ),
                      SizedBox(width: 15),
                      ShopByTile(
                        imageName: 'warranty',
                        title: 'Phone with\nWarranty',
                      ),
                      SizedBox(width: 15),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      const Text('Best Deals Near You',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: AppColors.secondaryTextColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                      const SizedBox(width: 10),
                      const Text('India',
                          style: TextStyle(
                            color: AppColors.yellowColor,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.yellowColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                      const Spacer(),
                      TextButton(
                        onPressed: () async {
                          await HelperMethods.getFilters();
                          // show Modal Bottom Sheet for filters
                          // ignore: use_build_context_synchronously
                          showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) {
                                return Wrap(
                                  children: [
                                    Column(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: Image.asset(
                                            'images/cancel.png',
                                            color: AppColors.backgroundColor,
                                            height: 40,
                                          ),
                                        ),
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.8,
                                          decoration: const BoxDecoration(
                                            color: AppColors.backgroundColor,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: CustomChildScrollView(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      const Text('Filters',
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: TextStyle(
                                                            color: AppColors
                                                                .primaryColor,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          )),
                                                      const Spacer(),
                                                      TextButton(
                                                        onPressed: () {
                                                          Provider.of<AppProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .resetFilters();
                                                        },
                                                        child: const Text(
                                                          'Clear Filters',
                                                          style: TextStyle(
                                                            color: Colors
                                                                .redAccent,
                                                            decoration:
                                                                TextDecoration
                                                                    .underline,
                                                            decorationColor:
                                                                Colors
                                                                    .redAccent,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 10),
                                                  const Text('Brand',
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                        color: AppColors
                                                            .secondaryTextColor,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      )),
                                                  const SizedBox(height: 10),
                                                  CustomChildScrollViewHorizontal(
                                                      child: Row(
                                                    children: [
                                                      FilterTile(
                                                          title: 'All',
                                                          isSelected:
                                                              Provider.of<AppProvider>(
                                                                          context)
                                                                      .make ==
                                                                  'All',
                                                          onTap: () {
                                                            Provider.of<AppProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .changeMake(
                                                                    'All');
                                                          }),
                                                      for (int i = 0;
                                                          i <
                                                              filters['make']
                                                                  .length;
                                                          i++)
                                                        FilterTile(
                                                          title: filters['make']
                                                              [i],
                                                          isSelected: Provider.of<
                                                                          AppProvider>(
                                                                      context)
                                                                  .make ==
                                                              filters['make']
                                                                  [i],
                                                          onTap: () {
                                                            Provider.of<AppProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .changeMake(
                                                                    filters['make']
                                                                        [i]);
                                                          },
                                                        ),
                                                    ],
                                                  )),
                                                  const SizedBox(height: 20),
                                                  // ram
                                                  const Text('RAM',
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                        color: AppColors
                                                            .secondaryTextColor,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      )),
                                                  const SizedBox(height: 10),
                                                  CustomChildScrollViewHorizontal(
                                                      child: Row(
                                                    children: [
                                                      FilterTile(
                                                          title: 'All',
                                                          isSelected:
                                                              Provider.of<AppProvider>(
                                                                          context)
                                                                      .ram ==
                                                                  'All',
                                                          onTap: () {
                                                            Provider.of<AppProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .changeRam(
                                                                    'All');
                                                          }),
                                                      for (int i = 0;
                                                          i <
                                                              filters['ram']
                                                                  .length;
                                                          i++)
                                                        FilterTile(
                                                          title: filters['ram']
                                                              [i],
                                                          isSelected:
                                                              Provider.of<AppProvider>(
                                                                          context)
                                                                      .ram ==
                                                                  filters['ram']
                                                                      [i],
                                                          onTap: () {
                                                            Provider.of<AppProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .changeRam(
                                                                    filters['ram']
                                                                        [i]);
                                                          },
                                                        ),
                                                    ],
                                                  )),
                                                  const SizedBox(height: 20),
                                                  // storage
                                                  const Text('Storage',
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                        color: AppColors
                                                            .secondaryTextColor,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      )),
                                                  const SizedBox(height: 10),
                                                  CustomChildScrollViewHorizontal(
                                                      child: Row(
                                                    children: [
                                                      FilterTile(
                                                          title: 'All',
                                                          isSelected: Provider.of<
                                                                          AppProvider>(
                                                                      context)
                                                                  .storage ==
                                                              'All',
                                                          onTap: () {
                                                            Provider.of<AppProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .changeStorage(
                                                                    'All');
                                                          }),
                                                      for (int i = 0;
                                                          i <
                                                              filters['storage']
                                                                  .length;
                                                          i++)
                                                        FilterTile(
                                                          title:
                                                              filters['storage']
                                                                  [i],
                                                          isSelected: Provider.of<
                                                                          AppProvider>(
                                                                      context)
                                                                  .storage ==
                                                              filters['storage']
                                                                  [i],
                                                          onTap: () {
                                                            Provider.of<AppProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .changeStorage(
                                                                    filters['storage']
                                                                        [i]);
                                                          },
                                                        ),
                                                    ],
                                                  )),
                                                  const SizedBox(height: 20),
                                                  // condition
                                                  const Text('Condition',
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                        color: AppColors
                                                            .secondaryTextColor,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      )),
                                                  const SizedBox(height: 10),
                                                  CustomChildScrollViewHorizontal(
                                                      child: Row(
                                                    children: [
                                                      FilterTile(
                                                          title: 'All',
                                                          isSelected: Provider.of<
                                                                          AppProvider>(
                                                                      context)
                                                                  .condition ==
                                                              'All',
                                                          onTap: () {
                                                            Provider.of<AppProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .changeCondition(
                                                                    'All');
                                                          }),
                                                      for (int i = 0;
                                                          i <
                                                              filters['condition']
                                                                  .length;
                                                          i++)
                                                        FilterTile(
                                                          title: filters[
                                                              'condition'][i],
                                                          isSelected: Provider.of<
                                                                          AppProvider>(
                                                                      context)
                                                                  .condition ==
                                                              filters['condition']
                                                                  [i],
                                                          onTap: () {
                                                            Provider.of<AppProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .changeCondition(
                                                                    filters['condition']
                                                                        [i]);
                                                          },
                                                        ),
                                                    ],
                                                  )),

                                                  const SizedBox(height: 20),
                                                  // warranty
                                                  const Text('Warranty',
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                        color: AppColors
                                                            .secondaryTextColor,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      )),

                                                  const SizedBox(height: 10),
                                                  // All , Brand Warranty, Seller Warranty
                                                  CustomChildScrollViewHorizontal(
                                                      child: Row(
                                                    children: [
                                                      FilterTile(
                                                          title: 'All',
                                                          isSelected: Provider.of<
                                                                          AppProvider>(
                                                                      context)
                                                                  .warranty ==
                                                              'All',
                                                          onTap: () {
                                                            Provider.of<AppProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .changeWarranty(
                                                                    'All');
                                                          }),
                                                      // Brand Warranty
                                                      FilterTile(
                                                          title:
                                                              'Brand Warranty',
                                                          isSelected: Provider.of<
                                                                          AppProvider>(
                                                                      context)
                                                                  .warranty ==
                                                              'Brand Warranty',
                                                          onTap: () {
                                                            Provider.of<AppProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .changeWarranty(
                                                                    'Brand Warranty');
                                                          }),

                                                      // Seller Warranty
                                                      FilterTile(
                                                          title:
                                                              'Seller Warranty',
                                                          isSelected: Provider.of<
                                                                          AppProvider>(
                                                                      context)
                                                                  .warranty ==
                                                              'Seller Warranty',
                                                          onTap: () {
                                                            Provider.of<AppProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .changeWarranty(
                                                                    'Seller Warranty');
                                                          }),
                                                    ],
                                                  )),
                                                  const SizedBox(height: 20),
                                                  // Verification
                                                  const Text('Verification',
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                        color: AppColors
                                                            .secondaryTextColor,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      )),
                                                  const SizedBox(height: 10),
                                                  CustomChildScrollViewHorizontal(
                                                      child: Row(
                                                    children: [
                                                      FilterTile(
                                                          title: 'All',
                                                          isSelected: Provider.of<
                                                                          AppProvider>(
                                                                      context)
                                                                  .verification ==
                                                              'All',
                                                          onTap: () {
                                                            Provider.of<AppProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .changeVerification(
                                                                    'All');
                                                          }),
                                                      // verified
                                                      FilterTile(
                                                          title: 'Verified',
                                                          isSelected: Provider.of<
                                                                          AppProvider>(
                                                                      context)
                                                                  .verification ==
                                                              'Verified',
                                                          onTap: () {
                                                            Provider.of<AppProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .changeVerification(
                                                                    'Verified');
                                                          }),
                                                    ],
                                                  )),

                                                  // price
                                                  const SizedBox(height: 20),
                                                  const Text('Price',
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                        color: AppColors
                                                            .secondaryTextColor,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      )),

                                                  const SizedBox(height: 10),
                                                  // min and max price textfield in a row read only
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Row(children: [
                                                          const Text(
                                                            'Min',
                                                            style: TextStyle(
                                                              color: AppColors
                                                                  .secondaryTextColor,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 10),
                                                          Expanded(
                                                            child: SizedBox(
                                                              height: 50,
                                                              child: TextField(
                                                                readOnly: true,
                                                                decoration:
                                                                    InputDecoration(
                                                                  hintText: HelperMethods.formatCurrency(Provider.of<
                                                                              AppProvider>(
                                                                          context)
                                                                      .minPrice
                                                                      .toString()),
                                                                  hintStyle:
                                                                      const TextStyle(
                                                                    color: AppColors
                                                                        .secondaryTextColor,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ]),
                                                      ),
                                                      const SizedBox(width: 30),
                                                      Expanded(
                                                        child: Row(children: [
                                                          const Text(
                                                            'Max',
                                                            style: TextStyle(
                                                              color: AppColors
                                                                  .secondaryTextColor,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 10),
                                                          Expanded(
                                                            child: SizedBox(
                                                              height: 50,
                                                              child: TextField(
                                                                readOnly: true,
                                                                decoration:
                                                                    InputDecoration(
                                                                  hintText: HelperMethods.formatCurrency(Provider.of<
                                                                              AppProvider>(
                                                                          context)
                                                                      .maxPrice
                                                                      .toString()),
                                                                  hintStyle:
                                                                      const TextStyle(
                                                                    color: AppColors
                                                                        .secondaryTextColor,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ]),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 20),
                                                  // min max price slider
                                                  Theme(
                                                    data: ThemeData(
                                                      sliderTheme:
                                                          const SliderThemeData(
                                                        trackHeight: 2,
                                                        activeTrackColor:
                                                            AppColors
                                                                .primaryColor,
                                                        inactiveTrackColor:
                                                            AppColors
                                                                .secondaryTextColor,
                                                        thumbColor: AppColors
                                                            .primaryColor,
                                                        thumbShape:
                                                            RoundSliderThumbShape(
                                                                enabledThumbRadius:
                                                                    8),
                                                        overlayShape:
                                                            RoundSliderOverlayShape(
                                                                overlayRadius:
                                                                    20),
                                                      ),
                                                    ),
                                                    child: RangeSlider(
                                                      values: RangeValues(
                                                        double.parse(Provider
                                                                .of<AppProvider>(
                                                                    context)
                                                            .minPrice
                                                            .toString()),
                                                        double.parse(Provider
                                                                .of<AppProvider>(
                                                                    context)
                                                            .maxPrice
                                                            .toString()),
                                                      ),
                                                      onChanged: (RangeValues
                                                          newRangeValues) {
                                                        Provider.of<AppProvider>(
                                                                context,
                                                                listen: false)
                                                            .changeMinPrice(
                                                                newRangeValues
                                                                    .start
                                                                    .toInt());
                                                        Provider.of<AppProvider>(
                                                                context,
                                                                listen: false)
                                                            .changeMaxPrice(
                                                                newRangeValues
                                                                    .end
                                                                    .toInt());
                                                      },
                                                      min: 0,
                                                      max: 200000,
                                                      divisions: 100,
                                                      labels: RangeLabels(
                                                        Provider.of<AppProvider>(
                                                                context)
                                                            .minPrice
                                                            .toString(),
                                                        Provider.of<AppProvider>(
                                                                context)
                                                            .maxPrice
                                                            .toString(),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 20),
                                                  // apply button
                                                  SizedBox(
                                                    height: 50,
                                                    width: double.infinity,
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            AppColors
                                                                .primaryColor,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                      child: const Text('Apply',
                                                          style: TextStyle(
                                                            color: AppColors
                                                                .backgroundColor,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          )),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),

                                        // apply button
                                      ],
                                    ),
                                  ],
                                );
                              });
                        },
                        child: Row(
                          children: [
                            const Text('Filter',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                )),
                            const SizedBox(width: 5),
                            Image.asset(
                              'images/filter.png',
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                // list of phones gridview builder with 2 cross axis count with phone_view_widget.dart
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: Provider.of<AppProvider>(context).devices.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 9 / 16,
                  ),
                  itemBuilder: (context, index) {
                    return PhoneViewWidget(
                      device: Provider.of<AppProvider>(context).devices[index],
                    );
                  },
                ),
              ],
            ),
          ))
        ],
      )),
    );
  }
}
