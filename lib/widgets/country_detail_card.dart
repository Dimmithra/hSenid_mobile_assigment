import 'package:country_app/provider/home_provider.dart';
import 'package:country_app/utils/color_const.dart';
import 'package:country_app/utils/main_body.dart';
import 'package:country_app/widgets/common_lable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountryDetailScreen extends StatefulWidget {
  final String code;

  const CountryDetailScreen({super.key, required this.code});

  @override
  State<CountryDetailScreen> createState() => _CountryDetailScreenState();
}

class _CountryDetailScreenState extends State<CountryDetailScreen> {
  // final GraphQLService _service = GraphQLService();
  // bool _loading = true;
  // Map<String, dynamic>? _country;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeProvider>(
        context,
        listen: false,
      ).searchCountries(context, code: widget.code);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainBody(
        appBarBacgroundColor: kAppBarBackgroundColor,
        backgroundColor: kBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Consumer<HomeProvider>(
                builder: (context, homeProvider, child) {
                  if (homeProvider.getloadSelectedCountryDetail) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final country = homeProvider.selectedCountry;
                  if (country == null) {
                    return const Center(child: Text("Country not found"));
                  }

                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                CommonLable(
                                  labelName: "${country.emoji}",
                                  fontSize: 30,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.1,
                                  child: CommonLable(
                                    labelName:
                                        "${country.name} (${country.code})",
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    enableNotoSerif: true,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        // Text("${country.emoji} ${country.name} (${country.code})",
                        //     style: const TextStyle(
                        //         fontSize: 22, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        CommonLable(
                          labelName: "Capital: ${country.capital ?? 'N/A'}",
                          fontSize: 14,
                        ),
                        CommonLable(
                          labelName: "currency: ${country.currency ?? 'N/A'}",
                          fontSize: 14,
                        ),
                        CommonLable(
                          labelName:
                              "continent: ${country.continent?.name ?? 'N/A'}",
                          fontSize: 14,
                        ),
                        CommonLable(
                          labelName:
                              "Languages: ${country.languages?.map((e) => e.name).join(', ') ?? 'N/A'}",
                          fontSize: 14,
                        ),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ));

    // Scaffold(
    //   appBar: AppBar(title: Text(_country!['name'] ?? "Country Details")),
    //   body: Padding(
    //     padding: const EdgeInsets.all(16),
    //     child: ListView(
    //       children: [
    //         Text(
    //           "${_country!['emoji']} ${_country!['name']} (${_country!['code']})",
    //           style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    //         ),
    //         const SizedBox(height: 12),
    //         Text("Capital: ${_country!['capital'] ?? 'N/A'}"),
    //         Text("Continent: ${_country!['continent']?['name'] ?? 'N/A'}"),
    //         Text("Currency: ${_country!['currency'] ?? 'N/A'}"),
    //         Text(
    //           "Languages: ${(_country!['languages'] as List).map((e) => e['name']).join(', ')}",
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
