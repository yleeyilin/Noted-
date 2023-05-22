import type { GraphQLResolveInfo, SelectionSetNode } from "graphql";
import type { ConnectionField, ConnectionQueryArgs } from "../types";
export declare function connectionFieldResolver({ connectionField, source, args, info, }: {
    connectionField: ConnectionField;
    source: any;
    args: ConnectionQueryArgs;
    info: GraphQLResolveInfo;
}): {
    [x: string]: any;
};
/**
 * Adapted from graphql-relay-js ConnectionFromArraySlice
 */
export declare function createConnectionWithEdgeProperties({ selectionSet, source, args, totalCount, }: {
    selectionSet: SelectionSetNode | undefined;
    source: any;
    args: {
        after?: string;
        first?: number;
    };
    totalCount: number;
}): {
    [x: string]: any[] | {
        [x: string]: any;
    };
};
//# sourceMappingURL=pagination.d.ts.map