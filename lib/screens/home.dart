import 'package:flutter/material.dart';
import 'package:my_app_flutter/components/topCompany.dart';
import 'package:my_app_flutter/components/popularSearch.dart';
import 'package:my_app_flutter/utilities/hexColor.dart';
import 'package:my_app_flutter/screens/jobList.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static String src = 'https://i.ytimg.com/vi/UZ5QN9l7czk/maxresdefault.jpg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
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
      ),
    );
  }
}
