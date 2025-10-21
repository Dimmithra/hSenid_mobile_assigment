import 'package:country_app/provider/home_provider.dart';
import 'package:country_app/utils/color_const.dart';
import 'package:country_app/utils/main_body.dart';
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
    // TODO: implement initState
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
                padding: EdgeInsets.all(10),
                child: CommonLable(
                  labelName: "Choose country",
                  color: kdefTextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Expanded(
                child: homeProvider.loadinCountryList
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        controller: homeProvider.scrollController,
                        itemCount: homeProvider.countries.length +
                            (homeProvider.fetchingMore ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index < homeProvider.countries.length) {
                            final c = homeProvider.countries[index];
                            return ListTile(
                              leading: Text(c.emoji ?? '🏳️'),
                              title: Text(c.name ?? 'Unknown'),
                              subtitle: Text(
                                "${c.name ?? 'No capital'} • ${c.continent?.name ?? 'N/A'}",
                                style: TextStyle(color: kdefTextColor),
                              ),
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
                              child: Center(child: CircularProgressIndicator()),
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
