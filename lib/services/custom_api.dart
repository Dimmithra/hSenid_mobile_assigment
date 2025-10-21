import 'package:country_app/utils/url_const.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLService {
  static final GraphQLService _instance = GraphQLService._internal();

  factory GraphQLService() {
    return _instance;
  }

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

  /// Common method to run queries
  Future<QueryResult> runQuery(String query,
      {Map<String, dynamic>? variables}) async {
    final options = QueryOptions(
      document: gql(query),
      variables: variables ?? {},
    );

    final result = await _client.query(options);

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    return result;
  }

  /// Common method to run mutations
  Future<QueryResult> runMutation(String mutation,
      {Map<String, dynamic>? variables}) async {
    final options = MutationOptions(
      document: gql(mutation),
      variables: variables ?? {},
    );

    final result = await _client.mutate(options);

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    return result;
  }
}
