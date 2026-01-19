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
import '../../features/home/data/datasources/activity_local_datasource.dart'
    as _i922;
import '../../features/home/data/datasources/quote_local_datasource.dart'
    as _i908;
import '../../features/home/presentation/bloc/home_bloc.dart' as _i202;
import '../../features/notifications/data/datasources/notification_data_source.dart'
    as _i691;
import '../../features/notifications/domain/repositories/notification_repository.dart'
    as _i367;
import '../../features/social/data/datasources/social_data_source.dart'
    as _i1050;
import '../../features/social/data/datasources/social_remote_data_source.dart'
    as _i744;
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
import '../../features/social/presentation/bloc/create_post_bloc.dart' as _i623;
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
import '../../features/story_generator/data/datasources/datasource_module.dart'
    as _i561;
import '../../features/story_generator/data/datasources/mock_story_generator_datasource.dart'
    as _i625;
import '../../features/story_generator/data/datasources/remote_story_generator_datasource.dart'
    as _i150;
import '../../features/story_generator/data/repositories/story_generator_repository_impl.dart'
    as _i720;
import '../../features/story_generator/domain/repositories/story_generator_repository.dart'
    as _i277;
import '../../features/story_generator/domain/usecases/expand_story.dart'
    as _i880;
import '../../features/story_generator/domain/usecases/generate_story.dart'
    as _i688;
import '../../features/story_generator/domain/usecases/generate_story_image.dart'
    as _i21;
import '../../features/story_generator/domain/usecases/get_character_details.dart'
    as _i771;
import '../../features/story_generator/domain/usecases/get_generated_stories.dart'
    as _i733;
import '../../features/story_generator/domain/usecases/like_story.dart'
    as _i961;
import '../../features/story_generator/domain/usecases/randomize_options.dart'
    as _i445;
import '../../features/story_generator/domain/usecases/update_generated_story.dart'
    as _i31;
import '../../features/story_generator/presentation/bloc/story_detail_bloc.dart'
    as _i324;
import '../../features/story_generator/presentation/bloc/story_generator_bloc.dart'
    as _i177;
