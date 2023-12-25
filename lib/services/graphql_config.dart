import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLConfig {

  static HttpLink httpLink = HttpLink('https://rickandmortyapi.com/graphql',);

  GraphQLClient clientToQuery(){
    return GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(),
    );
  }
}