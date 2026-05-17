import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

class ApiCacheManager {
  static CacheOptions get cacheOptions => CacheOptions(
    store: MemCacheStore(),
    policy: CachePolicy.request,
    //hitCacheOnErrorCodes: [401, 403,500],
    maxStale: const Duration(days: 1),
    priority: CachePriority.normal,
    cipher: null,
    keyBuilder: CacheOptions.defaultCacheKeyBuilder,
    allowPostMethod: false,
  );

  static DioCacheInterceptor get cacheInterceptor => 
      DioCacheInterceptor(options: cacheOptions);
}
