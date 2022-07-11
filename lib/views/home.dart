import 'package:flutter/material.dart';
import 'package:my_app_flutter/components/topCompany.dart';
import 'package:my_app_flutter/components/popularSearch.dart';
import 'package:my_app_flutter/views/jobList.dart';
import 'package:my_app_flutter/responsive/responsive_layout.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

const getPositionsCount = '''
  query {
    getPositionsCount {
      data {
        total {
          positions
        }
      }
    }
  }
''';

class HomeScreenMobile extends StatelessWidget {
  const HomeScreenMobile({Key? key}) : super(key: key);
  static String src = 'https://i.ytimg.com/vi/UZ5QN9l7czk/maxresdefault.jpg';

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          toolbarHeight: 5,
          pinned: true,
          snap: false,
          floating: false,
          expandedHeight: 350.0,
          backgroundColor: Colors.white,
          flexibleSpace: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => JobList(source: src)),
              );
            },
            child: FlexibleSpaceBar(
              background: Image.network(
                src,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              switch (index) {
                case 0:
                  {
                    return Container(child: const TopCompany());
                  }
                case 1:
                  {
                    return const PopularSearch();
                  }
                default:
                  {
                    return Container(
                      color: index.isOdd ? Colors.white : Colors.black12,
                      height: 100.0,
                      child: Center(
                        child: Text('$index', textScaleFactor: 5),
                      ),
                    );
                  }
              }
            },
            childCount: 20,
          ),
        ),
      ],
    );
  }
}

class HomeScreenTablet extends StatelessWidget {
  const HomeScreenTablet({Key? key}) : super(key: key);
  static String src = 'https://i.ytimg.com/vi/UZ5QN9l7czk/maxresdefault.jpg';
  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
            width: currentWidth,
            child: Container(
              child: Image.network(
                src,
                fit: BoxFit.cover,
                width: currentWidth * 0.7,
              ),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                  )
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
            width: currentWidth,
            child: Container(
              width: currentWidth * 0.7,
              height: 80,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    "https://www.jobthai.com/static/images/keyart.png",
                  ),
                ),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Query(
                  options: QueryOptions(
                    document: gql(getPositionsCount),
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
                    final positionCount = result.data?['getPositionsCount']
                        ?['data']?['total']?['positions'];
                    return Text(
                      'งานทั้งหมด $positionCount อัตรา',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResposiveLayout(
        mobileBody: const HomeScreenMobile(),
        tabletBody: const HomeScreenTablet(),
      ),
    );
  }
}
