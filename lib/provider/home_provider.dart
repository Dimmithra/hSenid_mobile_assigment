import 'dart:convert';

import 'package:country_app/model/country_detail_model.dart';
import 'package:country_app/services/custom_api.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;

class HomeProvider extends ChangeNotifier {
  final GraphQLService graphqlService = GraphQLService();

  TextEditingController searchaFeildController = TextEditingController();
  TextEditingController get getsearchaFeildController => searchaFeildController;

  List<Countries> allCountries = [];
  List<Countries> visibleCountries = [];
  List<Countries> filteredCountries = [];

  bool loadinCountryList = false;
  bool _fetchingMore = false;
  int currentPage = 0;
  static const int _pageSize = 20;

  List<Countries> get countries =>
      filteredCountries.isNotEmpty ? filteredCountries : visibleCountries;
  bool get fetchingMore => _fetchingMore;

  final ScrollController scrollController = ScrollController();

// get api for country list
  Future<void> getCountyList(context) async {
    loadinCountryList = true;
    notifyListeners();

    const getAllCountries = r'''
      query {
        countries {
          code
          name
          capital
          emoji
          continent {
            name
          }
        }
      }
    ''';

    try {
      final result = await graphqlService.runQuery(getAllCountries);
      final data = result.data?['countries'] ?? [];
      final wrapped = {
        "data": {"countries": data}
      };
      final model = CountryDetailsModel.fromJson(wrapped);

      allCountries = model.data?.countries ?? [];
      visibleCountries.clear();
      filteredCountries.clear();
      currentPage = 0;

      _loadNextPage();

      dev.log("Loaded ${allCountries.length} countries");
    } catch (e) {
      dev.log("Error: $e");
    } finally {
      loadinCountryList = false;
      notifyListeners();
    }
  }

// load next page
  void _loadNextPage() {
    final start = currentPage * _pageSize;
    final end = start + _pageSize;

    if (start < allCountries.length) {
      visibleCountries.addAll(
        allCountries.sublist(
          start,
          end > allCountries.length ? allCountries.length : end,
        ),
      );
      currentPage++;
      notifyListeners();
    }
  }

  void loadMoreCountries() {
    if (_fetchingMore || visibleCountries.length >= allCountries.length) return;

    _fetchingMore = true;
    notifyListeners();

    Future.delayed(const Duration(milliseconds: 300), () {
      _loadNextPage();
      _fetchingMore = false;
      notifyListeners();
    });
  }

  void scrollControllerDetail(context) {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        loadMoreCountries();
      }
    });
  }

  // selected country details
  bool loadSelectedCountryDetail = false;
  bool get getloadSelectedCountryDetail => loadSelectedCountryDetail;
  setloadSelectedCountryDetail(val) {
    loadSelectedCountryDetail = val;
    notifyListeners();
  }

  Countries? selectedCountry;
  Countries? get getselectedCountry => selectedCountry;
  setselectedCountry(val) {
    selectedCountry = val;
    notifyListeners();
  }

  Future<void> searchCountries(context, {required String code}) async {
    try {
      setloadSelectedCountryDetail(true);
      const query = r'''
      query GetCountryDetail($code: ID!) {
        country(code: $code) {
          code
          name
          capital
          currency
          emoji
          continent { name }
          languages { name code }
        }
      }
    ''';
      final result =
          await graphqlService.runQuery(query, variables: {"code": code});
      final data = result.data?['country'];
      if (data != null) {
        selectedCountry = Countries.fromJson(data);
      } else {
        selectedCountry = null;
      }
      notifyListeners();
      dev.log("Fetched country detail: ${selectedCountry?.name}");
    } catch (e) {
      dev.log(e.toString());
    } finally {
      setloadSelectedCountryDetail(false);
    }
  }

  void searchCountriesDetails(String query) {
    if (query.isEmpty) {
      filteredCountries.clear();
    } else {
      filteredCountries = allCountries.where((country) {
        final name = country.name?.toLowerCase() ?? '';
        final continent = country.continent?.name?.toLowerCase() ?? '';
        return name.contains(query.toLowerCase()) ||
            continent.contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }
}
