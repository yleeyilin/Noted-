import type { GraphQLResolveInfo } from "graphql";
import type { CypherField } from "../../../types";
export declare function cypherResolver({ field, statement, type, }: {
    field: CypherField;
    statement: string;
    type: "Query" | "Mutation";
}): {
    type: string;
    resolve: (_root: any, args: any, _context: unknown, info: GraphQLResolveInfo) => Promise<any>;
    args: {};
};
//# sourceMappingURL=cypher.d.ts.map