import '../../services/chat_service.dart' as _i207;
import '../../services/follow_service.dart' as _i545;
import '../../services/notification_service.dart' as _i85;
import '../../services/post_service.dart' as _i90;
import '../../services/profile_service.dart' as _i637;
import '../../services/profile_storage_service.dart' as _i743;
import '../../services/reading_progress_service.dart' as _i277;
import '../../services/realtime_service.dart' as _i253;
import '../../services/social_service.dart' as _i558;
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
    final storyGeneratorDataSourceModule = _$StoryGeneratorDataSourceModule();
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
    gh.lazySingleton<_i922.ActivityLocalDataSource>(
      () => _i922.ActivityLocalDataSource(),
    );
    gh.lazySingleton<_i908.QuoteLocalDataSource>(
      () => _i908.QuoteLocalDataSource(),
    );
    gh.lazySingleton<_i746.StoryMockDataSource>(
      () => _i746.StoryMockDataSource(),
    );
    gh.lazySingleton<_i625.MockStoryGeneratorDataSource>(
      () => storyGeneratorDataSourceModule.mockDataSource,
    );
    gh.lazySingleton<_i277.ReadingProgressService>(
      () => _i277.ReadingProgressService(),
    );
    gh.lazySingleton<_i1050.SocialDataSource>(
      () => _i744.SocialRemoteDataSource(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i773.UserDataSource>(() => _i773.UserDataSourceImpl());
    gh.lazySingleton<_i932.NetworkInfo>(
      () => _i932.NetworkInfoImpl(gh<_i161.InternetConnection>()),
    );
    gh.lazySingleton<_i51.StoryRemoteDataSource>(
      () => _i51.StoryRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i207.ChatService>(
      () => _i207.ChatService(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i545.FollowService>(
      () => _i545.FollowService(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i85.NotificationService>(
      () => _i85.NotificationService(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i90.PostService>(
      () => _i90.PostService(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i637.ProfileService>(
      () => _i637.ProfileService(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i743.ProfileStorageService>(
      () => _i743.ProfileStorageService(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i253.RealtimeService>(
      () => _i253.RealtimeService(gh<_i454.SupabaseClient>()),
      dispose: (i) => i.dispose(),
    );
    gh.lazySingleton<_i558.SocialService>(
      () => _i558.SocialService(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i210.UserRemoteDataSource>(
      () => _i210.UserRemoteDataSourceSupabase(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i150.RemoteStoryGeneratorDataSource>(
      () => _i150.RemoteStoryGeneratorDataSource(gh<_i361.Dio>()),
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
    gh.factory<_i623.CreatePostBloc>(
      () => _i623.CreatePostBloc(gh<_i90.PostService>()),
    );
    gh.lazySingleton<_i277.StoryGeneratorRepository>(
      () => _i720.StoryGeneratorRepositoryImpl(
        gh<_i150.RemoteStoryGeneratorDataSource>(),
        gh<_i625.MockStoryGeneratorDataSource>(),
      ),
    );
    gh.lazySingleton<_i909.StoryRepository>(
      () => _i262.StoryRepositoryImpl(
        remoteDataSource: gh<_i51.StoryRemoteDataSource>(),
        localDataSource: gh<_i533.StoryLocalDataSource>(),
        networkInfo: gh<_i932.NetworkInfo>(),
      ),
    );
    gh.factory<_i57.ChatDetailBloc>(
      () => _i57.ChatDetailBloc(
        chatRepository: gh<_i420.ChatRepository>(),
        webSocketService: gh<_i436.WebSocketService>(),
      ),
    );
    gh.factory<_i324.StoryDetailBloc>(
      () => _i324.StoryDetailBloc(gh<_i277.StoryGeneratorRepository>()),
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
    gh.factory<_i202.HomeBloc>(
      () => _i202.HomeBloc(
        gh<_i908.QuoteLocalDataSource>(),
        gh<_i277.ReadingProgressService>(),
        gh<_i277.StoryGeneratorRepository>(),
        gh<_i721.UserRepository>(),
      ),
    );
    gh.lazySingleton<_i880.ExpandStory>(
      () => _i880.ExpandStory(gh<_i277.StoryGeneratorRepository>()),
    );
    gh.lazySingleton<_i688.GenerateStory>(
      () => _i688.GenerateStory(gh<_i277.StoryGeneratorRepository>()),
    );
    gh.lazySingleton<_i21.GenerateStoryImage>(
      () => _i21.GenerateStoryImage(gh<_i277.StoryGeneratorRepository>()),
    );
    gh.lazySingleton<_i771.GetCharacterDetails>(
      () => _i771.GetCharacterDetails(gh<_i277.StoryGeneratorRepository>()),
    );
    gh.lazySingleton<_i733.GetGeneratedStories>(
      () => _i733.GetGeneratedStories(gh<_i277.StoryGeneratorRepository>()),
    );
    gh.lazySingleton<_i961.LikeStory>(
      () => _i961.LikeStory(gh<_i277.StoryGeneratorRepository>()),
    );
    gh.lazySingleton<_i445.RandomizeOptions>(
      () => _i445.RandomizeOptions(gh<_i277.StoryGeneratorRepository>()),
    );
    gh.lazySingleton<_i31.UpdateGeneratedStory>(
      () => _i31.UpdateGeneratedStory(gh<_i277.StoryGeneratorRepository>()),
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
        gh<_i90.PostService>(),
        gh<_i558.SocialService>(),
        gh<_i909.StoryRepository>(),
      ),
    );
    gh.factory<_i177.StoryGeneratorBloc>(
      () => _i177.StoryGeneratorBloc(
        generateStory: gh<_i688.GenerateStory>(),
        generateStoryImage: gh<_i21.GenerateStoryImage>(),
        getGeneratedStories: gh<_i733.GetGeneratedStories>(),
        randomizeOptions: gh<_i445.RandomizeOptions>(),
      ),
    );
    gh.factory<_i420.FeedBloc>(
      () => _i420.FeedBloc(
        storyRepository: gh<_i909.StoryRepository>(),
        socialRepository: gh<_i640.SocialRepository>(),
        userRepository: gh<_i721.UserRepository>(),
        postRepository: gh<_i545.PostRepository>(),
        realtimeService: gh<_i253.RealtimeService>(),
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
    return this;
  }
}

class _$ThirdPartyModule extends _i809.ThirdPartyModule {}

class _$ApiClientModule extends _i557.ApiClientModule {}

class _$NetworkModule extends _i932.NetworkModule {}

class _$StoryGeneratorDataSourceModule
    extends _i561.StoryGeneratorDataSourceModule {}
