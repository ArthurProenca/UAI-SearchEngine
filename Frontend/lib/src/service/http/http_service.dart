import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:uai/src/domain/result/search_result_dto.dart';

class HttpService {
  static Future<SearchResultDTO> get(Uri uri) async {
    //return http.get(uri);

    const json = ''' 
{
   "wikipediaResults":[
         {
            "title":"<em>Binary</em> <em>search</em> algorithm In computer science <em>binary</em> <em>search</em> also known as half interval <em>search</em> logarithmic <em>search</em> or <em>binary</em> chop is a <em>search</em> algorithm that finds the position of a target value within a sorted array <em>Binary</em> <em>search</em> compares the target value to the middle element of the array ",
            "url":"Binary search algorithm",
            "abs":"https://en.wikipedia.org/wiki/Binary_search_algorithm"
         },
         {
            "title":"The time complexity of operations on the <em>binary</em> <em>search</em> tree is directly proportional to the height of the tree <em>Binary</em> <em>search</em> trees all",
            "url":"Binary search tree",
            "abs":"https://en.wikipedia.org/wiki/Binary_search_tree"
         },
         {
            "title":"The first <em>binary</em> <em>search</em> in the sequence takes a logarithmic amount of time as is standard for <em>binary</em> <em>searches</em> but successive <em>searches</em> in the sequence are faster ",
            "url":"Fractional cascading",
            "abs":"https://en.wikipedia.org/wiki/Fractional_cascading"
         },
         {
            "title":"Optimal <em>binary</em> <em>search</em> tree In computer science an optimal <em>binary</em> <em>search</em> tree Optimal BST sometimes called a weight balanced <em>binary</em> tree is a <em>binary</em> <em>search</em> tree which provides the smallest possible <em>search</em> time or expected <em>search</em> time for a given sequence of accesses or access probabilities ",
            "url":"Optimal binary search tree",
            "abs":"https://en.wikipedia.org/wiki/Optimal_binary_search_tree"
         },
         {
            "title":"In computer science the treap and the randomized <em>binary</em> <em>search</em> tree are two closely related forms of <em>binary</em> <em>search</em> tree data structures that maintain a dynamic set of ordered keys and allow <em>binary</em> <em>searches</em> among the keys ",
            "url":"Treap",
            "abs":"https://en.wikipedia.org/wiki/Treap"
         }
      ],
      "currentPage":1,"totalPages":2,
   "searchOnMathResults":[],
   "hasSearchOnMath":false,
   "hasWikipedia":true
}''';

    final jsonMap = jsonDecode(json);
    return SearchResultDTO.fromJson(jsonMap);
  }
}
