import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/feature/data/model/categorynews/category_news_model.dart';
import 'package:flutter_news_app/feature/data/model/topheadlinesnews/top_headlines_news_response_model.dart';
import 'package:flutter_news_app/feature/presentation/bloc/topheadlinesnews/bloc.dart';
import 'package:flutter_news_app/feature/presentation/page/search/search_page.dart';
import 'package:flutter_news_app/feature/presentation/widget/widget_failure_message.dart';
import 'package:flutter_news_app/feature/presentation/widget/widget_item_news.dart';
import 'package:flutter_news_app/injection_container.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final topHeadlinesNewsBloc = sl<TopHeadlinesNewsBloc>();
  final listCategories = <CategoryNewsModel>[
    CategoryNewsModel(image: '', title: 'All'),
    CategoryNewsModel(image: 'assets/images/img_business.png', title: 'Business'),
    CategoryNewsModel(image: 'assets/images/img_entertainment.png', title: 'Entertainment'),
    CategoryNewsModel(image: 'assets/images/img_health.png', title: 'Health'),
    CategoryNewsModel(image: 'assets/images/img_science.png', title: 'Science'),
    CategoryNewsModel(image: 'assets/images/img_sport.png', title: 'Sports'),
    CategoryNewsModel(image: 'assets/images/img_technology.png', title: 'Technology'),
  ];
  final refreshIndicatorState = GlobalKey<RefreshIndicatorState>();

  bool isLoadingCenterIOS = false;
  Completer completerRefresh;
  var indexCategorySelected = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Platform.isIOS) {
        isLoadingCenterIOS = true;
        topHeadlinesNewsBloc.add(
          LoadTopHeadlinesNewsEvent(category: listCategories[indexCategorySelected].title.toLowerCase()),
        );
      } else {
        completerRefresh = Completer();
        refreshIndicatorState.currentState.show();
      }
    });
    super.initState();
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
        child: BlocListener<TopHeadlinesNewsBloc, TopHeadlinesNewsState>(
          listener: (context, state) {
            if (state is FailureTopHeadlinesNewsState) {
              _resetRefreshIndicator();
            } else if (state is LoadedTopHeadlinesNewsState) {
              _resetRefreshIndicator();
            } else if (state is ChangedCategoryTopHeadlinesNewsState) {
              indexCategorySelected = state.indexCategorySelected;
              if (Platform.isIOS) {
                isLoadingCenterIOS = true;
                var category = listCategories[indexCategorySelected].title.toLowerCase();
                topHeadlinesNewsBloc.add(LoadTopHeadlinesNewsEvent(category: category));
              } else {
                refreshIndicatorState.currentState.show();
              }
            }
          },
          child: Container(
            width: double.infinity,
            color: Color(0xFFEFF5F5),
            padding: EdgeInsets.symmetric(
              vertical: 24.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: paddingTop),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 48.w),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          'Daily News',
                          style: TextStyle(
                            fontSize: 48.sp,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SearchPage()),
                          );
                        },
                        child: Hero(
                          tag: 'iconSearch',
                          child: Icon(Icons.search),
                        ),
                      ),
                    ],
                  ),
                ),
                WidgetDateToday(),
                SizedBox(height: 24.h),
                WidgetCategoryNews(listCategories: listCategories),
                SizedBox(height: 24.h),
                Expanded(
                  child: Platform.isIOS ? _buildWidgetContentNewsIOS() : _buildWidgetContentNewsAndroid(),
                ),
                SizedBox(height: paddingBottom),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _resetRefreshIndicator() {
    if (isLoadingCenterIOS) {
      isLoadingCenterIOS = false;
    }
    completerRefresh?.complete();
    completerRefresh = Completer();
  }

  Widget _buildWidgetContentNewsIOS() {
    return BlocBuilder<TopHeadlinesNewsBloc, TopHeadlinesNewsState>(
      builder: (context, state) {
        var listArticles = <ItemArticleTopHeadlinesNewsResponseModel>[];
        if (state is LoadedTopHeadlinesNewsState) {
          listArticles.addAll(state.listArticles);
        } else if (isLoadingCenterIOS) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        }
        return Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 48.w),
              child: CustomScrollView(
                physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                slivers: <Widget>[
                  CupertinoSliverRefreshControl(
                    onRefresh: () {
                      topHeadlinesNewsBloc.add(
                        LoadTopHeadlinesNewsEvent(category: listCategories[indexCategorySelected].title.toLowerCase()),
                      );
                      return completerRefresh.future;
                    },
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        var itemArticle = listArticles[index];
                        var dateTimePublishedAt =
                            DateFormat('yyyy-MM-ddTHH:mm:ssZ').parse(itemArticle.publishedAt, true);
                        var strPublishedAt = DateFormat('MMM dd, yyyy HH:mm').format(dateTimePublishedAt);
                        if (index == 0) {
                          return _buildWidgetItemLatestNews(itemArticle, strPublishedAt);
                        } else {
                          return _buildWidgetItemNews(index, itemArticle, strPublishedAt);
                        }
                      },
                      childCount: listArticles.length,
                    ),
                  ),
                ],
              ),
            ),
            listArticles.isEmpty && state is! LoadingTopHeadlinesNewsState
                ? _buildWidgetFailureLoadData()
                : Container(),
          ],
        );
      },
    );
  }

  Widget _buildWidgetContentNewsAndroid() {
    return BlocBuilder<TopHeadlinesNewsBloc, TopHeadlinesNewsState>(
      builder: (context, state) {
        var listArticles = <ItemArticleTopHeadlinesNewsResponseModel>[];
        if (state is LoadedTopHeadlinesNewsState) {
          listArticles.addAll(state.listArticles);
        }
        return Stack(
          children: <Widget>[
            RefreshIndicator(
              key: refreshIndicatorState,
              onRefresh: () {
                topHeadlinesNewsBloc.add(
                  LoadTopHeadlinesNewsEvent(category: listCategories[indexCategorySelected].title.toLowerCase()),
                );
                return completerRefresh.future;
              },
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 48.w),
                itemBuilder: (context, index) {
                  var itemArticle = listArticles[index];
                  var dateTimePublishedAt = DateFormat('yyyy-MM-ddTHH:mm:ssZ').parse(itemArticle.publishedAt, true);
                  var strPublishedAt = DateFormat('MMM dd, yyyy HH:mm').format(dateTimePublishedAt);
                  if (index == 0) {
                    return _buildWidgetItemLatestNews(itemArticle, strPublishedAt);
                  } else {
                    return _buildWidgetItemNews(index, itemArticle, strPublishedAt);
                  }
                },
                itemCount: listArticles.length,
              ),
            ),
            listArticles.isEmpty && state is FailureTopHeadlinesNewsState ? _buildWidgetFailureLoadData() : Container(),
          ],
        );
      },
    );
  }

  Widget _buildWidgetFailureLoadData() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          WidgetFailureMessage(),
          RaisedButton(
            onPressed: () {
              if (Platform.isIOS) {
                isLoadingCenterIOS = true;
                topHeadlinesNewsBloc.add(
                  LoadTopHeadlinesNewsEvent(category: listCategories[indexCategorySelected].title.toLowerCase()),
                );
              } else {
                refreshIndicatorState.currentState.show();
              }
            },
            child: Text(
              'Try Again'.toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 36.sp,
              ),
            ),
            color: Colors.grey[700],
          ),
        ],
      ),
    );
  }

  Widget _buildWidgetItemNews(
    int index,
    ItemArticleTopHeadlinesNewsResponseModel itemArticle,
    String strPublishedAt,
  ) {
    return Padding(
      padding: EdgeInsets.only(
        top: index == 1 ? 32.h : 16.h,
        bottom: 16.h,
      ),
      child: WidgetItemNews(
        itemArticle: itemArticle,
        strPublishedAt: strPublishedAt,
      ),
    );
  }

  Widget _buildWidgetItemLatestNews(
    ItemArticleTopHeadlinesNewsResponseModel itemArticle,
    String strPublishedAt,
  ) {
    return GestureDetector(
      onTap: () {
        // TODO: buat fitur arahkan ke website detail berita
      },
      child: Container(
        width: double.infinity,
        height: ScreenUtil.screenHeightDp / 3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          image: DecorationImage(
            image: NetworkImage(
              itemArticle.urlToImage,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: ScreenUtil.screenHeightDp / 3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black,
                    Colors.black.withOpacity(0.0),
                  ],
                  stops: [
                    0.0,
                    1.0,
                  ],
                ),
              ),
              padding: EdgeInsets.all(48.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.pink,
                      borderRadius: BorderRadius.circular(48),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 28.w,
                      vertical: 14.w,
                    ),
                    child: Text(
                      'Latest News',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    itemArticle.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 42.sp,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        strPublishedAt,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 24.sp,
                        ),
                      ),
                      Text(
                        ' | ',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 28.sp,
                        ),
                      ),
                      Text(
                        itemArticle.source.name,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 24.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WidgetCategoryNews extends StatefulWidget {
  final List<CategoryNewsModel> listCategories;

  WidgetCategoryNews({@required this.listCategories});

  @override
  _WidgetCategoryNewsState createState() => _WidgetCategoryNewsState();
}

class _WidgetCategoryNewsState extends State<WidgetCategoryNews> {
  int indexCategorySelected;

  @override
  void initState() {
    indexCategorySelected = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 48.w),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          var itemCategory = widget.listCategories[index];
          return Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? 0 : 12.w,
              right: index == widget.listCategories.length - 1 ? 0 : 12.w,
            ),
            child: GestureDetector(
              onTap: () {
                if (indexCategorySelected == index) {
                  return;
                }
                setState(() {
                  indexCategorySelected = index;
                });
                var topHeadlinesNewsBloc = BlocProvider.of<TopHeadlinesNewsBloc>(context);
                topHeadlinesNewsBloc
                    .add(ChangeCategoryTopHeadlinesNewsEvent(indexCategorySelected: indexCategorySelected));
              },
              child: Container(
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  padding: EdgeInsets.symmetric(
                    horizontal: itemCategory.title.toLowerCase() == 'all' ? 48.w : 32.w,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(indexCategorySelected == index ? 0.2 : 0.6),
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                    border: indexCategorySelected == index
                        ? Border.all(
                            color: Colors.white,
                            width: 2.0,
                          )
                        : null,
                  ),
                  child: Center(
                    child: Text(
                      itemCategory.title,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: itemCategory.title.toLowerCase() == 'all' ? Color(0xFFBBCDDC) : null,
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                  image: itemCategory.title.toLowerCase() == 'all'
                      ? null
                      : DecorationImage(
                          image: AssetImage(
                            itemCategory.image,
                          ),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
          );
        },
        itemCount: widget.listCategories.length,
      ),
    );
  }
}

class WidgetDateToday extends StatefulWidget {
  @override
  _WidgetDateTodayState createState() => _WidgetDateTodayState();
}

class _WidgetDateTodayState extends State<WidgetDateToday> {
  String strToday;

  @override
  void initState() {
    strToday = DateFormat('EEEE, MMM dd, yyyy').format(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 48.w),
      child: Text(
        strToday,
        style: TextStyle(
          fontSize: 28.sp,
          color: Colors.grey,
        ),
      ),
    );
  }
}
