import type { CustomEnumField, CustomScalarField, Neo4jFeaturesSettings, PointField, PrimitiveField, TemporalField } from "../types";
interface Fields {
    scalarFields: CustomScalarField[];
    enumFields: CustomEnumField[];
    primitiveFields: PrimitiveField[];
    temporalFields: TemporalField[];
    pointFields: PointField[];
}
declare function getWhereFields({ typeName, fields, enableRegex, isInterface, features, }: {
    typeName: string;
    fields: Fields;
    enableRegex?: boolean;
    isInterface?: boolean;
    features?: Neo4jFeaturesSettings;
}): {
    [k: string]: string;
};
export default getWhereFields;
//# sourceMappingURL=get-where-fields.d.ts.map