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
exports.filterByRelationshipProperties = exports.filterByProperties = exports.compareProperties = void 0;
const neo4j_driver_1 = require("neo4j-driver");
const utils_1 = require("../../../../translate/where/utils");
const utils_2 = require("../../../../utils/utils");
/**
 * Returns true if all properties in obj1 exists in obj2, false otherwise.
 * Properties can only be primitives or Array<primitive>
 */
function compareProperties(obj1, obj2) {
    if (!(0, utils_2.isSameType)(obj1, obj2) || !(0, utils_2.haveSameLength)(obj1, obj2)) {
        return false;
    }
    for (const [k, value] of Object.entries(obj1)) {
        const otherValue = obj2[k];
        if (otherValue === null || otherValue === undefined) {
            return false;
        }
        if (Array.isArray(value) && (0, utils_2.isSameType)(value, otherValue)) {
            const areArraysMatching = compareProperties(value, otherValue);
            if (!areArraysMatching) {
                return false;
            }
        }
        if (!Array.isArray(value) && (0, utils_2.isSameType)(value, otherValue) && otherValue !== value) {
            return false;
        }
    }
    return true;
}
exports.compareProperties = compareProperties;
function isFloatType(fieldMeta) {
    return fieldMeta?.typeMeta.name === "Float";
}
function isStringType(fieldMeta) {
    return fieldMeta?.typeMeta.name === "String";
}
function isIDType(fieldMeta) {
    return fieldMeta?.typeMeta.name === "ID";
}
function isIDAsString(fieldMeta, value) {
    return isIDType(fieldMeta) && (0, neo4j_driver_1.int)(value).toString() !== value;
}
const operatorCheckMap = {
    NOT: (received, filtered) => received !== filtered,
    LT: (received, filtered, fieldMeta) => {
        if (isFloatType(fieldMeta)) {
            return received < filtered;
        }
        return (0, neo4j_driver_1.int)(received).lessThan((0, neo4j_driver_1.int)(filtered));
    },
    LTE: (received, filtered, fieldMeta) => {
        if (isFloatType(fieldMeta)) {
            return received <= filtered;
        }
        return (0, neo4j_driver_1.int)(received).lessThanOrEqual((0, neo4j_driver_1.int)(filtered));
    },
    GT: (received, filtered, fieldMeta) => {
        if (isFloatType(fieldMeta)) {
            return received > filtered;
        }
        return (0, neo4j_driver_1.int)(received).greaterThan((0, neo4j_driver_1.int)(filtered));
    },
    GTE: (received, filtered, fieldMeta) => {
        if (isFloatType(fieldMeta)) {
            return received >= filtered;
        }
        // int/ bigint
        return (0, neo4j_driver_1.int)(received).greaterThanOrEqual((0, neo4j_driver_1.int)(filtered));
    },
    STARTS_WITH: (received, filtered) => received.startsWith(filtered),
    NOT_STARTS_WITH: (received, filtered) => !received.startsWith(filtered),
    ENDS_WITH: (received, filtered) => received.endsWith(filtered),
    NOT_ENDS_WITH: (received, filtered) => !received.endsWith(filtered),
    CONTAINS: (received, filtered) => received.includes(filtered),
    NOT_CONTAINS: (received, filtered) => !received.includes(filtered),
    INCLUDES: (received, filtered, fieldMeta) => {
        if (isFloatType(fieldMeta) || isStringType(fieldMeta) || isIDAsString(fieldMeta, filtered)) {
            return received.findIndex((v) => v === filtered) !== -1;
        }
        // int/ bigint
        const filteredAsNeo4jInteger = (0, neo4j_driver_1.int)(filtered);
        return received.findIndex((r) => (0, neo4j_driver_1.int)(r).equals(filteredAsNeo4jInteger)) !== -1;
    },
    NOT_INCLUDES: (received, filtered, fieldMeta) => {
        if (isFloatType(fieldMeta) || isStringType(fieldMeta) || isIDAsString(fieldMeta, filtered)) {
            return received.findIndex((v) => v === filtered) === -1;
        }
        // int/ bigint
        const filteredAsNeo4jInteger = (0, neo4j_driver_1.int)(filtered);
        return received.findIndex((r) => (0, neo4j_driver_1.int)(r).equals(filteredAsNeo4jInteger)) === -1;
    },
    IN: (received, filtered, fieldMeta) => {
        if (isFloatType(fieldMeta) || isStringType(fieldMeta) || isIDAsString(fieldMeta, received)) {
            return filtered.findIndex((v) => v === received) !== -1;
        }
        // int/ bigint
        const receivedAsNeo4jInteger = (0, neo4j_driver_1.int)(received);
        return filtered.findIndex((r) => (0, neo4j_driver_1.int)(r).equals(receivedAsNeo4jInteger)) !== -1;
    },
    NOT_IN: (received, filtered, fieldMeta) => {
        if (isFloatType(fieldMeta) || isStringType(fieldMeta) || isIDAsString(fieldMeta, received)) {
            return filtered.findIndex((v) => v === received) === -1;
        }
        // int/ bigint
        const receivedAsNeo4jInteger = (0, neo4j_driver_1.int)(received);
        return filtered.findIndex((r) => (0, neo4j_driver_1.int)(r).equals(receivedAsNeo4jInteger)) === -1;
    },
};
function getFilteringFn(operator) {
    if (!operator) {
        return (received, filtered) => received === filtered;
    }
    return operatorCheckMap[operator];
}
function parseFilterProperty(key) {
    const match = utils_1.whereRegEx.exec(key);
    if (!match) {
        throw new Error(`Failed to match key in filter: ${key}`);
    }
    const { fieldName, operator } = match.groups;
    if (!fieldName) {
        throw new Error(`Failed to find field name in filter: ${key}`);
    }
    return { fieldName, operator };
}
const multipleConditionsAggregationMap = {
    AND: (results) => {
        for (const res of results) {
            if (!res) {
                return false;
            }
        }
        return true;
    },
    OR: (results) => {
        for (const res of results) {
            if (res) {
                return true;
            }
        }
        return false;
    },
    NOT: (result) => {
        return !result;
    },
};
/** Returns true if receivedProperties comply with filters specified in whereProperties, false otherwise. */
function filterByProperties(node, whereProperties, receivedProperties) {
    for (const [k, v] of Object.entries(whereProperties)) {
        if (Object.keys(multipleConditionsAggregationMap).includes(k)) {
            const comparisonResultsAggregationFn = multipleConditionsAggregationMap[k];
            let comparisonResults;
            if (k === "NOT") {
                comparisonResults = filterByProperties(node, v, receivedProperties);
            }
            else {
                comparisonResults = v.map((whereCl) => {
                    return filterByProperties(node, whereCl, receivedProperties);
                });
            }
            if (!comparisonResultsAggregationFn(comparisonResults)) {
                return false;
            }
        }
        else {
            const { fieldName, operator } = parseFilterProperty(k);
            const receivedValue = receivedProperties[fieldName];
            if (!receivedValue) {
                return false;
            }
            const fieldMeta = node.primitiveFields.find((f) => f.fieldName === fieldName);
            const checkFilterPasses = getFilteringFn(operator);
            if (!checkFilterPasses(receivedValue, v, fieldMeta)) {
                return false;
            }
        }
    }
    return true;
}
exports.filterByProperties = filterByProperties;
function filterByRelationshipProperties({ node, whereProperties, receivedEvent, nodes, relationshipFields, }) {
    const receivedEventProperties = receivedEvent.properties;
    const receivedEventRelationshipType = receivedEvent.relationshipName;
    const relationships = node.relationFields.filter((f) => f.type === receivedEventRelationshipType);
    if (!relationships.length) {
        return false;
    }
    const receivedEventRelationship = relationships[0]; // ONE relationship only possible
    for (const [wherePropertyKey, wherePropertyValue] of Object.entries(whereProperties)) {
        const { fieldName } = parseFilterProperty(wherePropertyKey);
        const connectedNodeFieldName = node.subscriptionEventPayloadFieldNames.create_relationship;
        if (fieldName === connectedNodeFieldName) {
            const key = receivedEventRelationship.direction === "IN" ? "to" : "from";
            if (!filterByProperties(node, wherePropertyValue, receivedEventProperties[key])) {
                return false;
            }
        }
        if (fieldName === "createdRelationship" || fieldName === "deletedRelationship") {
            const receivedEventRelationshipName = receivedEventRelationship.fieldName;
            const receivedEventRelationshipData = wherePropertyValue[receivedEventRelationshipName];
            const isRelationshipOfReceivedTypeFilteredOut = !receivedEventRelationshipData;
            if (isRelationshipOfReceivedTypeFilteredOut) {
                // case `actors: {}` filtering out relationships of other type
                return false;
            }
            const isRelationshipOfReceivedTypeIncludedWithNoFilters = !Object.keys(receivedEventRelationshipData).length;
            if (isRelationshipOfReceivedTypeIncludedWithNoFilters) {
                // case `actors: {}` including all relationships of the type
                return true;
            }
            const relationshipPropertiesInterfaceName = receivedEventRelationship.properties || "";
            const { edge: edgeProperty, node: nodeProperty, ...unionTypes } = receivedEventRelationshipData;
            if (edgeProperty &&
                !filterRelationshipEdgeProperty({
                    relationshipFields,
                    relationshipPropertiesInterfaceName,
                    edgeProperty,
                    receivedEventProperties,
                })) {
                return false;
            }
            const key = receivedEventRelationship.direction === "IN" ? "from" : "to";
            if (nodeProperty) {
                if (isInterfaceType(nodeProperty, receivedEventRelationship)) {
                    const targetNodeTypename = receivedEvent[`${key}Typename`];
                    if (!filterRelationshipInterfaceProperty({
                        nodeProperty,
                        nodes,
                        receivedEventProperties,
                        targetNodeTypename,
                        key,
                    })) {
                        return false;
                    }
                }
                else if (isStandardType(nodeProperty, receivedEventRelationship)) {
                    // standard type fields
                    const nodeTo = nodes.find((n) => n.name === receivedEventRelationship.typeMeta.name);
                    if (!filterByProperties(nodeTo, nodeProperty, receivedEventProperties[key])) {
                        return false;
                    }
                }
            }
            if (Object.keys(unionTypes).length) {
                // union types
                const targetNodeTypename = receivedEvent[`${key}Typename`];
                const targetNodePropsByTypename = unionTypes[targetNodeTypename];
                const isRelationshipOfReceivedTypeFilteredOut = !targetNodePropsByTypename;
                if (isRelationshipOfReceivedTypeFilteredOut) {
                    return false;
                }
                if (!filterRelationshipUnionProperties({
                    targetNodePropsByTypename,
                    targetNodeTypename,
                    receivedEventProperties,
                    relationshipFields,
                    relationshipPropertiesInterfaceName,
                    key,
                    nodes,
                })) {
                    return false;
                }
            }
        }
    }
    return true;
}
exports.filterByRelationshipProperties = filterByRelationshipProperties;
function isInterfaceType(node, receivedEventRelationship) {
    return !!receivedEventRelationship.interface?.implementations;
}
function isStandardType(node, receivedEventRelationship) {
    return !receivedEventRelationship.interface?.implementations;
}
function isInterfaceSpecificFieldType(node) {
    return !!node;
}
function filterRelationshipEdgeProperty({ relationshipFields, relationshipPropertiesInterfaceName, edgeProperty, receivedEventProperties, }) {
    const relationship = relationshipFields.get(relationshipPropertiesInterfaceName);
    const noRelationshipPropertiesFound = !relationship;
    if (noRelationshipPropertiesFound) {
        return true;
    }
    return filterByProperties(relationship, edgeProperty, receivedEventProperties.relationship);
}
function filterRelationshipUnionProperties({ targetNodePropsByTypename, targetNodeTypename, receivedEventProperties, relationshipFields, relationshipPropertiesInterfaceName, key, nodes, }) {
    for (const [propertyName, propertyValueAsUnionTypeData] of Object.entries(targetNodePropsByTypename)) {
        if (propertyName === "node") {
            const nodeTo = nodes.find((n) => targetNodeTypename === n.name);
            if (!filterByProperties(nodeTo, propertyValueAsUnionTypeData, receivedEventProperties[key])) {
                return false;
            }
        }
        if (propertyName === "edge" &&
            !filterRelationshipEdgeProperty({
                relationshipFields,
                relationshipPropertiesInterfaceName,
                edgeProperty: propertyValueAsUnionTypeData,
                receivedEventProperties,
            })) {
            return false;
        }
    }
    return true;
}
function filterRelationshipInterfaceProperty({ nodeProperty, nodes, receivedEventProperties, targetNodeTypename, key, }) {
    const { _on, ...commonFields } = nodeProperty;
    const targetNode = nodes.find((n) => n.name === targetNodeTypename);
    if (commonFields && !_on) {
        if (!filterByProperties(targetNode, commonFields, receivedEventProperties[key])) {
            return false;
        }
    }
    if (isInterfaceSpecificFieldType(_on)) {
        const isRelationshipOfReceivedTypeFilteredOut = !_on[targetNodeTypename];
        if (isRelationshipOfReceivedTypeFilteredOut) {
            return false;
        }
        const commonFieldsMergedWithSpecificFields = { ...commonFields, ..._on[targetNodeTypename] }; //override common <fields, filter> combination with specific <fields, filter>
        if (!filterByProperties(targetNode, commonFieldsMergedWithSpecificFields, receivedEventProperties[key])) {
            return false;
        }
    }
    return true;
}
//# sourceMappingURL=compare-properties.js.map