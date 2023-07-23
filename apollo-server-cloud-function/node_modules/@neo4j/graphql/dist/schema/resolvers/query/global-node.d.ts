import type { GraphQLResolveInfo } from "graphql";
import type { Node } from "../../../classes";
import type { Context } from "../../../types";
export declare function globalNodeResolver({ nodes }: {
    nodes: Node[];
}): {
    type: string;
    resolve: (_root: any, args: {
        id: string;
    }, context: Context, info: GraphQLResolveInfo) => Promise<null>;
    args: {
        id: string;
    };
};
//# sourceMappingURL=global-node.d.ts.map