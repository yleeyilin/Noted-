import type { GraphQLResolveInfo } from "graphql";
import type { Node } from "../../../classes";
export declare function findResolver({ node }: {
    node: Node;
}): {
    type: string;
    resolve: (_root: any, args: any, _context: unknown, info: GraphQLResolveInfo) => Promise<any[]>;
    args: {
        fulltext?: {
            type: string;
            directives: {
                name: string;
                args: {
                    reason: string;
                };
            }[];
        } | undefined;
        where: string;
        options: string;
    };
};
//# sourceMappingURL=read.d.ts.map