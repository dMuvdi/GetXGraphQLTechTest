import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../models/character.dart';
import '../services/graphql_config.dart';

class CharactersController extends GetxController {

  List<Character> characters = [];
  String searchValue = '';
  int count = 0;
  int pageNumber = 1;
  bool noMoreCharacters = false;

  static GraphQLConfig graphQLConfig = GraphQLConfig();
  GraphQLClient client = graphQLConfig.clientToQuery();

  @override
  void onInit() {
    super.onInit();
    getCharacters(pageNumber);
    update();
  }

  void increasePageNumber(){
    characters = [];
    if(noMoreCharacters == false){
      pageNumber++;
      searchValue == '' ? getCharacters(pageNumber) : getCharactersSearch();
    } else {
      pageNumber = pageNumber;
    }
    update();
  }

  void decreasePageNumber(){
    noMoreCharacters = false;
    characters = [];
    pageNumber--;
    if (pageNumber < 1){
      pageNumber = 1;
    }
    searchValue == '' ? getCharacters(pageNumber) : getCharactersSearch();
    update();
  }

  Future<void> getCharactersSearch() async {
    try{
      final QueryOptions options = QueryOptions(
      fetchPolicy: FetchPolicy.cacheFirst,
        document: gql("""
            query GetCharacters(\$name: String){
              characters(page: $pageNumber, filter: {name: \$name}) {
                info {
                  count
                }
                results {
                  id
                  name
                  status
                  image
                  type
                  gender
                  created
                  origin{
                    name
                  }
                  species
                  created
                  episode{
                    id
                    name
                    air_date
                    episode
                  }
                  location{
                    id
                    name
                    type
                    dimension
                  }
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

      List? res = result.data?['characters']['results'];

      if (res == null || res.isEmpty){
        characters = [];
      } else {
        List<Character> characters = res.map((character) => Character.fromMap(map: character)).toList();
        count = result.data?['characters']['info']['count'];
        this.characters = characters;
      }
      update();
    } catch (e){
      print(e);
    }
  }

  Future<void> getCharacters(int number) async {
    try{
      final QueryOptions options = QueryOptions(
      fetchPolicy: FetchPolicy.cacheFirst,
        document: gql("""
            query GetCharacters{
              characters(page: $number) {
                info {
                  count
                }
                results {
                  id
                  name
                  status
                  image
                  type
                  gender
                  created
                  origin{
                    name
                  }
                  species
                  created
                  episode{
                    id
                    name
                    air_date
                    episode
                  }
                  location{
                    id
                    name
                    type
                    dimension
                  }
                }
              }
            }
      """),
      );

      final QueryResult result = await client.query(options);
      
      if (result.hasException){
        print(result.exception);
      }

      List? res = result.data?['characters']['results'];

      if (result.data?['characters']['info']['count'] == null){
        noMoreCharacters = true;
      }

      if (res == null || res.isEmpty){
        characters = [];
      } else {
        List<Character> characters = res.map((character) => Character.fromMap(map: character)).toList();
        count = result.data?['characters']['info']['count'];
        this.characters = characters;
      }
      update();
    } catch (e){
      print(e);
    }
  }
}