// Admin
/**
 * Key : admin ID
 *
 * Value : userlist that "key" is managing
 */
let adminToUser = new Map();

/**
 * Number of all admin in server
 */
let adminNum = 0;

// User
/**
 * Key : user ID
 *
 * Value : admin ID (who manages Key)
 */
let userToAdmin = new Map();
/**
 * List of userSocket ID
 */
let userSockets = new Set();

/**
 * Number of all user in server
 */
let userNum = 0;

// Exports
/**
 * This datas should be used with consistency
 */
module.exports = {
  adminToUser,
  adminNum,
  userToAdmin,
  userSockets,
  userNum,
};
