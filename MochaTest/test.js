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
    console.log('');
    console.log('Starting server testing...');
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


    it("should create user node if user function is called", async () => {
      const { mutate } = testClient;
      const CREATE_USERS_MUTATION = gql`
      mutation CreateUser(\$name: String!, \$email: String!, \$reputation: Int!) {
        createUsers(input: { name: \$name, email: \$email, reputation: \$reputation }) {
          users {
            name
            email
            reputation
          }
        }
      }
    `;
    const name = "Lee Yi Lin";
    const email = "e0970388@u.nus.edu";
    const usersMutation = await mutate({
      mutation: CREATE_USERS_MUTATION,
      variables: { 'name': name,  'email': email, 'reputation': 0},
    });
    console.log('');
    console.log('Starting unit testing...');
    console.log('    Testing node creation...');
    expect(usersMutation.data.createUsers.users[0].name).to.equal(name);
    expect(usersMutation.data.createUsers.users[0].email).to.equal(email);
    expect(usersMutation.data.createUsers.users[0].reputation).to.equal(0);
  });



    it("should create notes node if notes is added", async () => {
      const { mutate } = testClient;
      const CREATE_NOTES_MUTATION = gql`
      mutation CreateNotes($name: String!, $address: String!) {
        createNotes(input: { name: $name, address: $address, likeCount: 0 }) {
          notes {
            name
            address
            likeCount
          }
        }
      }
    `;
    const name = "mock.pdf";
    const articleAddress = "mockaddress";
    const notesMutation = await mutate({
      mutation: CREATE_NOTES_MUTATION,
      variables: { 'name': name,  'address': articleAddress},
    });
    expect(notesMutation.data.createNotes.notes[0].name).to.equal(name);
    expect(notesMutation.data.createNotes.notes[0].address).to.equal(articleAddress);
  });


  it("should create article node if article is added", async () => {
    const { mutate } = testClient;
    const CREATE_ARTICLE_MUTATION = gql`
    mutation CreateArticle(\$title: String!, \$summary: String!, \$address: String!) {
      createArticles(input: { title: \$title, summary: \$summary, address: \$address, likeCount: 0}) {
        articles {
          title
          summary
          address
          likeCount
        }
      }
    }
  `;
  const title = "mocktitle";
  const address = "mockaddress";
  const summary = "mocksummary";
  const articleMutation = await mutate({
    mutation: CREATE_ARTICLE_MUTATION,
    variables: { 'title': title,  'summary': summary, 'address': address},
  });
  expect(articleMutation.data.createArticles.articles[0].title).to.equal(title);
  expect(articleMutation.data.createArticles.articles[0].address).to.equal(address);
  expect(articleMutation.data.createArticles.articles[0].summary).to.equal(summary);
});


  it("should create comment node if comment is added", async () => {
      const { mutate } = testClient;
      const CREATE_COMMENT_MUTATION = gql`
      mutation CreateComment(\$content: String!, \$noteAddress: String!) {
        createComments(input: { content: \$content, noteAddress: \$noteAddress }) {
          comments {
            content
            noteAddress
          }
        }
      }
    `;
    const content = "mockcontent";
    const noteAddress = "mockaddress";
    const commentMutation = await mutate({
      mutation: CREATE_COMMENT_MUTATION,
      variables: { 'content': content,  'noteAddress': noteAddress},
    });
    expect(commentMutation.data.createComments.comments[0].content).to.equal(content);
    expect(commentMutation.data.createComments.comments[0].noteAddress).to.equal(noteAddress);
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
    console.log('    Testing retrieval functions...');
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

  // it("should connect notes to author", async () => {
  //   const mutate = testClient.mutate;
  //   const CONNECT_NOTES_TO_AUTHOR = gql`
  //     mutation ConnectNotesToAuthor($email: String!, $notesAddress: String!) {
  //       updateUsers(
  //         where: { email: $email }
  //         connect: {
  //           posted: {
  //             where: { node: { address: $notesAddress } }
  //           }
  //         }
  //       ) {
  //         users {
  //           name
  //           posted {
  //             name
  //             address
  //           }
  //         }
  //       }
  //     }
  //   `;
  
  //   const email = "e0970388@u.nus.edu";
  //   const notesAddress = "mock_address";
  //   const connMutation = await mutate({
  //     mutation: CONNECT_NOTES_TO_AUTHOR,
  //     variables: { 'email' : email , 'notesAddress' : notesAddress },
  //   });
  
  //   console.log('    Testing relationships functions...');
  //   const user = connMutation.data.updateUsers.users[0];
  //   expect(user.email == email).to.equal(true);
  //   expect(user.posted.length > 0).to.equal(true);
  // });
  
});
