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
exports.addRelationshipArrayFilters = void 0;
const pluralize_1 = __importDefault(require("pluralize"));
function addRelationshipArrayFilters({ whereInput, fieldName, sourceName, relatedType, whereType, directives, }) {
    whereInput.addFields(["ALL", "NONE", "SINGLE", "SOME"].reduce((acc, filter) => ({
        ...acc,
        [`${fieldName}_${filter}`]: {
            type: whereType,
            directives: directives,
            // e.g. "Return Movies where all of the related Actors match this filter"
            description: `Return ${(0, pluralize_1.default)(sourceName)} where ${filter !== "SINGLE" ? filter.toLowerCase() : "one"} of the related ${(0, pluralize_1.default)(relatedType)} match this filter`,
        },
    }), {}));
    whereInput.setFieldDirectiveByName(fieldName, "deprecated", {
        reason: `Use \`${fieldName}_SOME\` instead.`,
    });
    whereInput.setFieldDirectiveByName(`${fieldName}_NOT`, "deprecated", {
        reason: `Use \`${fieldName}_NONE\` instead.`,
    });
}
exports.addRelationshipArrayFilters = addRelationshipArrayFilters;
//# sourceMappingURL=add-relationship-array-filters.js.map