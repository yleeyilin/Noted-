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
const graphql_1 = require("graphql");
const NodeDirective_1 = require("../classes/NodeDirective");
const deprecationWarning = "The plural argument has been deprecated and will be removed in version 4.0." +
    "Please use the @plural directive instead. More information can be found at " +
    "https://neo4j.com/docs/graphql-manual/current/guides/v4-migration/" +
    "#_plural_argument_removed_from_node_and_replaced_with_plural.";
let pluralDeprecationWarningShown = false;
const labelDeprecationWarning = "NOTE: The label and additionalLabels arguments have been deprecated and will be removed in version 4.0.0. " +
    "Please use the labels argument instead. More information can be found at " +
    "https://neo4j.com/docs/graphql-manual/current/guides/v4-migration/" +
    "#_label_and_additionalLabels_arguments_removed_from_node_and_replaced_with_new_argument_labels";
let labelDeprecationWarningShown = false;
function parseNodeDirective(nodeDirective) {
    if (!nodeDirective || nodeDirective.name.value !== "node") {
        throw new Error("Undefined or incorrect directive passed into parseNodeDirective function");
    }
    const plural = getArgumentValue(nodeDirective, "plural");
    if (plural && !pluralDeprecationWarningShown) {
        console.warn(deprecationWarning);
        pluralDeprecationWarningShown = true;
    }
    const label = getArgumentValue(nodeDirective, "label");
    const additionalLabels = getArgumentValue(nodeDirective, "additionalLabels");
    if ((label || additionalLabels) && !labelDeprecationWarningShown) {
        console.warn(labelDeprecationWarning);
        labelDeprecationWarningShown = true;
    }
    return new NodeDirective_1.NodeDirective({
        label,
        additionalLabels,
        plural,
        labels: getArgumentValue(nodeDirective, "labels"),
    });
}
function getArgumentValue(directive, name) {
    const argument = directive.arguments?.find((a) => a.name.value === name);
    return argument ? (0, graphql_1.valueFromASTUntyped)(argument.value) : undefined;
}
exports.default = parseNodeDirective;
//# sourceMappingURL=parse-node-directive.js.map