import {
  requireNativeComponent,
  UIManager,
  Platform,
  ViewStyle,
} from 'react-native';

const LINKING_ERROR =
  `The package 'react-native-threed' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo managed workflow\n';

export type Props = {
  src: {
    model?: string;
    texture?: string;
  };
  style: ViewStyle;
  allowsCameraControl?: boolean;
};

const ComponentName = 'ThreedViewerView';

export default UIManager.getViewManagerConfig(ComponentName) != null
  ? requireNativeComponent<Props>(ComponentName)
  : () => {
      throw new Error(LINKING_ERROR);
    };
