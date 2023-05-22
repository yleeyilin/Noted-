import type { GraphQLResolveInfo } from "graphql";
import type { Node } from "../../../classes";
export declare function deleteResolver({ node }: {
    node: Node;
}): {
    type: string;
    resolve: (_root: any, args: any, _context: unknown, info: GraphQLResolveInfo) => Promise<{
        bookmark: string | null;
    }>;
    args: {
        delete?: string | undefined;
        where: string;
    };
};
//# sourceMappingURL=delete.d.ts.map