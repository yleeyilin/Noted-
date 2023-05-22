const { Neo4jGraphQL } = require("@neo4j/graphql");
const { ApolloServer, gql } = require("apollo-server");
const neo4j = require("neo4j-driver");

const typeDefs = gql`

    scalar PDF

    type User {
        name: String
        email: String 
        read: [Article!]! @relationship(type: "READ", direction: IN)
        likes: [Interest!]! @relationship(type: "LIKES", direction: IN)
    }

    type Article {
        title: String
        file: PDF
        articles: [User!]! @relationship(type: "READ", direction: OUT)
        includes: [Interest!]! @relationship(type: "INCLUDES", direction: IN)
    }

    type Interest {
        name: String
        interests: [User!]! @relationship(type: "LIKES", direction: OUT)
        includes: [Article!]! @relationship(type: "INCLUDES", direction: OUT)
    }
`;

const driver = neo4j.driver(
    "bolt://f68363e2.databases.neo4j.io:7687",
    neo4j.auth.basic("neo4j", "CCE-9y4M1VWFvtaOIuli84-LhP6vMbniNQze5WrX7WE")
);

const neoSchema = new Neo4jGraphQL({ typeDefs, driver });

neoSchema.getSchema().then((schema) => {
    const server = new ApolloServer({
        schema,
    });
  
    server.listen().then(({ url }) => {
        console.log(`🚀 Server ready at ${url}`);
    });
  })