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
exports.generateSubscribeMethod = exports.subscriptionResolve = void 0;
const events_1 = require("events");
const classes_1 = require("../../../classes");
const filter_async_iterator_1 = require("./filter-async-iterator");
const subscription_auth_1 = require("./subscription-auth");
const update_diff_filter_1 = require("./update-diff-filter");
const where_1 = require("./where");
function subscriptionResolve(payload) {
    if (!payload) {
        throw new classes_1.Neo4jGraphQLError("Payload is undefined. Can't call subscriptions resolver directly.");
    }
    return payload[0];
}
exports.subscriptionResolve = subscriptionResolve;
function generateSubscribeMethod({ node, type, nodes, relationshipFields, }) {
    return (_root, args, context) => {
        if (node.auth) {
            const authRules = node.auth.getRules(["SUBSCRIBE"]);
            for (const rule of authRules) {
                if (!subscription_auth_1.SubscriptionAuth.validateAuthenticationRule(rule, context)) {
                    throw new Error("Error, request not authenticated");
                }
                if (!subscription_auth_1.SubscriptionAuth.validateRolesRule(rule, context)) {
                    throw new Error("Error, request not authorized");
                }
            }
        }
        const iterable = (0, events_1.on)(context.plugin.events, type);
        if (["create", "update", "delete"].includes(type)) {
            return (0, filter_async_iterator_1.filterAsyncIterator)(iterable, (data) => {
                return (data[0].typename === node.name &&
                    (0, where_1.subscriptionWhere)({ where: args.where, event: data[0], node }) &&
                    (0, update_diff_filter_1.updateDiffFilter)(data[0]));
            });
        }
        if (["create_relationship", "delete_relationship"].includes(type)) {
            return (0, filter_async_iterator_1.filterAsyncIterator)(iterable, (data) => {
                const relationEventPayload = data[0];
                const isOfRelevantType = relationEventPayload.toTypename === node.name || relationEventPayload.fromTypename === node.name;
                if (!isOfRelevantType) {
                    return false;
                }
                const relationFieldName = node.relationFields.find((r) => r.type === relationEventPayload.relationshipName)?.fieldName;
                return (!!relationFieldName &&
                    (0, where_1.subscriptionWhere)({ where: args.where, event: data[0], node, nodes, relationshipFields }));
            });
        }
        throw new classes_1.Neo4jGraphQLError(`Invalid type in subscription: ${type}`);
    };
}
exports.generateSubscribeMethod = generateSubscribeMethod;
//# sourceMappingURL=subscribe.js.map