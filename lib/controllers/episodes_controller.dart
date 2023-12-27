import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../models/episode.dart';
import '../services/graphql_config.dart';

class EpisodesController extends GetxController {

  List<Episode> episodes = [];
  List<String> seasons = ['S01', 'S02', 'S03', 'S04', 'S05'];
  RxString season = 'S01'.obs;
  String searchValue = '';
  int count = 0;

  static GraphQLConfig graphQLConfig = GraphQLConfig();
  GraphQLClient client = graphQLConfig.clientToQuery();

  @override
  void onInit() {
    super.onInit();
    getEpisodes();
  }

  void changeSeason(String value){
    season.value = value;
    episodes = [];
    getEpisodes();
    update();
  }

  Future<void> getEpisodesBySearch() async {
    try{
      final QueryOptions options = QueryOptions(
      fetchPolicy: FetchPolicy.cacheFirst,
        document: gql("""
            query GetEpisodesByName(\$name:String){
              episodes(filter: {name: \$name}) {
                info {
                  count
                }
                results {
                  id
                  name
                  air_date
                  episode
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

      List? res = result.data?['episodes']['results'];

      if (res == null || res.isEmpty){
        episodes = [];
      } else {
        List<Episode> episodes = res.map((character) => Episode.fromMap(map: character)).toList();
        count = result.data?['episodes']['info']['count'];
        this.episodes = episodes;
      }
      update();
    } catch (e){
      print(e);
    }
  }

  Future<void> getEpisodes() async {
    try{
      final QueryOptions options = QueryOptions(
      fetchPolicy: FetchPolicy.cacheFirst,
        document: gql("""
            query GetEpisodesBySeason(\$season:String){
              episodes(filter: {episode: \$season}) {
                info {
                  count
                }
                results {
                  id
                  name
                  air_date
                  episode
                }
              }
            }
      """),
        variables: {
          'season': season.value
        }
      );

      final QueryResult result = await client.query(options);
      
      if (result.hasException){
        print(result.exception);
      }

      List? res = result.data?['episodes']['results'];

      if (res == null || res.isEmpty){
        episodes = [];
      } else {
        List<Episode> episodes = res.map((episode) => Episode.fromMap(map: episode)).toList();
        count = result.data?['episodes']['info']['count'];
        this.episodes = episodes;
      }
      update();
    } catch (e){
      print(e);
    }
  }
}