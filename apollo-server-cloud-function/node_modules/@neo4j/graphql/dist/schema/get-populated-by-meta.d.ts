import type { DirectiveNode } from "graphql";
import type { Callback, Neo4jGraphQLCallbacks } from "../types";
/** Deprecated in favour of populatedBy */
export declare function getCallbackMeta(directive: DirectiveNode, callbacks?: Neo4jGraphQLCallbacks): Callback;
export declare function getPopulatedByMeta(directive: DirectiveNode, callbacks?: Neo4jGraphQLCallbacks): Callback;
//# sourceMappingURL=get-populated-by-meta.d.ts.map