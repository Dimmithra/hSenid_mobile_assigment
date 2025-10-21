import 'package:flutter/material.dart';
import '../services/custom_api.dart';

class CountryDetailScreen extends StatefulWidget {
  final String code;

  const CountryDetailScreen({super.key, required this.code});

  @override
  State<CountryDetailScreen> createState() => _CountryDetailScreenState();
}

class _CountryDetailScreenState extends State<CountryDetailScreen> {
  final GraphQLService _service = GraphQLService();
  bool _loading = true;
  Map<String, dynamic>? _country;

  @override
  void initState() {
    super.initState();
    _fetchCountryDetail();
  }

  Future<void> _fetchCountryDetail() async {
    const query = r'''
      query GetCountry($code: ID!) {
        country(code: $code) {
          name
          code
          capital
          currency
          emoji
          continent {
            name
          }
          languages {
            name
          }
        }
      }
    ''';

    final result =
        await _service.runQuery(query, variables: {"code": widget.code});
    setState(() {
      _country = result.data?['country'];
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_country == null) {
      return const Scaffold(
        body: Center(child: Text("Country not found")),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(_country!['name'] ?? "Country Details")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text(
              "${_country!['emoji']} ${_country!['name']} (${_country!['code']})",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text("Capital: ${_country!['capital'] ?? 'N/A'}"),
            Text("Continent: ${_country!['continent']?['name'] ?? 'N/A'}"),
            Text("Currency: ${_country!['currency'] ?? 'N/A'}"),
            Text(
              "Languages: ${(_country!['languages'] as List).map((e) => e['name']).join(', ')}",
            ),
          ],
        ),
      ),
    );
  }
}
