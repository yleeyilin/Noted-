import type { GraphQLResolveInfo } from "graphql";
import type { Context, CypherField } from "../types";
import Cypher from "@neo4j/cypher-builder";
export declare function translateTopLevelCypher({ context, info, field, args, type, statement, }: {
    context: Context;
    info: GraphQLResolveInfo;
    field: CypherField;
    args: any;
    statement: string;
    type: "Query" | "Mutation";
}): Cypher.CypherResult;
//# sourceMappingURL=translate-top-level-cypher.d.ts.map