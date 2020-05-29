import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/feature/presentation/bloc/topheadlinesnews/bloc.dart';
import 'package:flutter_news_app/feature/presentation/widget/widget_failure_message.dart';
import 'package:flutter_news_app/feature/presentation/widget/widget_item_news.dart';
import 'package:flutter_news_app/injection_container.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final topHeadlinesNewsBloc = sl<TopHeadlinesNewsBloc>();
  final controllerKeyword = TextEditingController();
  final focusNodeIconSearch = FocusNode();
  String keyword;
  Timer debounce;

  @override
  void initState() {
    keyword = '';
    controllerKeyword.addListener(_onSearching);
    super.initState();
  }

  @override
  void dispose() {
    focusNodeIconSearch.dispose();
    controllerKeyword.removeListener(_onSearching);
    controllerKeyword.dispose();
    debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    var mediaQueryData = MediaQuery.of(context);
    var paddingTop = mediaQueryData.padding.top;
    var paddingBottom = mediaQueryData.padding.bottom;
    return Scaffold(
      body: BlocProvider<TopHeadlinesNewsBloc>(
        create: (context) => topHeadlinesNewsBloc,
        child: Container(
          color: Color(0xFFEFF5F5),
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: 48.w,
            vertical: 24.h,
          ),
          child: Column(
            children: <Widget>[
              SizedBox(height: paddingTop),
              Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
                    ),
                  ),
                  SizedBox(width: 24.w),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(99.0),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 36.w),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              controller: controllerKeyword,
                              decoration: InputDecoration(
                                isDense: true,
                                hintText: 'Searching something?',
                                hintStyle: TextStyle(
                                  fontSize: 36.sp,
                                  color: Colors.grey,
                                ),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                              style: TextStyle(
                                fontSize: 36.sp,
                              ),
                            ),
                          ),
                          Hero(
                            tag: 'iconSearch',
                            child: Focus(
                              focusNode: focusNodeIconSearch,
                              child: Icon(
                                Icons.search,
                                size: 48.w,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: BlocBuilder<TopHeadlinesNewsBloc, TopHeadlinesNewsState>(
                  builder: (context, state) {
                    if (state is LoadingTopHeadlinesNewsState) {
                      return Center(
                        child: Platform.isIOS ? CupertinoActivityIndicator() : CircularProgressIndicator(),
                      );
                    } else if (state is FailureTopHeadlinesNewsState) {
                      return WidgetFailureMessage();
                    } else if (state is SearchSuccessTopHeadlinesNewsState) {
                      var listArticles = state.listArticles;
                      if (listArticles.isEmpty) {
                        return WidgetFailureMessage(
                          errorTitle: 'Data not found',
                          errorSubtitle: 'Hm, we couldn\'t find what you were looking for.',
                        );
                      } else {
                        return ListView.builder(
                          padding: EdgeInsets.only(bottom: paddingBottom),
                          itemBuilder: (context, index) {
                            var itemArticle = listArticles[index];
                            var dateTimePublishedAt =
                                DateFormat('yyy-MM-ddTHH:mm:ssZ').parse(itemArticle.publishedAt, true);
                            var strPublishedAt = DateFormat('MMM dd, yyyy HH:mm').format(dateTimePublishedAt);
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              child: WidgetItemNews(
                                itemArticle: itemArticle,
                                strPublishedAt: strPublishedAt,
                              ),
                            );
                          },
                          itemCount: listArticles.length,
                        );
                      }
                    }
                    return Container();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onSearching() {
    if (debounce?.isActive ?? false) {
      debounce.cancel();
    }
    debounce = Timer(Duration(milliseconds: 800), () {
      var keyword = controllerKeyword.text.trim();
      if (keyword.isEmpty || this.keyword == keyword) {
        return;
      }
      this.keyword = keyword;
      focusNodeIconSearch.requestFocus();
      topHeadlinesNewsBloc.add(SearchTopHeadlinesNewsEvent(keyword: keyword));
    });
  }
}
