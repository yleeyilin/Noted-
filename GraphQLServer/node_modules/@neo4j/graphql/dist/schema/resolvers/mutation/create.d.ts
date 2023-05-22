import type { GraphQLResolveInfo } from "graphql";
import type { Node } from "../../../classes";
export declare function createResolver({ node }: {
    node: Node;
}): {
    type: string;
    resolve: (_root: any, args: any, _context: unknown, info: GraphQLResolveInfo) => Promise<{
        info: {
            bookmark: string | null;
        };
    }>;
    args: {
        input: string;
    };
};
//# sourceMappingURL=create.d.ts.map