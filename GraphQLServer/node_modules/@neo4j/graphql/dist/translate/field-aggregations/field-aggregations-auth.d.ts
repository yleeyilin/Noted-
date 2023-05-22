import type { ResolveTree } from "graphql-parse-resolve-info";
import type { Context } from "../../types";
import type { Node } from "../../classes";
import Cypher from "@neo4j/cypher-builder";
export type AggregationAuth = {
    params: Record<string, string>;
    whereQuery: string;
};
export declare function createFieldAggregationAuth({ node, context, subqueryNodeAlias, nodeFields, }: {
    node: Node;
    context: Context;
    subqueryNodeAlias: Cypher.Node;
    nodeFields: Record<string, ResolveTree> | undefined;
}): Cypher.Predicate | undefined;
//# sourceMappingURL=field-aggregations-auth.d.ts.map