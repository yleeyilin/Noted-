import type { GraphQLResolveInfo } from "graphql";
import type { SchemaComposer } from "graphql-compose";
import type { Node } from "../../../classes";
export declare function updateResolver({ node, schemaComposer }: {
    node: Node;
    schemaComposer: SchemaComposer;
}): {
    type: string;
    resolve: (_root: any, args: any, _context: unknown, info: GraphQLResolveInfo) => Promise<{
        info: {
            bookmark: string | null;
        };
    }>;
    args: {
        where: string;
        update: string;
    };
};
//# sourceMappingURL=update.d.ts.map