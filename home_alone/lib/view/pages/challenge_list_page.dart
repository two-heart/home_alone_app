import 'package:flutter/material.dart';
import 'package:home_alone/dependency_injection/locator.dart';
import 'package:home_alone/model/challenge.dart';
import 'package:home_alone/service/challenge/challenge_api.dart';
import 'package:home_alone/view/widgets/categories/discover_challenge_tile.dart';
import 'package:home_alone/view/widgets/challenge/challenge_tile.dart';
import 'package:home_alone/view/widgets/themed_text.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';

class ChallengeListPage extends StatefulWidget {
  @override
  _ChallengeListPageState createState() => _ChallengeListPageState();
}

class _ChallengeListPageState extends State<ChallengeListPage>
    with AutomaticKeepAliveClientMixin {
  List<Challenge> data = [];
  List<Challenge> acceptedChallenges = [];
  List<Challenge> finishedChallenges = [];
  RefreshController refreshController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshController = RefreshController();
    data = [];
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
        .getAcceptedChallenges()
        .then((challenges) => setState(() {
              data = challenges;
              acceptedChallenges = challenges
                  .where((x) =>
                      (x.finished == null || x.finished == false) &&
                      x.accepted != null &&
                      x.accepted == true)
                  .toList();
              finishedChallenges = data
                  .where((x) => x.finished != null && x.finished == true)
                  .toList();
              refreshController.refreshCompleted();
            }))
        .catchError((_) => refreshController.refreshFailed())
        .whenComplete(() => {
              setState(() {
                isLoading = false;
              })
            });
  }

  Widget _renderShimmer() {
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
    return SmartRefresher(
      controller: refreshController,
      onRefresh: _onRefresh,
      child: isLoading ? _renderShimmer() : _renderContent(context),
    );
  }

  Widget _renderCaption(String text) {
    return Padding(
      padding: EdgeInsets.only(left: 8.0, top: 16.0),
      child: Container(
        width: double.infinity,
        child: ThemedText(
          text: text,
          color: Color(0xFF00AB96),
          textAlign: TextAlign.start,
          fontSize: 16.0,
        ),
      ),
    );
  }

  Widget _renderContent(BuildContext context) {
    return ListView(
      children: <Widget>[
        Column(
          children: [
            _renderCaption("Geschafft!"),
            SizedBox(
                height: 160,
                child: finishedChallenges.length == 0
                    ? Text('Noch keine Challenges abgeschlossen')
                    : ListView.builder(
                        physics: ClampingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: finishedChallenges.length,
                        itemBuilder: (context, index) {
                          return DiscoverChallengeTile(
                            finishedChallenges[index],
                            () {},
                            width: 250,
                            fromAcceptedChallenges: true,
                          );
                        }))
          ],
        ),
        Column(
          children: <Widget>[
            _renderCaption("Offene Challenges"),
            acceptedChallenges.length == 0
                ? Text('Noch keine Challenges begonnen')
                : ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: acceptedChallenges.length,
                    itemBuilder: (context, index) {
                      return DiscoverChallengeTile(
                        acceptedChallenges[index],
                        () {},
                        fromAcceptedChallenges: true,
                      );
                    }),
          ],
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
