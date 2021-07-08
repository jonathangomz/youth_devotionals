import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:young_devotionals/bloc/daily_controller.dart';
import 'package:young_devotionals/bloc/scroll_controller.dart';

class MyHomePage extends StatelessWidget {
  final DailyController _today = Get.put(DailyController());
  final ScrollCtrl _scroll = Get.put(ScrollCtrl());

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: Obx(
        () => Scaffold(
          body: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverAppBar(
                forceElevated: true,
                pinned: true,
                snap: false,
                floating: false,
                expandedHeight: 180,
                stretch: false,
                stretchTriggerOffset: 200,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    _today.devotional.value.title,
                    textAlign: TextAlign.center,
                  ),
                  stretchModes: [
                    StretchMode.zoomBackground,
                    StretchMode.blurBackground,
                    StretchMode.fadeTitle,
                  ],
                  centerTitle: true,
                ),
                bottom: PreferredSize(
                  child: LinearProgressIndicator(
                    value: _scroll.percentage.value,
                    minHeight: 4,
                  ),
                  preferredSize: Size(double.infinity, 4),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(this._today.isLoading.value
                    ? [
                        Padding(
                            padding: EdgeInsets.only(top: 38),
                            child: Center(child: CircularProgressIndicator()))
                      ]
                    : [
                        if (this._today.devotional.value.vers.isNotEmpty)
                          Container(
                            margin: EdgeInsets.all(26),
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                border: Border.all(
                                  width: 2,
                                  color: Colors.blue,
                                ),
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0, 1),
                                    blurRadius: 2,
                                    color: Colors.grey,
                                  )
                                ]),
                            child: Text(
                              _today.devotional.value.vers,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ..._today.devotional.value.content
                            .map((paragraph) => Padding(
                                  padding: EdgeInsets.only(
                                      left: 24, right: 24, top: 0, bottom: 18),
                                  child: Text(
                                    paragraph,
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ))
                            .toList(),
                      ]),
              ),
            ],
            controller: _scroll.controller.value,
          ),
        ),
      ),
      onRefresh: () async => _today.refreshDailyDevotional(),
    );
  }
}
