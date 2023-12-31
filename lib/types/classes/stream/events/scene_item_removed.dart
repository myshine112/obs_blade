import 'base.dart';

/// A scene item has been removed.
///
/// This event is not emitted when the scene the item is in is removed.
class SceneItemRemovedEvent extends BaseEvent {
  SceneItemRemovedEvent(super.json);

  /// Name of the scene the item was removed from
  String get sceneName => this.json['sceneName'];

  /// Name of the underlying source (input/scene)
  String get sourceName => this.json['sourceName'];

  /// Numeric ID of the scene item
  int get sceneItemId => this.json['sceneItemId'];
}
