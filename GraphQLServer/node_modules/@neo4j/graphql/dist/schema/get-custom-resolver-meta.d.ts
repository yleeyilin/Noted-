import type { IResolvers } from "@graphql-tools/utils";
import type { FieldDefinitionNode, InterfaceTypeDefinitionNode, ObjectTypeDefinitionNode } from "graphql";
type CustomResolverMeta = {
    requiredFields: string[];
};
export declare const ERROR_MESSAGE = "Required fields of @customResolver must be a list of strings";
declare function getCustomResolverMeta(field: FieldDefinitionNode, object: ObjectTypeDefinitionNode | InterfaceTypeDefinitionNode, validateResolvers: boolean, customResolvers?: IResolvers | IResolvers[], interfaceField?: FieldDefinitionNode): CustomResolverMeta | undefined;
export default getCustomResolverMeta;
//# sourceMappingURL=get-custom-resolver-meta.d.ts.map