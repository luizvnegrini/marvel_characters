import 'package:external_dependencies/external_dependencies.dart';
import 'package:marvel_characters/presentation/home_page/home_page_state.dart';

import 'home_page_viewmodel.dart';

HomePageViewModel readHomeViewModel(WidgetRef ref) =>
    ref.read(homePageViewModel.notifier);

HomePageState useHomeState(WidgetRef ref) => ref.watch(homePageViewModel);
