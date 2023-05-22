import type { Node, Relationship } from "../../classes";
import type { ConnectionWhereArg, Context } from "../../types";
export default function createConnectionWhereAndParams({ whereInput, context, node, nodeVariable, relationship, relationshipVariable, parameterPrefix, }: {
    whereInput: ConnectionWhereArg;
    context: Context;
    node: Node;
    nodeVariable: string;
    relationship: Relationship;
    relationshipVariable: string;
    parameterPrefix: string;
}): {
    cypher: string;
    subquery: string;
    params: Record<string, any>;
};
//# sourceMappingURL=create-connection-where-and-params.d.ts.map