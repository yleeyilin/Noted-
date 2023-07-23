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
const dot_prop_1 = __importDefault(require("dot-prop"));
function createAuthParam({ context }) {
    const { jwt } = context;
    const param = {
        isAuthenticated: false,
        roles: [],
        jwt,
    };
    if (!jwt) {
        return param;
    }
    // If any role is defined in this parameter, isAuthenticated shall be true
    param.isAuthenticated = true;
    const rolesPath = context?.plugins?.auth?.rolesPath;
    // Roles added to config come from the role path or a roles array
    if (rolesPath) {
        param.roles = dot_prop_1.default.get(jwt, rolesPath, []);
    }
    else if (jwt.roles) {
        param.roles = jwt.roles;
    }
    return param;
}
exports.default = createAuthParam;
//# sourceMappingURL=create-auth-param.js.map