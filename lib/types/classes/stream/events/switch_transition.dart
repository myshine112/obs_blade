import 'base.dart';

/// The active transition has been changed
class SwitchTransitionEvent extends BaseEvent {
  SwitchTransitionEvent(super.json);

  /// The name of the new active transition
  String get transitionName => this.json['transition-name'];
}
