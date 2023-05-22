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
exports.callbackDirective = void 0;
const graphql_1 = require("graphql");
const CallbackOperation_1 = require("./arguments/enums/CallbackOperation");
const description = "NOTE: this directive has been deprecated and will be removed in @neo4j/graphql version 4.0.0. " +
    "Please use the @populatedBy directive instead. More information can be found at " +
    "https://neo4j.com/docs/graphql-manual/current/guides/v4-migration/#_callback_renamed_to_populatedby. " +
    "Instructs @neo4j/graphql to invoke the specified callback function when updating or " +
    "creating the properties on a node or relationship.";
/** Deprecated in favour of @populatedBy */
exports.callbackDirective = new graphql_1.GraphQLDirective({
    name: "callback",
    description,
    locations: [graphql_1.DirectiveLocation.FIELD_DEFINITION],
    args: {
        operations: {
            description: "Which events to invoke the callback on.",
            defaultValue: CallbackOperation_1.CallbackOperationEnum.getValues().map((v) => v.value),
            type: new graphql_1.GraphQLNonNull(new graphql_1.GraphQLList(new graphql_1.GraphQLNonNull(CallbackOperation_1.CallbackOperationEnum))),
        },
        name: {
            description: "The name of the callback function.",
            type: new graphql_1.GraphQLNonNull(graphql_1.GraphQLString),
        },
    },
});
//# sourceMappingURL=callback.js.map