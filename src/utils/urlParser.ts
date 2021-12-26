import { DocumentDirectoryPath, mkdir } from 'react-native-fs';

const CACHE_FOLDER = `${DocumentDirectoryPath}/three-d-model`;

(function initialize() {
  mkdir(CACHE_FOLDER);
})();

export const makeFilePath = (fileName: string) => `${CACHE_FOLDER}/${fileName}`;

export const getFilename = (url: string) => {
  return url.substring(url.lastIndexOf('/') + 1).split('?')[0];
};
