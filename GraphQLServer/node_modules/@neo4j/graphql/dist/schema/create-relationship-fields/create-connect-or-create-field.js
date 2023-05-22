"use strict";
/*
 * Copyright (c) "Neo4j"
 * Neo4j Sweden AB [http://neo4j.com]
 *
 * This file is part of Neo4j.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
Object.defineProperty(exports, "__esModule", { value: true });
exports.createConnectOrCreateField = void 0;
const upper_first_1 = require("../../utils/upper-first");
const ensure_non_empty_input_1 = require("../ensure-non-empty-input");
const to_compose_1 = require("../to-compose");
function createConnectOrCreateField({ node, relationField, schemaComposer, hasNonGeneratedProperties, hasNonNullNonGeneratedProperties, }) {
    if (!node.uniqueFields.length) {
        return undefined;
    }
    const parentPrefix = `${relationField.connectionPrefix}${(0, upper_first_1.upperFirst)(relationField.fieldName)}`;
    const connectOrCreateName = relationField.union
        ? `${parentPrefix}${node.name}ConnectOrCreateFieldInput`
        : `${parentPrefix}ConnectOrCreateFieldInput`;
    const onCreateITC = createOnCreateITC({
        schemaComposer,
        prefix: connectOrCreateName,
        node,
        hasNonGeneratedProperties,
        hasNonNullNonGeneratedProperties,
        relationField,
    });
    const whereITC = createWhereITC({ schemaComposer, node });
    schemaComposer.getOrCreateITC(connectOrCreateName, (tc) => {
        tc.addFields({
            where: `${whereITC.getTypeName()}!`,
            onCreate: `${onCreateITC.getTypeName()}!`,
        });
    });
    return relationField.typeMeta.array ? `[${connectOrCreateName}!]` : connectOrCreateName;
}
exports.createConnectOrCreateField = createConnectOrCreateField;
function createOnCreateITC({ schemaComposer, prefix, node, hasNonGeneratedProperties, hasNonNullNonGeneratedProperties, relationField, }) {
    const onCreateName = `${prefix}OnCreate`;
    const onCreateFields = getOnCreateFields({
        node,
        hasNonGeneratedProperties,
        relationField,
        hasNonNullNonGeneratedProperties,
        schemaComposer,
    });
    return schemaComposer.getOrCreateITC(onCreateName, (tc) => {
        tc.addFields(onCreateFields);
    });
}
function createWhereITC({ schemaComposer, node }) {
    const connectOrCreateWhereName = `${node.name}ConnectOrCreateWhere`;
    return schemaComposer.getOrCreateITC(connectOrCreateWhereName, (tc) => {
        tc.addFields({
            node: `${node.name}UniqueWhere!`,
        });
    });
}
function getOnCreateFields({ node, hasNonGeneratedProperties, relationField, hasNonNullNonGeneratedProperties, schemaComposer, }) {
    const nodeCreateInput = schemaComposer.getOrCreateITC(`${node.name}OnCreateInput`, (tc) => {
        const nodeFields = (0, to_compose_1.objectFieldsToCreateInputFields)([
            ...node.primitiveFields,
            ...node.scalarFields,
            ...node.enumFields,
            ...node.pointFields,
            ...node.temporalFields,
        ]);
        tc.addFields(nodeFields);
        (0, ensure_non_empty_input_1.ensureNonEmptyInput)(schemaComposer, tc);
    });
    const nodeCreateInputFieldName = `${nodeCreateInput.getTypeName()}!`;
    if (hasNonGeneratedProperties) {
        const edgeField = `${relationField.properties}CreateInput${hasNonNullNonGeneratedProperties ? `!` : ""}`;
        return {
            node: nodeCreateInputFieldName,
            edge: edgeField,
        };
    }
    return {
        node: nodeCreateInputFieldName,
    };
}
//# sourceMappingURL=create-connect-or-create-field.js.map