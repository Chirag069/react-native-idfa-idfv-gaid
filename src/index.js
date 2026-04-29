import { NativeModules, Platform } from 'react-native';

const { IdfaIdfvGaid } = NativeModules;

if (!IdfaIdfvGaid) {
  console.warn(
    'react-native-idfa-idfv-gaid: Native module not found. ' +
    'Make sure to run `pod install` (iOS) or rebuild the project (Android).'
  );
}

/**
 * Get IDFA (iOS only)
 * Requires ATT permission to be granted first on iOS 14.5+
 * Returns null if not authorized or on Android
 */
export const getIDFA = () => {
  if (Platform.OS !== 'ios') return Promise.resolve(null);
  return IdfaIdfvGaid.getIDFA();
};

/**
 * Get IDFV (iOS only)
 * Does not require ATT permission
 * Returns null on Android
 */
export const getIDFV = () => {
  if (Platform.OS !== 'ios') return Promise.resolve(null);
  return IdfaIdfvGaid.getIDFV();
};

/**
 * Get Google Advertising ID (Android only)
 * Returns null on iOS
 */
export const getGAID = () => {
  if (Platform.OS !== 'android') return Promise.resolve(null);
  return IdfaIdfvGaid.getGAID();
};

/**
 * Get all available IDs for the current platform
 * iOS: returns { idfa, idfv }
 * Android: returns { gaid }
 */
export const getAllIds = async () => {
  if (Platform.OS === 'ios') {
    const [idfa, idfv] = await Promise.all([
      IdfaIdfvGaid.getIDFA(),
      IdfaIdfvGaid.getIDFV(),
    ]);
    return { idfa, idfv };
  } else {
    const gaid = await IdfaIdfvGaid.getGAID();
    return { gaid };
  }
};

export default { getIDFA, getIDFV, getGAID, getAllIds };
