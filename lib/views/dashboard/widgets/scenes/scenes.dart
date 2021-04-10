import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../shared/general/responsive_widget_wrapper.dart';
import '../../../../stores/views/dashboard.dart';
import '../../../../types/enums/hive_keys.dart';
import '../../../../types/enums/settings_keys.dart';
import 'recording_controls.dart';
import 'scene_button.dart';
import 'scene_content/scene_content.dart';
import 'scene_content/scene_content_mobile.dart';
import 'scene_preview/scene_preview.dart';
import 'studio_mode_transition/studio_mode_transition.dart';

const double kSceneButtonSpace = 18.0;

class Scenes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DashboardStore dashboardStore = Provider.of<DashboardStore>(context);

    return LayoutBuilder(builder: (context, constraints) {
      double size = 100.0;
      double buttonSizeToFitThree =
          (constraints.maxWidth - 4 * kSceneButtonSpace) / 3;

      size = buttonSizeToFitThree < size ? buttonSizeToFitThree : size;

      return Column(
        children: [
          SizedBox(height: 24.0),
          ValueListenableBuilder(
            valueListenable: Hive.box(HiveKeys.Settings.name).listenable(keys: [
              SettingsKeys.ExposeRecordingControls.name,
            ]),
            builder: (context, Box settingsBox, child) => settingsBox.get(
                    SettingsKeys.ExposeRecordingControls.name,
                    defaultValue: false)
                ? RecordingControls()
                : Container(),
          ),
          SizedBox(height: 24.0),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: kSceneButtonSpace, right: kSceneButtonSpace),
              child: Observer(
                builder: (_) => Wrap(
                  runSpacing: kSceneButtonSpace,
                  spacing: kSceneButtonSpace,
                  children: dashboardStore.scenes != null &&
                          dashboardStore.scenes!.length > 0
                      ? dashboardStore.scenes!
                          .map((scene) => SceneButton(
                                scene: scene,
                                height: size,
                                width: size,
                              ))
                          .toList()
                      : [Text('No Scenes available')],
                ),
              ),
            ),
          ),
          // RaisedButton(
          //   onPressed: () => NetworkHelper.makeRequest(
          //       context.read<NetworkStore>().activeSession.socket,
          //       RequestType.PlayPauseMedia,
          //       {'sourceName': 'was geht ab', 'playPause': false}),
          //   child: Text('SOUND'),
          // ),
          Padding(
            padding: const EdgeInsets.only(top: 32.0, right: 12.0),
            child: StudioModeTransition(),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: ScenePreview(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: ResponsiveWidgetWrapper(
              mobileWidget: SceneContentMobile(),
              tabletWidget: SceneContent(),
            ),
          ),
        ],
      );
    });
  }
}
