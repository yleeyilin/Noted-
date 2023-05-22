import type { GraphQLWhereArg, Context } from "../../types";
import type { Node } from "../../classes";
/** Wraps createCypherWhereParams with the old interface for compatibility with old way of composing cypher */
export default function createWhereAndParams({ whereInput, varName, chainStr, node, context, recursing, }: {
    node: Node;
    context: Context;
    whereInput: GraphQLWhereArg;
    varName: string;
    chainStr?: string;
    recursing?: boolean;
}): [string, string, any];
//# sourceMappingURL=create-where-and-params.d.ts.map