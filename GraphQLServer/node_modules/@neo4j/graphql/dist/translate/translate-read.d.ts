import type { Node } from "../classes";
import type { Context } from "../types";
import Cypher from "@neo4j/cypher-builder";
export declare function translateRead({ node, context, isRootConnectionField, }: {
    context: Context;
    node: Node;
    isRootConnectionField?: boolean;
}, varName?: string): Cypher.CypherResult;
//# sourceMappingURL=translate-read.d.ts.map