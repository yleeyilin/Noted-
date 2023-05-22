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
const constants_1 = require("../constants");
function getRelationshipMeta(field, interfaceField) {
    const directive = field.directives?.find((x) => x.name.value === "relationship") ||
        interfaceField?.directives?.find((x) => x.name.value === "relationship");
    if (!directive) {
        return undefined;
    }
    const directionArg = directive.arguments?.find((x) => x.name.value === "direction");
    if (!directionArg) {
        throw new Error("@relationship direction required");
    }
    if (directionArg.value.kind !== "EnumValue") {
        throw new Error("@relationship direction not a enum");
    }
    if (!["IN", "OUT"].includes(directionArg.value.value)) {
        throw new Error("@relationship direction invalid");
    }
    const queryDirection = getQueryDirection(directive);
    const typeArg = directive.arguments?.find((x) => x.name.value === "type");
    if (!typeArg) {
        throw new Error("@relationship type required");
    }
    if (typeArg.value.kind !== "StringValue") {
        throw new Error("@relationship type not a string");
    }
    const propertiesArg = directive.arguments?.find((x) => x.name.value === "properties");
    if (propertiesArg && propertiesArg.value.kind !== "StringValue") {
        throw new Error("@relationship properties not a string");
    }
    const direction = directionArg.value.value;
    const type = typeArg.value.value;
    const properties = propertiesArg?.value?.value;
    return {
        direction,
        type,
        properties,
        queryDirection,
    };
}
function getQueryDirection(directive) {
    const queryDirectionArg = directive.arguments?.find((x) => x.name.value === "queryDirection");
    let queryDirection = constants_1.RelationshipQueryDirectionOption.DEFAULT_DIRECTED;
    if (queryDirectionArg) {
        if (queryDirectionArg.value.kind !== "EnumValue") {
            throw new Error("@relationship queryDirection is not a enum");
        }
        const queryDirectionValue = constants_1.RelationshipQueryDirectionOption[queryDirectionArg.value.value];
        if (!Object.values(constants_1.RelationshipQueryDirectionOption).includes(queryDirectionValue)) {
            throw new Error("@relationship queryDirection invalid");
        }
        queryDirection = queryDirectionArg.value.value;
    }
    return queryDirection;
}
exports.default = getRelationshipMeta;
//# sourceMappingURL=get-relationship-meta.js.map