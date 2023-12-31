import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:obs_blade/shared/general/base/card.dart';

import '../../../../../shared/general/base/button.dart';
import '../../../../../shared/general/base/checkbox.dart';
import '../../../../../shared/general/hive_builder.dart';
import '../../../../../stores/shared/network.dart';
import '../../../../../stores/views/dashboard.dart';
import '../../../../../types/enums/hive_keys.dart';
import '../../../../../types/enums/request_type.dart';
import '../../../../../types/enums/settings_keys.dart';
import '../../../../../utils/network_helper.dart';
import 'transition.dart';

class StudioModeTransition extends StatelessWidget {
  const StudioModeTransition({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DashboardStore dashboardStore = GetIt.instance<DashboardStore>();

    return HiveBuilder<dynamic>(
      hiveKey: HiveKeys.Settings,
      rebuildKeys: const [SettingsKeys.ExposeStudioControls],
      builder: (context, settingsBox, child) => Observer(builder: (_) {
        dashboardStore.studioMode;
        return Column(
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (child, animation) => FadeTransition(
                opacity: CurvedAnimation(
                  parent: animation,
                  curve: const Interval(
                    0.4,
                    1.0,
                    curve: Curves.easeInQuad,
                  ),
                  reverseCurve: Curves.easeOutQuad,
                ),
                child: SizeTransition(
                  sizeFactor: CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeInQuad,
                    reverseCurve: Curves.easeOutQuad,
                  ),
                  child: child,
                ),
              ),
              child: (settingsBox.get(SettingsKeys.ExposeStudioControls.name,
                          defaultValue: false) &&
                      dashboardStore.studioMode)
                  ? Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 24.0),
                        child: SizedBox(
                          width: 128.0,
                          child: BaseButton(
                            text: 'Transition',
                            secondary: true,
                            onPressed: () {
                              dashboardStore.setActiveSceneName(
                                  dashboardStore.studioModePreviewSceneName!);
                              NetworkHelper.makeRequest(
                                GetIt.instance<NetworkStore>()
                                    .activeSession!
                                    .socket,
                                RequestType.SetCurrentProgramScene,
                                {
                                  'sceneName':
                                      dashboardStore.studioModePreviewSceneName
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ),
            BaseCard(
              backgroundColor: Colors.transparent,
              topPadding: 0,
              bottomPadding: 0,
              rightPadding: 12,
              leftPadding: 4,
              paddingChild: const EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  settingsBox.get(SettingsKeys.ExposeStudioControls.name,
                          defaultValue: false)
                      ? Padding(
                          padding: const EdgeInsets.only(right: 24.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              BaseCheckbox(
                                value: dashboardStore.studioMode,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                onChanged: (studioMode) =>
                                    NetworkHelper.makeRequest(
                                  GetIt.instance<NetworkStore>()
                                      .activeSession!
                                      .socket,
                                  RequestType.SetStudioModeEnabled,
                                  {'studioModeEnabled': studioMode},
                                ),
                              ),
                              const Text('Studio Mode'),
                            ],
                          ),
                        )
                      : Container(),
                  const Flexible(
                    child: Transition(),
                  ),
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
