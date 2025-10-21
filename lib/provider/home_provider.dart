import 'dart:convert';

import 'package:country_app/model/country_detail_model.dart';
import 'package:country_app/services/custom_api.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;

class HomeProvider extends ChangeNotifier {
  final GraphQLService graphqlService = GraphQLService();

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
}
