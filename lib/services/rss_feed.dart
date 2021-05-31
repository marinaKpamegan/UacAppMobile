import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';

class UacRssService {
  Future<RssFeed> getFeed() =>
      http.read(Uri.parse('https://uac.bj/feed')).then((xmlString) => RssFeed.parse(xmlString));

}