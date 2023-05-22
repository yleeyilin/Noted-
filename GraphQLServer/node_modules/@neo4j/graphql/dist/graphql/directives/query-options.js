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
exports.queryOptionsDirective = void 0;
const graphql_1 = require("graphql");
exports.queryOptionsDirective = new graphql_1.GraphQLDirective({
    name: "queryOptions",
    description: "Instructs @neo4j/graphql to inject default values into a query such as a default limit.",
    args: {
        limit: {
            description: "Limit options.",
            type: new graphql_1.GraphQLInputObjectType({
                name: "LimitInput",
                fields: {
                    default: {
                        description: "If no limit argument is supplied on query will fallback to this value.",
                        type: graphql_1.GraphQLInt,
                    },
                    max: {
                        description: "Maximum limit to be used for queries.",
                        type: graphql_1.GraphQLInt,
                    },
                },
            }),
        },
    },
    locations: [graphql_1.DirectiveLocation.OBJECT],
});
//# sourceMappingURL=query-options.js.map