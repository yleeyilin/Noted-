import type { ResolveTree } from "graphql-parse-resolve-info";
import type { Node, Relationship } from "../../classes";
import type { Context, RelationField, ConnectionField } from "../../types";
export declare enum AggregationType {
    Int = "IntAggregateSelection",
    String = "StringAggregateSelection",
    BigInt = "BigIntAggregateSelection",
    Float = "FloatAggregateSelection",
    Id = "IDAggregateSelection",
    DateTime = "DateTimeAggregateSelection"
}
export declare function getFieldType(field: ResolveTree): AggregationType | undefined;
export declare function getReferenceNode(context: Context, relationField: RelationField): Node | undefined;
export declare function getReferenceRelation(context: Context, connectionField: ConnectionField): Relationship | undefined;
export declare function getFieldByName(name: string, fields: Record<string, ResolveTree>): ResolveTree | undefined;
//# sourceMappingURL=utils.d.ts.map