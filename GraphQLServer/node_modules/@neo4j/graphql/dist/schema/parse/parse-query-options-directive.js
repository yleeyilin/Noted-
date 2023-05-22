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
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || function (mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (k !== "default" && Object.prototype.hasOwnProperty.call(mod, k)) __createBinding(result, mod, k);
    __setModuleDefault(result, mod);
    return result;
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.parseQueryOptionsDirective = void 0;
const neo4j = __importStar(require("neo4j-driver"));
const QueryOptionsDirective_1 = require("../../classes/QueryOptionsDirective");
const Error_1 = require("../../classes/Error");
const parse_value_node_1 = __importDefault(require("../parse-value-node"));
function parseQueryOptionsDirective({ directive, definition, }) {
    const limitArgument = directive.arguments?.find((direc) => direc.name.value === "limit");
    const limitValue = limitArgument?.value;
    const defaultLimitArgument = limitValue?.fields.find((field) => field.name.value === "default");
    const maxLimitArgument = limitValue?.fields.find((field) => field.name.value === "max");
    const defaultLimit = parseArgumentToInt(defaultLimitArgument);
    const maxLimit = parseArgumentToInt(maxLimitArgument);
    const queryOptionsLimit = { default: defaultLimit, max: maxLimit };
    const queryOptionsError = validateLimitArguments(queryOptionsLimit, definition.name.value);
    if (queryOptionsError) {
        throw queryOptionsError;
    }
    return new QueryOptionsDirective_1.QueryOptionsDirective({ limit: queryOptionsLimit });
}
exports.parseQueryOptionsDirective = parseQueryOptionsDirective;
function parseArgumentToInt(field) {
    if (field) {
        const parsed = (0, parse_value_node_1.default)(field.value);
        return neo4j.int(parsed);
    }
    return undefined;
}
function validateLimitArguments(arg, typeName) {
    const maxLimit = arg.max?.toNumber();
    const defaultLimit = arg.default?.toNumber();
    if (defaultLimit !== undefined && defaultLimit <= 0) {
        return new Error_1.Neo4jGraphQLError(`${typeName} @queryOptions(limit: {default: ${defaultLimit}}) invalid value: '${defaultLimit}', it should be a number greater than 0`);
    }
    if (maxLimit !== undefined && maxLimit <= 0) {
        return new Error_1.Neo4jGraphQLError(`${typeName} @queryOptions(limit: {max: ${maxLimit}}) invalid value: '${maxLimit}', it should be a number greater than 0`);
    }
    if (maxLimit && defaultLimit) {
        if (maxLimit < defaultLimit) {
            return new Error_1.Neo4jGraphQLError(`${typeName} @queryOptions(limit: {max: ${maxLimit}, default: ${defaultLimit}}) invalid default value, 'default' must be smaller than 'max'`);
        }
    }
    return undefined;
}
//# sourceMappingURL=parse-query-options-directive.js.map