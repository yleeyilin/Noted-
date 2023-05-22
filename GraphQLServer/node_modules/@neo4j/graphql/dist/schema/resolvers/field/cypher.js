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
exports.cypherResolver = void 0;
const utils_1 = require("../../../utils");
const to_compose_1 = require("../../to-compose");
const utils_2 = require("../../../utils/utils");
const translate_1 = require("../../../translate");
function cypherResolver({ field, statement, type, }) {
    async function resolve(_root, args, _context, info) {
        const context = _context;
        const { cypher, params } = (0, translate_1.translateTopLevelCypher)({
            context,
            info,
            field,
            args,
            type,
            statement,
        });
        const executeResult = await (0, utils_1.execute)({
            cypher,
            params,
            defaultAccessMode: "WRITE",
            context,
        });
        const values = executeResult.result.records.map((record) => {
            const value = record.get(0);
            if (["number", "string", "boolean"].includes(typeof value)) {
                return value;
            }
            if (!value) {
                return undefined;
            }
            if ((0, utils_2.isNeoInt)(value)) {
                return Number(value);
            }
            if (value.identity && value.labels && value.properties) {
                return value.properties;
            }
            return value;
        });
        if (!field.typeMeta.array) {
            return values[0];
        }
        return values;
    }
    return {
        type: field.typeMeta.pretty,
        resolve,
        args: (0, to_compose_1.graphqlArgsToCompose)(field.arguments),
    };
}
exports.cypherResolver = cypherResolver;
//# sourceMappingURL=cypher.js.map