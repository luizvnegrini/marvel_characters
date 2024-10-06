import 'package:external_dependencies/external_dependencies.dart';

import 'details_page_state.dart';
import 'details_page_viewmodel.dart';

DetailsPageViewModel readDetailsViewModel(WidgetRef ref) =>
    ref.read(detailsPageViewModel.notifier);

DetailsPageState useDetailsState(WidgetRef ref) =>
    ref.watch(detailsPageViewModel);
