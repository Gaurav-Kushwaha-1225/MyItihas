// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart'
    as _i161;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;
import 'package:talker_flutter/talker_flutter.dart' as _i207;

import '../../features/chat/data/datasources/chat_data_source.dart' as _i799;
import '../../features/chat/domain/repositories/chat_repository.dart' as _i420;
import '../../features/chat/presentation/bloc/chat_detail_bloc.dart' as _i57;
import '../../features/chat/presentation/bloc/chat_list_bloc.dart' as _i2;
import '../../features/notifications/data/datasources/notification_data_source.dart'
    as _i691;
import '../../features/notifications/domain/repositories/notification_repository.dart'
    as _i367;
import '../../features/social/data/datasources/social_data_source.dart'
    as _i1050;
import '../../features/social/data/datasources/user_data_source.dart' as _i773;
import '../../features/social/data/datasources/user_remote_data_source.dart'
    as _i210;
import '../../features/social/data/repositories/post_repository_impl.dart'
    as _i141;
import '../../features/social/data/repositories/social_repository_impl.dart'
    as _i5;
import '../../features/social/data/repositories/user_repository_impl.dart'
    as _i910;
import '../../features/social/domain/repositories/post_repository.dart'
    as _i545;
import '../../features/social/domain/repositories/social_repository.dart'
    as _i640;
import '../../features/social/domain/repositories/user_repository.dart'
    as _i721;
import '../../features/social/presentation/bloc/comment_bloc.dart' as _i62;
import '../../features/social/presentation/bloc/feed_bloc.dart' as _i420;
import '../../features/social/presentation/bloc/notification_bloc.dart'
    as _i506;
import '../../features/social/presentation/bloc/profile_bloc.dart' as _i1068;
import '../../features/stories/data/datasources/story_local_data_source.dart'
    as _i533;
import '../../features/stories/data/datasources/story_mock_data_source.dart'
    as _i746;
import '../../features/stories/data/datasources/story_remote_data_source.dart'
    as _i51;
import '../../features/stories/data/repositories/story_repository_impl.dart'
    as _i262;
import '../../features/stories/domain/repositories/story_repository.dart'
    as _i909;
