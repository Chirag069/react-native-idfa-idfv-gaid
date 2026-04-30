import { NativeModules, Platform } from 'react-native';

const { IdfaIdfvGaid } = NativeModules;

const notAvailable = () => Promise.resolve(null);

const guardedModule = (fn) => {
  if (!IdfaIdfvGaid) {
    console.warn(
      'react-native-idfa-idfv-gaid: Native module not found. ' +
      'Make sure to run `pod install` (iOS) or rebuild the project (Android).'
    );
    return notAvailable;
  }
  return fn;
};

export const getIDFA = Platform.OS === 'ios'
  ? guardedModule(() => IdfaIdfvGaid.getIDFA())
  : notAvailable;

export const getIDFV = Platform.OS === 'ios'
  ? guardedModule(() => IdfaIdfvGaid.getIDFV())
  : notAvailable;

export const getGAID = Platform.OS === 'android'
  ? guardedModule(() => IdfaIdfvGaid.getGAID())
  : notAvailable;

export const getAllIds = async () => {
  if (!IdfaIdfvGaid) {
    console.warn('react-native-idfa-idfv-gaid: Native module not found.');
    return Platform.OS === 'ios' ? { idfa: null, idfv: null } : { gaid: null };
  }
  if (Platform.OS === 'ios') {
    const [idfa, idfv] = await Promise.all([
      IdfaIdfvGaid.getIDFA(),
      IdfaIdfvGaid.getIDFV(),
    ]);
    return { idfa, idfv };
  }
  const gaid = await IdfaIdfvGaid.getGAID();
  return { gaid };
};

export default { getIDFA, getIDFV, getGAID, getAllIds };
