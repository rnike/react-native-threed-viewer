import React, { useEffect, useState, useMemo } from 'react';

import { Image } from 'react-native';
import { downloadFile } from 'react-native-fs';
import NativeComponent, { Props } from './NativeComponent';
import { getFilename, makeFilePath } from './utils/urlParser';

const useObjSrc = ({ src }: Pick<Props, 'src'>) => {
  const { texture, model } = src;

  const [modelUrl, setModelUrl] = useState<string>();
  const [textureUrl, setTextureUrl] = useState<string>();

  useEffect(() => {
    if (!model) {
      setModelUrl(undefined);
      return;
    }

    const fromUrl = Image.resolveAssetSource(model).uri;
    const fileName = getFilename(fromUrl);
    const filePath = makeFilePath(fileName);

    downloadFile({
      fromUrl,
      toFile: filePath,
      cacheable: true,
    })
      .promise.then(() => {
        setModelUrl(filePath);
      })
      .catch((e) => {
        console.error('error on loading model', e);
      });
  }, [model]);

  useEffect(() => {
    if (!texture) {
      setTextureUrl(undefined);
      return;
    }
    const fromUrl = Image.resolveAssetSource(texture).uri;
    const fileName = getFilename(fromUrl);
    const filePath = makeFilePath(fileName);

    downloadFile({
      fromUrl,
      toFile: filePath,
    })
      .promise.then(() => {
        setTextureUrl(filePath);
      })
      .catch((e) => {
        console.error('error on loading texture', e);
      });
  }, [texture]);

  return useMemo(
    () => ({
      model: modelUrl,
      texture: textureUrl,
    }),
    [modelUrl, textureUrl]
  );
};

export default (props: Props) => {
  const { src, ...others } = props;
  const configSrc = useObjSrc({ src });

  return <NativeComponent src={configSrc} {...others} />;
};
