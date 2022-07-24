import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:my_app_flutter/utilities/hexColor.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

const getKeywordTag = '''
  query (\$type: TypeKeywordTag) {
    getKeywordTag(type: \$type) {
      data {
        region {
          id
          position
        }
        industrial {
          id
          position
        }
        province {
          id
          position
        }   
        district{
          id
          position
        }   
        subdistrict {
          id
          position
        }
        keyword {
          id
          position
        }
        businesstype {
          id
          position
        }
        jobtype {
          id
          position
        }
        subjobtype {
          id
          position
        }
        mststation {
          id
          position
        }
        tags {
          id
          position
        }
      }
    }
  }
''';

class KeywordTag extends StatelessWidget {
  const KeywordTag({Key? key}) : super(key: key);

// Future mapPosition (dataStatic, dataKeywordTage) (
//   dataStatic.map((item) => {
//     const key = Object.keys(item.paramSearch)[0]
//     const positionJob = dataKeywordTage[key].find(keywordTag => keywordTag.id === item.paramSearch[key])
//     return {
//       ...item,
//       position: (positionJob && positionJob.position) || 0,
//     }
//   })
// )
  Future<String> getJson() {
    return rootBundle.loadString('assets/keywordTag.json');
  }

  //   var my_data = jsonDecode(await getJson());
  // print('data>>>>>>> ${my_data}');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getJson(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<dynamic> data = json.decode('${snapshot.data}')?['allJobs'];
          // return Text('Result: ${snapshot.data}');
          return Container(
            child: Query(
              options: QueryOptions(
                document: gql(getKeywordTag),
                variables: const {
                  "type": {
                    "region": ["6", "4", "3", "2", "1", "5"],
                    "industrial": ["all", "1283169", "1283164"],
                    "tags": ["WFH", "Online Interview"],
                    "province": ["59", "09", "14", "21", "41"],
                    "district": ["0145"],
                    "subdistrict": ["012504"],
                    "mststation": ["1360977"],
                    "keyword": ["รังสิต"]
                  },
                },
              ),
              builder: (QueryResult result, {fetchMore, refetch}) {
                if (result.hasException) {
                  return Text(result.exception.toString());
                }

                if (result.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                // print('result??? ${result.data?['getKeywordTag']?['data']}');
                // return ListView.builder(
                //   shrinkWrap: true,
                //   scrollDirection: Axis.horizontal,
                //   itemCount: 10,
                //   itemBuilder: (context, index) {
                //     return Container(
                //       width: 100,
                //     );
                //   },
                // );
                return Container(
                  child: Row(
                    children: [
                      Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: HexColor.fromHex('#F0F0F0'),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.grey.withOpacity(0.5),
                          //     spreadRadius: 2,
                          //     blurRadius: 7,
                          //   )
                          // ],
                        ),
                        padding: EdgeInsets.all(10.0),
                        child: Text('กรุงเทพและปริมณฑล (68,847)'),
                      )
                    ],
                  ),
                );
              },
            ),
          );
        }
        return Container();
      },
    );
  }
}
