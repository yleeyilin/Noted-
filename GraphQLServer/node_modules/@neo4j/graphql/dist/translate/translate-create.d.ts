import type { Node } from "../classes";
import type { Context } from "../types";
export default function translateCreate({ context, node, }: {
    context: Context;
    node: Node;
}): Promise<{
    cypher: string;
    params: Record<string, any>;
}>;
//# sourceMappingURL=translate-create.d.ts.map