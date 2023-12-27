import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../models/location.dart';
import '../services/graphql_config.dart';

class LocationsController extends GetxController {

  List<Location> locations = [];
  String searchValue = '';
  int count = 0;
  int pageNumber = 1;
  bool noMoreLocations = false;

  static GraphQLConfig graphQLConfig = GraphQLConfig();
  GraphQLClient client = graphQLConfig.clientToQuery();

  @override
  void onInit() {
    super.onInit();
    getLocations(pageNumber);
    update();
  }

  void increasePageNumber(){
    locations = [];
    if(noMoreLocations == false){
      pageNumber++;
      searchValue == '' ? getLocations(pageNumber) : getLocationsSearch();
    } else {
      pageNumber = pageNumber;
    }
    update();
  }

  void decreasePageNumber(){
    noMoreLocations = false;
    locations = [];
    pageNumber--;
    if (pageNumber < 1){
      pageNumber = 1;
    }
    searchValue == '' ? getLocations(pageNumber) : getLocationsSearch();
    update();
  }

  Future<void> getLocationsSearch() async {
    try{
      final QueryOptions options = QueryOptions(
      fetchPolicy: FetchPolicy.cacheFirst,
        document: gql("""
          query GetLocations(\$name: String){
            locations(page: 1, filter:{name:\$name}) {
              info {
                count
              }
              results {
                id
                type
                name
                dimension
              }
            }
          }
      """),
        variables: {
          'name': searchValue
        }
      );

      final QueryResult result = await client.query(options);
      
      if (result.hasException){
        print(result.exception);
      }

      List? res = result.data?['locations']['results'];

      if (res == null || res.isEmpty){
        locations = [];
      } else {
        List<Location> locations = res.map((character) => Location.fromMap(map: character)).toList();
        count = result.data?['locations']['info']['count'];
        this.locations = locations;
      }
      update();
    } catch (e){
      print(e);
    }
  }

  Future<void> getLocations(int number) async {
    try{
      final QueryOptions options = QueryOptions(
      fetchPolicy: FetchPolicy.cacheFirst,
        document: gql("""
          query GetLocations{
            locations(page: $number) {
              info {
                count
              }
              results {
                id
                type
                name
                dimension
              }
            }
          }
      """),
      );

      final QueryResult result = await client.query(options);
      
      if (result.hasException){
        print(result.exception);
      }

      List? res = result.data?['locations']['results'];

      if (result.data?['locations']['info']['count'] == null){
        noMoreLocations = true;
      }

      if (res == null || res.isEmpty){
        locations = [];
      } else {
        List<Location> locations = res.map((character) => Location.fromMap(map: character)).toList();
        count = result.data?['locations']['info']['count'];
        this.locations = locations;
      }
      update();
    } catch (e){
      print(e);
    }
  }
}