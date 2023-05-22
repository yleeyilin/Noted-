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
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.createBaseOperation = exports.createComparisonOperation = void 0;
const cypher_builder_1 = __importDefault(require("@neo4j/cypher-builder"));
const create_point_comparison_operation_1 = require("./create-point-comparison-operation");
/** Translates an atomic comparison operation (e.g. "this0 <= $param0") */
function createComparisonOperation({ operator, propertyRefOrCoalesce, param, durationField, pointField, neo4jDatabaseInfo, }) {
    if (pointField) {
        return (0, create_point_comparison_operation_1.createPointComparisonOperation)({
            operator,
            propertyRefOrCoalesce,
            param,
            pointField,
            neo4jDatabaseInfo,
        });
    }
    // Comparison operations requires adding dates to durations
    // See https://neo4j.com/developer/cypher/dates-datetimes-durations/#comparing-filtering-values
    if (durationField && operator) {
        return createDurationOperation({ operator, property: propertyRefOrCoalesce, param });
    }
    return createBaseOperation({
        operator: operator || "EQ",
        property: propertyRefOrCoalesce,
        param,
    });
}
exports.createComparisonOperation = createComparisonOperation;
function createDurationOperation({ operator, property, param, }) {
    const variable = cypher_builder_1.default.plus(cypher_builder_1.default.datetime(), param);
    const propertyRef = cypher_builder_1.default.plus(cypher_builder_1.default.datetime(), property);
    return createBaseOperation({
        operator,
        property: propertyRef,
        param: variable,
    });
}
function createBaseOperation({ operator, property, param, }) {
    switch (operator) {
        case "LT":
            return cypher_builder_1.default.lt(property, param);
        case "LTE":
            return cypher_builder_1.default.lte(property, param);
        case "GT":
            return cypher_builder_1.default.gt(property, param);
        case "GTE":
            return cypher_builder_1.default.gte(property, param);
        case "ENDS_WITH":
        case "NOT_ENDS_WITH":
            return cypher_builder_1.default.endsWith(property, param);
        case "STARTS_WITH":
        case "NOT_STARTS_WITH":
            return cypher_builder_1.default.startsWith(property, param);
        case "MATCHES":
            return cypher_builder_1.default.matches(property, param);
        case "CONTAINS":
        case "NOT_CONTAINS":
            return cypher_builder_1.default.contains(property, param);
        case "IN":
        case "NOT_IN":
            return cypher_builder_1.default.in(property, param);
        case "INCLUDES":
        case "NOT_INCLUDES":
            return cypher_builder_1.default.in(param, property);
        case "EQ":
        case "EQUAL":
        case "NOT":
            return cypher_builder_1.default.eq(property, param);
        default:
            throw new Error(`Invalid operator ${operator}`);
    }
}
exports.createBaseOperation = createBaseOperation;
//# sourceMappingURL=create-comparison-operation.js.map