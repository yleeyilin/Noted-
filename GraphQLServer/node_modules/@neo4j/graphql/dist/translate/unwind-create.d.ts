import type { Node } from "../classes";
import type { Context } from "../types";
export default function unwindCreate({ context, node, }: {
    context: Context;
    node: Node;
}): Promise<{
    cypher: string;
    params: Record<string, any>;
}>;
//# sourceMappingURL=unwind-create.d.ts.map