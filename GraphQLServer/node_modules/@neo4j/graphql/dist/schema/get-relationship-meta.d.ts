import type { FieldDefinitionNode } from "graphql";
import { RelationshipQueryDirectionOption } from "../constants";
type RelationshipMeta = {
    direction: "IN" | "OUT";
    type: string;
    properties?: string;
    queryDirection: RelationshipQueryDirectionOption;
};
declare function getRelationshipMeta(field: FieldDefinitionNode, interfaceField?: FieldDefinitionNode): RelationshipMeta | undefined;
export default getRelationshipMeta;
//# sourceMappingURL=get-relationship-meta.d.ts.map