import 'package:country_app/provider/home_provider.dart';
import 'package:country_app/utils/color_const.dart';
import 'package:country_app/utils/main_body.dart';
import 'package:country_app/widgets/common_input.dart';
import 'package:country_app/widgets/common_lable.dart';
import 'package:country_app/widgets/common_serchable_dropdown.dart';
import 'package:country_app/widgets/country_detail_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeProvider>(
        context,
        listen: false,
      ).getCountyList(context);

      Provider.of<HomeProvider>(
        context,
        listen: false,
      ).scrollControllerDetail(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainBody(
      appBarBacgroundColor: kAppBarBackgroundColor,
      backgroundColor: kBackgroundColor,
      title: CommonLable(
        labelName: "Country Insights App",
        fontSize: 22,
        enableNotoSerif: true,
        fontWeight: FontWeight.bold,
      ),
      body: Consumer<HomeProvider>(
        builder: (context, homeProvider, child) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: CommonLable(
                        labelName: "Choose country",
                        color: kdefTextColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    CommonInputFeild(
                      controller: homeProvider.getsearchaFeildController,
                      hintText: "Search by country or continent",
                      onChanged: (p0) {
                        homeProvider.searchCountriesDetails(context,
                            query: homeProvider.getsearchaFeildController.text);
                      },
                      suffixIcon: Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(Icons.search),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: homeProvider.loadinCountryList
                    ? const Center(child: CircularProgressIndicator())
                    : homeProvider.countries.isEmpty
                        ? CommonLable(
                            labelName: "No countries found",
                            color: kdefTextColor.withOpacity(0.7),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          )
                        : ListView.builder(
                            controller: homeProvider.scrollController,
                            itemCount: homeProvider.countries.length +
                                (homeProvider.fetchingMore ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index < homeProvider.countries.length) {
                                final c = homeProvider.countries[index];
                                return ListTile(
                                  leading: CommonLable(
                                    labelName: c.emoji ?? '🏳️',
                                    color: kdefTextColor,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  title: CommonLable(
                                    labelName: c.name ?? 'Unknown',
                                    color: kdefTextColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CommonLable(
                                        labelName: "${c.name ?? 'No capital'}",
                                        color: kdefTextColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      CommonLable(
                                        labelName: c.continent?.name ?? 'N/A',
                                        color: kdefTextColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ],
                                  ),
                                  // Text(
                                  //   "${c.name ?? 'No capital'} • ${c.continent?.name ?? 'N/A'}",
                                  //   style: TextStyle(color: kdefTextColor),
                                  // ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => CountryDetailScreen(
                                          code: c.code!,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  child: Center(
                                      child: CircularProgressIndicator()),
                                );
                              }
                            },
                          ),
              ),
            ],
          );
        },
      ),
    );
  }
}
