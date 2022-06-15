import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_news_app/core/network/network_info.dart';
import 'package:flutter_news_app/core/util/helper.dart';
import 'package:flutter_news_app/feature/data/datasource/news/news_remote_data_source.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  Connectivity,
  Dio,
  Helper,
  NewsRemoteDataSource,
  NetworkInfo,
])
void main() {}