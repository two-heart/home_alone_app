import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:home_alone/dependency_injection/locator.dart';
import 'package:home_alone/model/category.dart';
import 'package:home_alone/model/challenge.dart';
import 'package:home_alone/service/challenge/challenge_api.dart';
import 'package:home_alone/view/widgets/categories/discover_challenge_tile.dart';
import 'package:home_alone/view/widgets/challenge/challenge_tile.dart';
import 'package:home_alone/view/widgets/themed_text.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';

import 'challenge_detail_page.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with AutomaticKeepAliveClientMixin {
  Map<Category, List<Challenge>> data = Map<Category, List<Challenge>>();
  RefreshController refreshController;
  bool isLoading = false;

  List<Category> allCategories;

  @override
  void initState() {
    super.initState();
    refreshController = RefreshController();
    allCategories = [];
    data = Map<Category, List<Challenge>>();
    _onRefresh();
  }

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }

  void _onRefresh() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 2));
    final api = locator.get<ChallengeApi>();
    api
        .getSubscribedChallenges()
        .then((challenges) => setState(() {
              this.data = groupBy<Challenge, Category>(
                  challenges, (value) => value.category);
              this.allCategories = challenges.map((c) => c.category).toList();
              refreshController.refreshCompleted();
            }))
        .catchError((_) => refreshController.refreshFailed())
        .whenComplete(() => {
              setState(() {
                isLoading = false;
              })
            });
  }

  Widget _buildShimmerEffect() {
    return Container(
        padding: EdgeInsets.all(25.0),
        child: Center(
          child: Shimmer.fromColors(
              direction: ShimmerDirection.ltr,
              period: Duration(seconds: 2),
              child: Column(
                children: [0, 1, 2, 3, 4, 5, 6]
                    .map((_) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 48.0,
                                height: 48.0,
                                color: Colors.white,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 8.0,
                                      color: Colors.white,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2.0),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: 8.0,
                                      color: Colors.white,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2.0),
                                    ),
                                    Container(
                                      width: 40.0,
                                      height: 8.0,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ))
                    .toList(),
              ),
              baseColor: Colors.grey[350],
              highlightColor: Colors.grey[100]),
        ));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SmartRefresher(
      controller: refreshController,
      onRefresh: _onRefresh,
      child: isLoading ? _buildShimmerEffect() : buildChallengeLists(),
    );
  }

  Widget buildChallengeLists() {
    final listViews = <Widget>[];
    data.forEach((category, challenges) => listViews.add(Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    child: Icon(Icons.work),
                    padding: EdgeInsets.only(left: 4.0),
                  ),
                  Padding(
                    child: ThemedText(
                      fontSize: 16,
                      text: category.name,
                      textAlign: TextAlign.left,
                    ),
                    padding: EdgeInsets.only(left: 8),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 4),
              child: SizedBox(
                height: 180,
                child: ListView.builder(
                  physics: ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: challenges.length,
                  itemBuilder: (BuildContext context, int index) =>
                      DiscoverChallengeTile(challenges[index]),
                ),
              ),
            )
          ],
        )));

    return SingleChildScrollView(
        child: Padding(
      child: Column(mainAxisSize: MainAxisSize.min, children: listViews),
      padding: EdgeInsets.all(8.0),
    ));
  }

  @override
  bool get wantKeepAlive => true;
}
