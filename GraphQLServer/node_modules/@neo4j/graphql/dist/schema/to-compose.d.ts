import type { InputValueDefinitionNode, DirectiveNode } from "graphql";
import type { ObjectTypeComposerFieldConfigAsObjectDefinition, Directive } from "graphql-compose";
import type { BaseField, InputField } from "../types";
export declare function graphqlArgsToCompose(args: InputValueDefinitionNode[]): {};
export declare function graphqlDirectivesToCompose(directives: DirectiveNode[]): Directive[];
export declare function objectFieldsToComposeFields(fields: BaseField[]): {
    [k: string]: ObjectTypeComposerFieldConfigAsObjectDefinition<any, any>;
};
export declare function objectFieldsToCreateInputFields(fields: BaseField[]): Record<string, InputField>;
export declare function objectFieldsToSubscriptionsWhereInputFields(typeName: string, fields: BaseField[]): Record<string, InputField>;
export declare function objectFieldsToUpdateInputFields(fields: BaseField[]): Record<string, InputField>;
//# sourceMappingURL=to-compose.d.ts.map