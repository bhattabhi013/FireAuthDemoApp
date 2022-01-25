import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CacheDemo extends StatefulWidget {
  const CacheDemo({Key? key}) : super(key: key);
  static const routeName = "/cache-demo";

  @override
  State<CacheDemo> createState() => _CacheDemoState();
}

class _CacheDemoState extends State<CacheDemo> {
  bool _isGridView = false;
  // static final customCache = CacheManager(Config(
  //   'CustomCache',
  //   // stalePeriod: Duration(days: 30)
  // ),);
  void clearCache() {
    DefaultCacheManager().emptyCache();
    // imageCache!.clear();
    // imageCache!.clearLiveImages();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo"),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
              });
              // Navigator.of(context).pushNamed(.routeName);
            },
            icon: (_isGridView) ? Icon(Icons.list) : Icon(Icons.grid_3x3),
          ),
          IconButton(
            onPressed: () {
              clearCache();
            },
            icon: Icon(Icons.clear),
          ),
        ],
      ),
      body: Container(
        child: (!_isGridView)
            ? ListView.builder(
                itemBuilder: (BuildContext context, int index) => Card(
                  child: Column(
                    children: <Widget>[
                      CachedNetworkImage(
                        // maxHeightDiskCache: 150,
                        key: UniqueKey(),
                        imageUrl:
                            'https://loremflickr.com/320/240/music?lock=$index',
                        placeholder: (BuildContext context, String url) =>
                            Container(
                          width: 320,
                          height: 240,
                          color: Colors.purple,
                        ),
                      ),
                    ],
                  ),
                ),
                itemCount: 20,
              )
            : GridView.builder(
                itemCount: 20,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) =>
                    CachedNetworkImage(
                  key: UniqueKey(),
                  imageUrl: 'https://loremflickr.com/100/100/music?lock=$index',
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
      ),
    );
  }
}
