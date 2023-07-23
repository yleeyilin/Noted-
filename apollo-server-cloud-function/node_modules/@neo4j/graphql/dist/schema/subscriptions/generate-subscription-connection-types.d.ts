import type { ObjectTypeComposer, SchemaComposer } from "graphql-compose";
import type { Node } from "../../classes";
import type { ObjectFields } from "../get-obj-field-meta";
export declare function hasProperties(x: ObjectTypeComposer): boolean;
export declare function getConnectedTypes({ node, relationshipFields, interfaceCommonFields, schemaComposer, nodeNameToEventPayloadTypes, }: {
    node: Node;
    relationshipFields: Map<string, ObjectFields>;
    interfaceCommonFields: Map<string, ObjectFields>;
    schemaComposer: SchemaComposer;
    nodeNameToEventPayloadTypes: Record<string, ObjectTypeComposer>;
}): {};
//# sourceMappingURL=generate-subscription-connection-types.d.ts.map