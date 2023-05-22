import type Node from "../../../../classes/Node";
import type { RelationshipSubscriptionsEvent } from "../../../../types";
import type { ObjectFields } from "../../../../schema/get-obj-field-meta";
/**
 * Returns true if all properties in obj1 exists in obj2, false otherwise.
 * Properties can only be primitives or Array<primitive>
 */
export declare function compareProperties(obj1: Record<string, any>, obj2: Record<string, any>): boolean;
/** Returns true if receivedProperties comply with filters specified in whereProperties, false otherwise. */
export declare function filterByProperties<T>(node: Node, whereProperties: Record<string, T | Array<Record<string, T>>>, receivedProperties: Record<string, T>): boolean;
export type RecordType = Record<string, unknown>;
export type StandardType = Record<string, Record<string, unknown>>;
export type UnionType = Record<string, StandardType>;
export type InterfaceType = Record<string, unknown | InterfaceSpecificType>;
export type InterfaceSpecificType = Record<string, Record<string, unknown>>;
export type RelationshipType = Record<string, Record<string, UnionType | InterfaceType | StandardType>>;
export declare function filterByRelationshipProperties({ node, whereProperties, receivedEvent, nodes, relationshipFields, }: {
    node: Node;
    whereProperties: Record<string, RecordType | Record<string, RecordType | RelationshipType>>;
    receivedEvent: RelationshipSubscriptionsEvent;
    nodes: Node[];
    relationshipFields: Map<string, ObjectFields>;
}): boolean;
//# sourceMappingURL=compare-properties.d.ts.map