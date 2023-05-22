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
exports.verifyGlobalAuthentication = exports.decodeToken = void 0;
const classes_1 = require("../../classes");
async function decodeToken(token, plugin) {
    if (token && plugin) {
        const jwt = await plugin.decode(token);
        if (typeof jwt === "string") {
            throw new classes_1.Neo4jGraphQLAuthenticationError("JWT payload cannot be a string");
        }
        return jwt;
    }
    return undefined;
}
exports.decodeToken = decodeToken;
function verifyGlobalAuthentication(context, plugin) {
    if (plugin?.isGlobalAuthenticationEnabled) {
        if (!context.jwt) {
            throw new classes_1.Neo4jGraphQLAuthenticationError("Unauthenticated");
        }
    }
}
exports.verifyGlobalAuthentication = verifyGlobalAuthentication;
//# sourceMappingURL=wrapper-utils.js.map