const { ApolloServer } = require('apollo-server');
const { expect } = require('chai');
const createApolloServer = require('/Users/leeyilin/Noted-/GraphQLServer/index.js');
const { createTestClient } = require('apollo-server-testing');
const fetch = require('node-fetch');
const { gql } = require('apollo-server');


describe('Server', function () {
  let server;
  let serverUrl;
  let testClient;

  before(async function () {
    server = await createApolloServer();
    testClient = createTestClient(server);
    serverUrl = (await server.listen()).url;
    console.log(`🚀 Server started at ${serverUrl}`);
  });

  after(async function () {
    await server.stop();
  });

  it('should start without errors', function () {
    expect(server).to.exist;
  });

  it('should return a successful response', async function () {
    const { query } = testClient;
    const GET_USERS_QUERY = `
      query {
        users {
          name
          email
        }
      }
    `;

    const response = await query({ query: GET_USERS_QUERY });
    expect(response.errors).to.be.undefined;
    expect(response.data).to.exist;
    expect(response.data.users).to.be.an('array');
    });

    it("should return a username by email", async () => {
      const { query } = testClient;
      const GET_USER_BY_EMAIL = gql`
        query FindUserName($currEmail: String!) {
          users(where: { email: $currEmail }) {
            name
          }
        }
      `;
    const userEmail = "e0970388@u.nus.edu";
    const userQuery = await query({
      query: GET_USER_BY_EMAIL,
      variables: { 'currEmail': userEmail },
    });
    expect(userQuery.data.users[0].name).to.equal("Lee Yi Lin");
  });

    it("should return a reputation score by email", async () => {
      const { query } = testClient;
      const GET_USER_BY_EMAIL = gql`
        query FindUser($email: String!) {
          users(where: { email: $email }) {
            reputation
          }
        }
      `;
    const userEmail = "e0970388@u.nus.edu";
    const repQuery = await query({
      query: GET_USER_BY_EMAIL,
      variables: { 'email': userEmail },
    });
    expect(repQuery.data.users[0].reputation).to.equal(0);
  });
});
