import type { CypherEnvironment } from "../Environment";
import { Clause } from "./Clause";
type RawCypherCallback = (env: CypherEnvironment) => [string, Record<string, any>] | string | undefined;
/** For compatibility reasons, allows for a raw string to be used as a clause
 * @group Other
 */
export declare class RawCypher extends Clause {
    private callback;
    constructor(callback: RawCypherCallback | string);
    getCypher(env: CypherEnvironment): string;
    private stringToCallback;
}
export {};
//# sourceMappingURL=RawCypher.d.ts.map