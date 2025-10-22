import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:country_app/utils/color_const.dart';
import 'package:country_app/utils/common_snack_bar.dart';
import 'package:country_app/utils/url_const.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLService {
  static final GraphQLService _instance = GraphQLService._internal();

  factory GraphQLService() => _instance;

  GraphQLService._internal();

  static const String _baseURL = BASE_URL;

  late GraphQLClient _client;

  /// Initialize GraphQL client (call once, e.g., in main())
  Future<void> init() async {
    final HttpLink httpLink = HttpLink(_baseURL);

    _client = GraphQLClient(
      cache: GraphQLCache(store: InMemoryStore()),
      link: httpLink,
    );
  }

  // Check network connectivity before API calls
  Future<bool> _isConnected() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  //Run GraphQL query
  Future<QueryResult> runQuery(
    context,
    String query, {
    Map<String, dynamic>? variables,
  }) async {
    // Check network before calling API
    if (!await _isConnected()) {
      SnackBarUtils.showSnackBar(
        context,
        message: "No internet connection. Please check your network.",
        style: SnackBarStyle(backgroundColor: kErrorColor),
      );
      throw Exception("No internet connection");
    }

    final options = QueryOptions(
      document: gql(query),
      variables: variables ?? {},
    );

    final result = await _client.query(options);

    if (result.hasException) {
      SnackBarUtils.showSnackBar(
        context,
        message:
            "Hmm, it seems your internet connection isn’t stable right now. Please check your Wi-Fi or Mobile data and give it another try.",
        style: SnackBarStyle(backgroundColor: kErrorColor),
      );
      throw Exception(result.exception.toString());
    }

    return result;
  }

  // Run GraphQL mutation
  Future<QueryResult> runMutation(
    context,
    String mutation, {
    Map<String, dynamic>? variables,
  }) async {
    // Check network before calling API
    if (!await _isConnected()) {
      SnackBarUtils.showSnackBar(
        context,
        message: "No internet connection. Please check your network.",
        style: SnackBarStyle(backgroundColor: kErrorColor),
      );
      throw Exception("No internet connection");
    }

    final options = MutationOptions(
      document: gql(mutation),
      variables: variables ?? {},
    );

    final result = await _client.mutate(options);

    if (result.hasException) {
      SnackBarUtils.showSnackBar(
        context,
        message: "No internet connection. Please check your network.",
        style: SnackBarStyle(backgroundColor: kErrorColor),
      );
      throw Exception(result.exception.toString());
    }

    return result;
  }
}
