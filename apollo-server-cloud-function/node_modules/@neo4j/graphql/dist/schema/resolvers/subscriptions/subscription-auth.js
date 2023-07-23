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
exports.SubscriptionAuth = void 0;
const utils_1 = require("../../../utils/utils");
const create_auth_param_1 = __importDefault(require("../../../translate/create-auth-param"));
class SubscriptionAuth {
    static validateAuthenticationRule(rule, context) {
        const isAuthenticated = this.isAuthenticated(context);
        if (isAuthenticated) {
            return this.validateAuthenticated(rule);
        }
        return this.validateUnauthenticated(rule);
    }
    static validateRolesRule(rule, context) {
        const authParams = (0, create_auth_param_1.default)({ context });
        const expectedRoles = rule.roles;
        if (!expectedRoles) {
            return true;
        }
        if ((0, utils_1.haveSharedElement)(expectedRoles, authParams.roles)) {
            return true;
        }
        return false;
    }
    static isAuthenticated(context) {
        return Boolean(context.jwt);
    }
    static validateAuthenticated(rule) {
        if (rule.isAuthenticated === false) {
            return false;
        }
        return true;
    }
    static validateUnauthenticated(rule) {
        if (rule.isAuthenticated && !rule.allowUnauthenticated)
            return false;
        return true;
    }
}
exports.SubscriptionAuth = SubscriptionAuth;
//# sourceMappingURL=subscription-auth.js.map