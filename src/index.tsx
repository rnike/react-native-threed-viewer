import {
  requireNativeComponent,
  UIManager,
  Platform,
  ViewStyle,
} from 'react-native';

const LINKING_ERROR =
  `The package 'react-native-threed-viewer' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo managed workflow\n';

type ThreedViewerProps = {
  color: string;
  style: ViewStyle;
};

const ComponentName = 'ThreedViewerView';

export const ThreedViewerView =
  UIManager.getViewManagerConfig(ComponentName) != null
    ? requireNativeComponent<ThreedViewerProps>(ComponentName)
    : () => {
        throw new Error(LINKING_ERROR);
      };
