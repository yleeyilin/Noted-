const { ApolloServer } = require('apollo-server');
const { expect } = require('chai');
const createApolloServer = require('/Users/leeyilin/Noted-/GraphQLServer/index.js');
const { createTestClient } = require('apollo-server-testing');
const fetch = require('node-fetch');

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
});
