import * as React from 'react';

import { StyleSheet, ScrollView, SafeAreaView } from 'react-native';
import ThreedViewer from 'react-native-threed-viewer';

export default function App() {
  return (
    <SafeAreaView style={{ flex: 1 }}>
      <ScrollView contentContainerStyle={styles.container}>
        <ThreedViewer
          src={{
            model: require('./assets/penguin.obj'),
            texture: require('./assets/penguin.jpg'),
          }}
          style={styles.modalViewer}
          allowsCameraControl
        />
        <ThreedViewer
          src={{
            model: require('./assets/cat.obj'),
            texture: require('./assets/cat.jpg'),
          }}
          style={styles.modalViewer}
          allowsCameraControl
        />
        <ThreedViewer
          src={{
            model: require('./assets/fox.obj'),
            texture: require('./assets/fox.jpg'),
          }}
          style={styles.modalViewer}
          allowsCameraControl
        />
      </ScrollView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    marginTop: 20,
    alignItems: 'center',
  },
  modalViewer: {
    height: 200,
    width: 200,
  },
});
