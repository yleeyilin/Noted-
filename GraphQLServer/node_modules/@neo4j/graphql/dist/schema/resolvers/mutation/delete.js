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
exports.deleteResolver = void 0;
const get_neo4j_resolve_tree_1 = __importDefault(require("../../../utils/get-neo4j-resolve-tree"));
const utils_1 = require("../../../utils");
const translate_1 = require("../../../translate");
const publish_events_to_plugin_1 = require("../../subscriptions/publish-events-to-plugin");
function deleteResolver({ node }) {
    async function resolve(_root, args, _context, info) {
        const context = _context;
        context.resolveTree = (0, get_neo4j_resolve_tree_1.default)(info, { args });
        const { cypher, params } = (0, translate_1.translateDelete)({ context, node });
        const executeResult = await (0, utils_1.execute)({
            cypher,
            params,
            defaultAccessMode: "WRITE",
            context,
        });
        (0, publish_events_to_plugin_1.publishEventsToPlugin)(executeResult, context.plugins?.subscriptions, context.schemaModel);
        return { bookmark: executeResult.bookmark, ...executeResult.statistics };
    }
    return {
        type: `DeleteInfo!`,
        resolve,
        args: {
            where: `${node.name}Where`,
            ...(node.relationFields.length
                ? {
                    delete: `${node.name}DeleteInput`,
                }
                : {}),
        },
    };
}
exports.deleteResolver = deleteResolver;
//# sourceMappingURL=delete.js.map