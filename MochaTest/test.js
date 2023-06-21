const { ApolloServer } = require('apollo-server');
const { expect } = require('chai');
const createApolloServer = require('/Users/leeyilin/Noted-/GraphQLServer/index.js');

describe('Server', function () {
  let server;

  before(async function () {
    server = await createApolloServer();
    const { url } = await server.listen();
    console.log(`🚀 Server started at ${url}`);
  });

  after(async function () {
    await server.stop();
  });

  it('should start without errors', function () {
    expect(server).to.exist;
  });

  // Add more test cases as needed
});