import '../../features/stories/domain/usecases/get_stories.dart' as _i596;
import '../../features/stories/domain/usecases/get_story_by_id.dart' as _i494;
import '../../features/stories/domain/usecases/toggle_favorite.dart' as _i53;
import '../../features/stories/presentation/bloc/stories_bloc.dart' as _i790;
import '../../services/follow_service.dart' as _i545;
import '../../services/profile_service.dart' as _i637;
import '../../services/profile_storage_service.dart' as _i743;
import '../network/api_client.dart' as _i557;
import '../network/mock_websocket_service.dart' as _i817;
import '../network/network_info.dart' as _i932;
import '../network/websocket_service.dart' as _i436;
import '../storage/hive_service.dart' as _i459;
import 'injection_container.dart' as _i809;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final thirdPartyModule = _$ThirdPartyModule();
    final apiClientModule = _$ApiClientModule();
    final networkModule = _$NetworkModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => thirdPartyModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i454.SupabaseClient>(
      () => thirdPartyModule.supabaseClient,
    );
    gh.lazySingleton<_i207.Talker>(() => thirdPartyModule.logger);
    gh.lazySingleton<_i361.Dio>(() => apiClientModule.dio);
    gh.lazySingleton<_i161.InternetConnection>(
      () => networkModule.connectionChecker,
    );
    gh.lazySingleton<_i459.HiveService>(() => _i459.HiveService());
    gh.lazySingleton<_i746.StoryMockDataSource>(
      () => _i746.StoryMockDataSource(),
    );
    gh.lazySingleton<_i773.UserDataSource>(() => _i773.UserDataSourceImpl());
    gh.lazySingleton<_i932.NetworkInfo>(
      () => _i932.NetworkInfoImpl(gh<_i161.InternetConnection>()),
    );
    gh.lazySingleton<_i51.StoryRemoteDataSource>(
      () => _i51.StoryRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i545.FollowService>(
      () => _i545.FollowService(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i637.ProfileService>(
      () => _i637.ProfileService(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i743.ProfileStorageService>(
      () => _i743.ProfileStorageService(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i210.UserRemoteDataSource>(
      () => _i210.UserRemoteDataSourceSupabase(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i436.WebSocketService>(
      () => _i817.MockWebSocketService(),
    );
    gh.lazySingleton<_i691.NotificationDataSource>(
      () => _i691.NotificationDataSourceImpl(gh<_i773.UserDataSource>()),
    );
    gh.lazySingleton<_i533.StoryLocalDataSource>(
      () => _i533.StoryLocalDataSourceImpl(
        gh<_i459.HiveService>(),
        gh<_i746.StoryMockDataSource>(),
      ),
    );
    gh.lazySingleton<_i909.StoryRepository>(
      () => _i262.StoryRepositoryImpl(
        remoteDataSource: gh<_i51.StoryRemoteDataSource>(),
        localDataSource: gh<_i533.StoryLocalDataSource>(),
        networkInfo: gh<_i932.NetworkInfo>(),
      ),
    );
    gh.lazySingleton<_i1050.SocialDataSource>(
      () => _i1050.SocialDataSourceImpl(gh<_i773.UserDataSource>()),
    );
    gh.factory<_i57.ChatDetailBloc>(
      () => _i57.ChatDetailBloc(
        chatRepository: gh<_i420.ChatRepository>(),
        webSocketService: gh<_i436.WebSocketService>(),
      ),
    );
    gh.factory<_i2.ChatListBloc>(
      () => _i2.ChatListBloc(chatRepository: gh<_i420.ChatRepository>()),
    );
    gh.lazySingleton<_i721.UserRepository>(
      () => _i910.UserRepositoryImpl(
        dataSource: gh<_i210.UserRemoteDataSource>(),
        storageService: gh<_i743.ProfileStorageService>(),
        followService: gh<_i545.FollowService>(),
      ),
    );
    gh.lazySingleton<_i799.ChatDataSource>(
      () => _i799.ChatDataSourceImpl(gh<_i773.UserDataSource>()),
    );
    gh.lazySingleton<_i640.SocialRepository>(
      () => _i5.SocialRepositoryImpl(
        dataSource: gh<_i1050.SocialDataSource>(),
        userRepository: gh<_i721.UserRepository>(),
      ),
    );
    gh.factory<_i1068.ProfileBloc>(
      () => _i1068.ProfileBloc(userRepository: gh<_i721.UserRepository>()),
    );
    gh.factory<_i62.CommentBloc>(
      () => _i62.CommentBloc(socialRepository: gh<_i640.SocialRepository>()),
    );
    gh.lazySingleton<_i596.GetStories>(
      () => _i596.GetStories(gh<_i909.StoryRepository>()),
    );
    gh.lazySingleton<_i494.GetStoryById>(
      () => _i494.GetStoryById(gh<_i909.StoryRepository>()),
    );
    gh.lazySingleton<_i53.ToggleFavorite>(
      () => _i53.ToggleFavorite(gh<_i909.StoryRepository>()),
    );
    gh.lazySingleton<_i545.PostRepository>(
      () => _i141.PostRepositoryImpl(
        userRepository: gh<_i721.UserRepository>(),
        storyRepository: gh<_i909.StoryRepository>(),
      ),
    );
    gh.factory<_i790.StoriesBloc>(
      () => _i790.StoriesBloc(
        getStories: gh<_i596.GetStories>(),
        toggleFavorite: gh<_i53.ToggleFavorite>(),
      ),
    );
    gh.factory<_i506.NotificationBloc>(
      () => _i506.NotificationBloc(
        notificationRepository: gh<_i367.NotificationRepository>(),
        userRepository: gh<_i721.UserRepository>(),
      ),
    );
    gh.factory<_i420.FeedBloc>(
      () => _i420.FeedBloc(
        storyRepository: gh<_i909.StoryRepository>(),
        socialRepository: gh<_i640.SocialRepository>(),
        userRepository: gh<_i721.UserRepository>(),
        postRepository: gh<_i545.PostRepository>(),
      ),
    );
    return this;
  }
}

class _$ThirdPartyModule extends _i809.ThirdPartyModule {}

class _$ApiClientModule extends _i557.ApiClientModule {}

class _$NetworkModule extends _i932.NetworkModule {}
