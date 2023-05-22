import type { SchemaComposer } from "graphql-compose";
import type { Node } from "../../classes";
import type { ObjectFields } from "../get-obj-field-meta";
export declare function generateSubscriptionTypes({ schemaComposer, nodes, relationshipFields, interfaceCommonFields, }: {
    schemaComposer: SchemaComposer;
    nodes: Node[];
    relationshipFields: Map<string, ObjectFields>;
    interfaceCommonFields: Map<string, ObjectFields>;
}): void;
//# sourceMappingURL=generate-subscription-types.d.ts.map