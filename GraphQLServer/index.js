const { Neo4jGraphQL } = require("@neo4j/graphql");
const { ApolloServer, gql } = require("apollo-server");
const neo4j = require("neo4j-driver");

const typeDefs = gql`

    type User {
        name: String
        email: String 
        read: [Article!]! @relationship(type: "READ", direction: OUT)
        likes: [Interest!]! @relationship(type: "LIKES", direction: OUT)
        posted: [Notes!]! @relationship(type: "POSTER", direction: IN)
        written: [Article!]! @relationship(type: "WRITTEN", direction: IN)
    }
    
    type Course {
        name: String
        notes: [Notes!]! @relationship(type: "NOTES", direction: IN)
    }
    
    type Notes {
        name: String
        address: String
        course: [Course!]! @relationship(type: "NOTES", direction: OUT) 
        author: [User!]! @relationship(type: "POSTER", direction: OUT)
    }
    
    type Article {
        title: String
        summary: String
        address: String
        articles: [User!]! @relationship(type: "READ", direction: IN)
        includes: [Interest!]! @relationship(type: "INCLUDES", direction: IN)
        author: [User!]! @relationship(type: "WRITTEN", direction: OUT)
    }
    
    type Interest {
        name: String
        interests: [User!]! @relationship(type: "LIKES", direction: IN)
        includes: [Article!]! @relationship(type: "INCLUDES", direction: OUT)
    }
    
`;

const driver = neo4j.driver(
    "neo4j+s://f68363e2.databases.neo4j.io",
    neo4j.auth.basic("neo4j", "CCE-9y4M1VWFvtaOIuli84-LhP6vMbniNQze5WrX7WE")
);

const createApolloServer = async () => {
    const neoSchema = new Neo4jGraphQL({ typeDefs, driver });
    const schema = await neoSchema.getSchema();
  
    return new ApolloServer({ schema });
  };
  
module.exports = createApolloServer;

// const neoSchema = new Neo4jGraphQL({ typeDefs, driver });

// neoSchema.getSchema().then((schema) => {
//     const server = new ApolloServer({
//         schema,
//     });
  
//     server.listen().then(({ url }) => {
//         console.log(`🚀 Server ready at ${url}`);
//     });
//   })
