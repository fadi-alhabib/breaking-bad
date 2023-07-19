import 'package:flutter/material.dart';

class CharachterDetailsScreen extends StatelessWidget {
  final selectedCharachter;

  const CharachterDetailsScreen({Key? key, this.selectedCharachter})
      : super(key: key);

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          selectedCharachter.nickName,
          style: TextStyle(color: Colors.white),
        ),
        background: Hero(
          tag: selectedCharachter.charId,
          child: Image.network(
            selectedCharachter.image.toString(),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget charachterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(children: [
        TextSpan(
          text: title,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        TextSpan(
          text: value,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ]),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      height: 30,
      color: Colors.yellow.shade800,
      endIndent: endIndent,
      thickness: 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      body: CustomScrollView(
        // physics: BouncingScrollPhysics(),
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    charachterInfo(
                        "Job : ", selectedCharachter.jobs.join(" / ")),
                    buildDivider(MediaQuery.of(context).size.width * 0.8),
                    charachterInfo(
                        "Appeared in : ", selectedCharachter.categoryForSeries),
                    buildDivider(MediaQuery.of(context).size.width * 0.65),
                    charachterInfo("Seasons : ",
                        selectedCharachter.appearanceOfSeasons.join(" / ")),
                    buildDivider(MediaQuery.of(context).size.width * 0.7),
                    charachterInfo(
                        "Status : ", selectedCharachter.livingStatus),
                    buildDivider(MediaQuery.of(context).size.width * 0.75),
                    selectedCharachter.betterCallSaulAppearance.isEmpty
                        ? Container()
                        : charachterInfo(
                            "Better Call Saul Seasons : ",
                            selectedCharachter.betterCallSaulAppearance
                                .join(" / ")),
                    selectedCharachter.betterCallSaulAppearance.isEmpty
                        ? Container()
                        : buildDivider(MediaQuery.of(context).size.width * 0.4),
                    charachterInfo(
                        "Actor/Actress : ", selectedCharachter.actorName),
                    buildDivider(MediaQuery.of(context).size.width * 0.6),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
