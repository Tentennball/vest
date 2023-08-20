const getRandomAdmin = (adminSocketIds) => {
  const randomIdx = Math.floor(Math.random() * adminSocketIds.length);
  return adminSocketIds[randomIdx];
};

module.exports = { getRandomAdmin };
