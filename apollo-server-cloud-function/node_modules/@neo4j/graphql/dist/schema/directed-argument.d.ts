import type { RelationField } from "../types";
export type DirectedArgument = {
    type: "Boolean";
    defaultValue: boolean;
};
export declare function getDirectedArgument(relationField: RelationField): DirectedArgument | undefined;
export declare function addDirectedArgument<T extends Record<string, any>>(args: T, relationField: RelationField): T & {
    directed?: DirectedArgument;
};
//# sourceMappingURL=directed-argument.d.ts.map