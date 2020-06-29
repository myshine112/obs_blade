import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../models/connection.dart';
import '../../shared/basic/flutter_modified/translucent_sliver_app_bar.dart';
import '../../shared/basic/status_dot.dart';
import '../../shared/dialogs/confirmation.dart';
import '../../shared/dialogs/input.dart';
import '../../stores/shared/network.dart';
import '../../stores/views/dashboard.dart';
import '../../types/enums/hive_keys.dart';
import '../../utils/routing_helper.dart';
import 'widgets/scenes/scenes.dart';
import 'widgets/stream_widgets/stream_widgets.dart';

class DashboardView extends StatefulWidget {
  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> with AfterLayoutMixin {
  List<String> _appBarActions = ['Manage Stream', 'Stats'];

  @override
  initState() {
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _checkSaveConnection(context);
  }

  _checkSaveConnection(BuildContext context) {
    NetworkStore networkStore =
        Provider.of<NetworkStore>(context, listen: false);

    if (networkStore.activeSession.connection.name == null) {
      Box<Connection> box =
          Hive.box<Connection>(HiveKeys.SAVED_CONNECTIONS.name);
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => ConfirmationDialog(
          title: 'Save Connection',
          body:
              'Do you want to save this connection? You can do it later as well.',
          onOk: () {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => InputDialog(
                title: 'Save Connection',
                body:
                    'Please choose a name for the connection so you can recognize it later on',
                onSave: (name) {
                  // if the challenge (or salt) is null, we didn't have to connect with a password.
                  // a user might still enter a password, we don't want this password to be
                  // saved, thats why we set it to null explicitly if thats the case
                  if (networkStore.activeSession.connection.challenge == null) {
                    networkStore.activeSession.connection.pw = null;
                  }
                  networkStore.activeSession.connection.name = name;
                  box.add(networkStore.activeSession.connection);
                },
              ),
            );
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    NetworkStore networkStore = Provider.of<NetworkStore>(context);

    return Provider<DashboardStore>(create: (_) {
      DashboardStore dashboardStore = DashboardStore();

      // setting the active session and make initial requests
      // to display data on connect
      dashboardStore.setActiveSession(networkStore.activeSession);
      return dashboardStore;
    }, builder: (context, child) {
      DashboardStore dashboardStore = Provider.of<DashboardStore>(context);

      return Scaffold(
        body: CustomScrollView(
          slivers: [
            TransculentSliverAppBar(
              pinned: true,
              title: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CupertinoButton(
                        child: Text('Close'),
                        onPressed: () => showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) => ConfirmationDialog(
                            title: 'Close Connection',
                            body:
                                'Are you sure you want to close the current WebSocket connection?',
                            onOk: () {
                              networkStore.closeSession();
                              Navigator.of(context).pushReplacementNamed(
                                  HomeTabRoutingKeys.Landing.route);
                            },
                          ),
                        ),
                      ),
                      Container(
                        width: 150.0,
                        alignment: Alignment.bottomRight,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _appBarActions[0],
                            icon: Container(),
                            isExpanded: true,
                            selectedItemBuilder: (_) => [
                              Container(
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  CupertinoIcons.ellipsis,
                                  size: 32.0,
                                ),
                              )
                            ],
                            items: _appBarActions
                                .map(
                                  (action) => DropdownMenuItem<String>(
                                    child: SizedBox(
                                      width: 150.0,
                                      child: Text(
                                        action,
                                      ),
                                    ),
                                    value: action,
                                  ),
                                )
                                .toList(),
                            onChanged: (selection) => print(selection),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text('Dashboard'),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                        child: Observer(builder: (_) {
                          return StatusDot(
                            size: 8.0,
                            color: dashboardStore.isLive
                                ? Colors.green
                                : Colors.red,
                            text: dashboardStore.isLive ? 'Live' : 'Not Live',
                            style: Theme.of(context).textTheme.caption,
                          );
                        }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(bottom: 50.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0, bottom: 24.0),
                      child: Scenes(),
                    ),
                    StreamWidgets(),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
