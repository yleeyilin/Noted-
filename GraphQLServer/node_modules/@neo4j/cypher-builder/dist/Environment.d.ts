import { Param } from "./references/Param";
import type { NamedReference, Reference } from "./references/Reference";
export type EnvPrefix = {
    params?: string;
    variables?: string;
};
/** Hold the internal references of Cypher parameters and variables
 *  @group Internal
 */
export declare class CypherEnvironment {
    private readonly globalPrefix;
    private references;
    private params;
    /**
     *  @hidden
     */
    constructor(prefix?: string | EnvPrefix);
    getReferenceId(reference: Reference | NamedReference): string;
    getParams(): Record<string, any>;
    addNamedParamReference(name: string, param: Param): void;
    addExtraParams(params: Record<string, Param>): void;
    getParamsSize(): number;
    getReferences(): Map<Reference, string>;
    private addParam;
    private addVariableReference;
    private isNamedReference;
}
//# sourceMappingURL=Environment.d.ts.map