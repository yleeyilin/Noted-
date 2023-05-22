import type { GraphQLResolveInfo } from "graphql";
import type { InputTypeComposer, SchemaComposer } from "graphql-compose";
import type { PageInfo } from "graphql-relay";
import type { Node } from "../../../classes";
export declare function rootConnectionResolver({ node, composer }: {
    node: Node;
    composer: SchemaComposer;
}): {
    type: import("graphql-compose").NonNullComposer<import("graphql-compose").ObjectTypeComposer<any, any>>;
    resolve: (_root: any, args: any, _context: unknown, info: GraphQLResolveInfo) => Promise<{
        totalCount: number;
        edges: any[];
        pageInfo: PageInfo;
    }>;
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
        sort?: import("graphql-compose").ListComposer<InputTypeComposer<any>> | undefined;
        first: string;
        after: string;
        where: string;
    };
};
//# sourceMappingURL=root-connection.d.ts.map