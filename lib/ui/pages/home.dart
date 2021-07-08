import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:young_devotionals/bloc/daily_controller.dart';
import 'package:young_devotionals/bloc/scroll_controller.dart';
import 'package:young_devotionals/bloc/reader_theme_controller.dart';

class DailyDevotional extends StatelessWidget {
  final DailyController _today = Get.put(DailyController());
  final ReadController _read = Get.put(ReadController());
  final ThemeReaderController _readerTheme = Get.put(ThemeReaderController());

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
                  centerTitle: true,
                ),
                actions: [
                  PopupMenuButton(
                    itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                      PopupMenuItem(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: OutlinedButton(
                                child: Icon(Icons.add),
                                onPressed: () =>
                                    this._readerTheme.increaseFont(),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: OutlinedButton(
                                child: Icon(Icons.remove),
                                onPressed: () =>
                                    this._readerTheme.decreaseFont(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
                bottom: PreferredSize(
                  child: LinearProgressIndicator(
                    color: Theme.of(context).accentColor,
                    value: _read.percentage.value,
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
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      ]
                    : [
                        if (this._today.devotional.value.vers.isNotEmpty)
                          Container(
                            margin: EdgeInsets.all(26),
                            padding: EdgeInsets.all(36),
                            decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                border: Border.all(
                                  width: 2,
                                  color: Theme.of(context).accentColor,
                                ),
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0, 1),
                                    blurRadius: 4,
                                    color: Theme.of(context).shadowColor,
                                  )
                                ]),
                            child: Text(
                              _today.devotional.value.vers,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: this._readerTheme.fontSize.value,
                              ),
                            ),
                          ),
                        ..._today.devotional.value.content
                            .map((paragraph) => Padding(
                                  padding: EdgeInsets.only(
                                    left: 24,
                                    right: 24,
                                    top: 0,
                                    bottom: 18,
                                  ),
                                  child: Text(
                                    paragraph,
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      fontSize:
                                          this._readerTheme.fontSize.value,
                                    ),
                                  ),
                                ))
                            .toList(),
                      ]),
              ),
            ],
            controller: _read.controller.value,
          ),
        ),
      ),
      onRefresh: () async => _today.refreshDailyDevotional(),
    );
  }
}
