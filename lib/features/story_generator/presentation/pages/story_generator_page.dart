import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:myitihas/core/di/injection_container.dart';
import 'package:myitihas/features/story_generator/domain/entities/quick_prompt.dart';
import 'package:myitihas/features/story_generator/presentation/bloc/story_generator_bloc.dart';
import 'package:myitihas/features/story_generator/presentation/widgets/widgets.dart';
import 'package:myitihas/i18n/strings.g.dart';

/// Main page for the Story Generator feature
class StoryGeneratorPage extends StatelessWidget {
  const StoryGeneratorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<StoryGeneratorBloc>()
            ..add(const StoryGeneratorEvent.initialize()),
      child: const _StoryGeneratorView(),
    );
  }
}

class _StoryGeneratorView extends StatefulWidget {
  const _StoryGeneratorView();

  @override
  State<_StoryGeneratorView> createState() => _StoryGeneratorViewState();
}

class _StoryGeneratorViewState extends State<_StoryGeneratorView> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);

    return BlocConsumer<StoryGeneratorBloc, StoryGeneratorState>(
      listener: (context, state) {
        // Navigate to generated story page when story is ready
        if (state.generatedStory != null && !state.isGenerating) {
          context.push('/story-generator/result', extra: state.generatedStory);
        }

        // Show error snackbar
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: colorScheme.error,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Stack(
            children: [
              Scaffold(
                backgroundColor: colorScheme.surface,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: Text(
                    t.storyGenerator.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  centerTitle: true,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back_rounded),
                    onPressed: () => context.pop(),
                  ),
                  actions: [
                    IconButton(
                      icon: Icon(Icons.refresh_rounded),
                      tooltip: 'Reset',
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        context.read<StoryGeneratorBloc>().add(
                          const StoryGeneratorEvent.reset(),
                        );
                      },
                    ),
                  ],
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8.h),
                            // Quick prompts carousel
                            QuickPromptsCarousel(
                              prompts: QuickPrompt.defaultPrompts,
                              currentIndex: state.currentQuickPromptIndex,
                              onPromptSelected: (prompt) {
                                context.read<StoryGeneratorBloc>().add(
                                  StoryGeneratorEvent.applyQuickPrompt(
                                    quickPrompt: prompt,
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 16.h),
                            // Prompt type toggle
                            PromptTypeToggle(
                              isRawPrompt: state.prompt.isRawPrompt,
                              onToggle: (isRaw) {
                                context.read<StoryGeneratorBloc>().add(
                                  StoryGeneratorEvent.togglePromptType(
                                    isRawPrompt: isRaw,
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 16.h),
                            // Interactive or Raw prompt view
                            if (state.prompt.isRawPrompt)
                              RawPromptView(
                                prompt: state.prompt,
                                onPromptChanged: (text) {
                                  context.read<StoryGeneratorBloc>().add(
                                    StoryGeneratorEvent.updateRawPrompt(
                                      text: text,
                                    ),
                                  );
                                },
                                onScriptureTap: () => _showOptionSheet(
                                  context,
                                  'Select Scripture',
                                  'scripture',
                                  state.prompt.scripture,
                                ),
                                onStoryTypeTap: () => _showOptionSheet(
                                  context,
                                  'Select Story Type',
                                  'storyType',
                                  state.prompt.storyType,
                                ),
                                onThemeTap: () => _showOptionSheet(
                                  context,
                                  'Select Theme',
                                  'theme',
                                  state.prompt.theme,
                                ),
                                onMainCharacterTap: () => _showOptionSheet(
                                  context,
                                  'Select Main Character',
                                  'mainCharacter',
                                  state.prompt.mainCharacter,
                                ),
                                onSettingTap: () => _showOptionSheet(
                                  context,
                                  'Select Setting',
                                  'setting',
                                  state.prompt.setting,
                                ),
                              )
                            else
                              InteractivePromptView(
                                prompt: state.prompt,
                                isLoading: state.isLoadingOptions,
                                onScriptureTap: () => _showOptionSheet(
                                  context,
                                  'Select Scripture',
                                  'scripture',
                                  state.prompt.scripture,
                                ),
                                onStoryTypeTap: () => _showOptionSheet(
                                  context,
                                  'Select Story Type',
                                  'storyType',
                                  state.prompt.storyType,
                                ),
                                onThemeTap: () => _showOptionSheet(
                                  context,
                                  'Select Theme',
                                  'theme',
                                  state.prompt.theme,
                                ),
                                onMainCharacterTap: () => _showOptionSheet(
                                  context,
                                  'Select Main Character',
                                  'mainCharacter',
                                  state.prompt.mainCharacter,
                                ),
                                onSettingTap: () => _showOptionSheet(
                                  context,
                                  'Select Setting',
                                  'setting',
                                  state.prompt.setting,
                                ),
                                onRandomize: () {
                                  context.read<StoryGeneratorBloc>().add(
                                    const StoryGeneratorEvent.randomize(),
                                  );
                                },
                              ),
                            SizedBox(height: 8.h),
                            // More options button
                            _MoreOptionsButton(
                              options: state.options,
                              onTap: () async {
                                final result =
                                    await MoreOptionsBottomSheet.show(
                                      context: context,
                                      currentOptions: state.options,
                                    );
                                if (result != null && context.mounted) {
                                  context.read<StoryGeneratorBloc>().add(
                                    StoryGeneratorEvent.updateGeneratorOptions(
                                      language: result.language,
                                      format: result.format,
                                      length: result.length,
                                    ),
                                  );
                                }
                              },
                            ),
                            SizedBox(height: 100.h),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                bottomSheet: _GenerateButton(
                  canGenerate: state.canGenerate,
                  onGenerate: () {
                    HapticFeedback.heavyImpact();
                    context.read<StoryGeneratorBloc>().add(
                      const StoryGeneratorEvent.generate(),
                    );
                  },
                ),
              ),
              // Generating overlay
              if (state.isGenerating)
                GeneratingOverlay(message: state.generatingMessage),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showOptionSheet(
    BuildContext context,
    String title,
    String category,
    String? currentValue,
  ) async {
    final result = await OptionSelectionBottomSheet.show(
      context: context,
      title: title,
      category: category,
      selectedValue: currentValue,
    );

    if (result != null && context.mounted) {
      context.read<StoryGeneratorBloc>().add(
        StoryGeneratorEvent.selectOption(
          category: category,
          value: result['value']!,
          parentValue: result['parent'],
        ),
      );
    }
  }
}

class _MoreOptionsButton extends StatelessWidget {
  final dynamic options;
  final VoidCallback onTap;

  const _MoreOptionsButton({required this.options, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        onTap();
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              colorScheme.primaryContainer,
              colorScheme.primaryContainer.withValues(alpha: 0.7),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: colorScheme.primary.withValues(alpha: 0.2)),
          boxShadow: [
            BoxShadow(
              color: colorScheme.primary.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                Icons.tune_rounded,
                size: 20.sp,
                color: colorScheme.primary,
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'More Options',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    '${options.language.displayName} • ${options.format.displayName} • ${options.length.displayName}',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: colorScheme.onSurfaceVariant.withValues(
                        alpha: 0.8,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16.sp,
              color: colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }
}

class _GenerateButton extends StatelessWidget {
  final bool canGenerate;
  final VoidCallback onGenerate;

  const _GenerateButton({required this.canGenerate, required this.onGenerate});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);

    return Container(
      padding: EdgeInsets.fromLTRB(
        16.w,
        12.h,
        16.w,
        12.h + MediaQuery.of(context).padding.bottom,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: FilledButton(
        onPressed: canGenerate ? onGenerate : null,
        style: FilledButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          backgroundColor: colorScheme.primary,
          disabledBackgroundColor: colorScheme.onSurface.withValues(
            alpha: 0.12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.auto_awesome_rounded, size: 20.sp),
            SizedBox(width: 8.w),
            Text(
              t.storyGenerator.generate,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
