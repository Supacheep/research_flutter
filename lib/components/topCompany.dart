import 'package:flutter/material.dart';
import 'package:my_app_flutter/views/jobList.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

const QUERY = """
  query (\$filter: BannerFilter, \$isShuffle: Boolean, \$limit: Int, \$page: Int){
    getBanner(filter: \$filter, isShuffle: \$isShuffle, limit: \$limit, page: \$page) {
      data {
        id
        companyID
        jobID
        landingPageID
        targetType
        url
        imagePath {
          app
        }
        company {
          logo
          name
        }
      }
    }
  }
""";

class CompanyView extends StatelessWidget {
  const CompanyView({
    Key? key,
    required this.source,
  }) : super(key: key);
  final String source;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => JobList(source: source)),
          );
        },
        child: Container(
          height: 90,
          width: 90,
          clipBehavior: Clip.hardEdge,
          child: Image.network(
            source,
            fit: BoxFit.cover,
          ),
          margin: const EdgeInsets.only(
              left: 5.0, top: 10.0, right: 5.0, bottom: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(45),
            color: Colors.grey,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
              )
            ],
          ),
        ));
  }
}

class TopCompany extends StatelessWidget {
  const TopCompany({Key? key}) : super(key: key);
  static List<String> urls = [
    'https://fq.lnwfile.com/_webp_resize_images/300/300/4z/a9/nx.webp',
    'https://www.thinknet.co.th/assets_reach/images/logo/thinknet-logo.png',
    'https://media.jobthai.com/v1/images/company/83610_company_2.jpeg',
    'https://media.jobthai.com/v1/images/company/83610_company_1.jpeg',
    'https://thinknetdesignstudio.shop/static/images/facebook-cover-2.png',
    'http://www.thinknet.co.th/service/image/s3_ckf_images/2485CB36-1D72-4678-844D-9A286FE6046D.jpg',
    'https://happyschoolbreak.com/wp-content/uploads/2018/11/THiNKNET.png'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.only(
              left: 10.0,
              top: 25.0,
              right: 5.0,
              bottom: 10.0,
            ),
            child: const Text(
              'TOP COMPANIES',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 110,
          // child: ListView.builder(
          //   shrinkWrap: true,
          //   scrollDirection: Axis.horizontal,
          //   itemCount: urls.length,
          //   itemBuilder: (context, index) {
          //     return CompanyView(
          //       source: urls[index],
          //     );
          //   },
          // ),
          child: Query(
            options: QueryOptions(
              document: gql(QUERY),
              variables: const {
                'filter': {
                  'bannerTypeID': 2,
                  'status': [
                    'online',
                  ],
                  'platform': 'app',
                },
                'isShuffle': true,
                'limit': 200,
                'page': 1,
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
              print('result----:: ${result.data}');
              return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: urls.length,
                itemBuilder: (context, index) {
                  return CompanyView(
                    source: urls[index],
                  );
                },
              );
            },
          ),
        )
      ],
    );
  }
}
