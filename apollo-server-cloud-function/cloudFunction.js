const { graphqlFunction } = require('./index');

exports.runApolloServer = async (req, res) => {
  // Implement CORS headers if needed
  res.set('Access-Control-Allow-Origin', '*');
  res.set('Access-Control-Allow-Methods', 'POST, GET, OPTIONS');
  res.set('Access-Control-Allow-Headers', 'Content-Type');

  // Check if the request is a preflight (OPTIONS) request and respond with 204 No Content
  if (req.method === 'OPTIONS') {
    return res.status(204).send('');
  }

  // Call the GraphQL function as the request handler
  return graphqlFunction(req, res);
};
