import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:young_devotionals/bloc/daily_controller.dart';
import 'package:young_devotionals/bloc/scroll_controller.dart';
import 'package:young_devotionals/bloc/reader_theme_controller.dart';
import 'package:young_devotionals/ui/pages/Analytics.dart';

class DailyDevotional extends StatelessWidget {
  final DailyController _today = Get.put(DailyController());
  final ReadController _read = Get.put(ReadController());
  final ThemeReaderController _readerTheme = Get.put(ThemeReaderController());

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: Obx(() => this._readerTheme.isLoaded.value
          ? Scaffold(
              drawer: Drawer(
                child: ListView(
                  children: [
                    GestureDetector(
                      onTap: () => Get.to(() => Analytics()),
                      child: Card(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 24),
                          child: Column(
                            children: [
                              Icon(Icons.analytics),
                              Text('Analíticas'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              body: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    backgroundColor: Color(0xFF0A2E40),
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
                          color: Color(0xFF0A2E40),
                          itemBuilder: (BuildContext context) {
                            return <PopupMenuEntry>[
                              PopupMenuItem(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                              PopupMenuItem(
                                child: Center(
                                  child: IconButton(
                                    icon: Obx(
                                      () => Icon(
                                        Icons.lightbulb,
                                        color: this._readerTheme.isDarkMode
                                            ? Colors.yellow
                                            : Colors.grey,
                                      ),
                                    ),
                                    onPressed: () {
                                      this._readerTheme.themeMode(
                                          this._readerTheme.isDarkMode
                                              ? ThemeMode.light
                                              : ThemeMode.dark);
                                      Get.changeThemeMode(
                                          this._readerTheme.themeMode.value);
                                    },
                                  ),
                                ),
                              ),
                            ];
                          }),
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
                    delegate: SliverChildListDelegate(this
                            ._today
                            .isLoading
                            .value
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
            )
          : Center(
              child: CircularProgressIndicator(),
            )),
      onRefresh: () async => _today.refreshDailyDevotional(),
    );
  }
}
