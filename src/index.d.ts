export declare const getIDFA: () => Promise<string | null>;
export declare const getIDFV: () => Promise<string | null>;
export declare const getGAID: () => Promise<string | null>;
export declare const getAllIds: () => Promise<
  | { idfa: string | null; idfv: string | null }
  | { gaid: string | null }
>;

declare const _default: {
  getIDFA: () => Promise<string | null>;
  getIDFV: () => Promise<string | null>;
  getGAID: () => Promise<string | null>;
  getAllIds: () => Promise<
    | { idfa: string | null; idfv: string | null }
    | { gaid: string | null }
  >;
};
export default _default;
