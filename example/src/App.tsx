import * as React from 'react';

import { StyleSheet, View } from 'react-native';
import ThreedViewer from 'react-native-threed-viewer';

export default function App() {
  return (
    <View style={styles.container}>
      <ThreedViewer
        src={{
          model: require('./assets/ping.obj'),
          texture: require('./assets/ping.png'),
        }}
        style={styles.modalViewer}
        allowsCameraControl
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    backgroundColor: 'green',
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  modalViewer: {
    backgroundColor: 'red',
    width: 200,
    height: 200,
    marginVertical: 20,
  },
});
