import type { SchemaComposer } from "graphql-compose";
import type { Node } from "../../classes";
import type { RelationField } from "../../types";
export declare function createConnectOrCreateField({ node, relationField, schemaComposer, hasNonGeneratedProperties, hasNonNullNonGeneratedProperties, }: {
    node: Node;
    relationField: RelationField;
    schemaComposer: SchemaComposer;
    hasNonGeneratedProperties: boolean;
    hasNonNullNonGeneratedProperties: boolean;
}): string | undefined;
//# sourceMappingURL=create-connect-or-create-field.d.ts.map