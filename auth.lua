---@class authentication_handler_definition
---@field get_auth fun(name: string): {password: string, privileges: table<string, boolean>, last_login: integer|nil}
---@field create_auth fun(name: string, password: string)
---@field delete_auth fun(name: string): boolean
---@field set_password fun(name: string, password: string)
---@field set_privileges fun(name: string, privileges: table<string, boolean>)
---@field reload fun(): boolean
---@field record_login fun(name: string)
---@field iterate fun()

---Registers an auth handler that overrides the builtin one.
---
---This function can be called by a single mod once only.
---@param authentication_handler authentication_handler_definition
function minetest.register_authentication_handler(authentication_handler) end

---Return the currently active auth handler.
---
---Use this to e.g. get the authentication data for a player: `local auth_data = minetest.get_auth_handler().get_auth(playername)`
---@return authentication_handler_definition
function minetest.get_auth_handler() end

---Must be called by the authentication handler for privilege changes.
---@param name? string If omitted, all auth data should be considered modified
function minetest.notify_authentication_modified(name) end

---Set password hash of player `name`.
---@param name string
---@param password_hash string
function minetest.set_player_password(name, password_hash) end

---Set privileges of player `name`.
---@param name string
---@param privs table<string, boolean>
function minetest.set_player_privs(name, privs) end

---See `reload()` in authentication handler definition.
---@return boolean
function minetest.auth_reload() end

---Returns an IP address string for the player `name`.
---
---The player needs to be online for this to be successful.
---@param name string
---@return string
function minetest.get_player_ip(name) end

---Convert a name-password pair to a password hash that Minetest can use.
---
---The returned value alone is not a good basis for password checks based on comparing the password hash in the database with the password hash from the function, with an externally provided password, as the hash in the db might use the new SRP verifier format.
---
---For this purpose, use `minetest.check_password_entry` instead.
---@param name string
---@param raw_password string
function minetest.get_password_hash(name, raw_password) end

---Returns true if the "password entry" for a player with name matches given password, false otherwise.
---
---The "password entry" is the password representation generated by the engine as returned as part of a `get_auth()` call on the auth handler.
---
---Only use this function for making it possible to log in via password from external protocols such as IRC, other uses are frowned upon.
---@param name string
---@param entry string
---@param password string
function minetest.check_password_entry(name, entry, password) end

---Converts string representation of privs into table form.
---@param str string
---@param delim? string String separating the privs. Defaults to `","`.
---@return table<string, boolean>
function minetest.string_to_privs(str, delim) end

---Returns the string representation of `privs`
---@param privs table<string, boolean>
---@param delim? string String separating the privs. Defaults to `","`.
---@return string
function minetest.privs_to_string(privs, delim) end

---Returns player privs.
---@param name string
---@return table<string, boolean>
function minetest.get_player_privs(name) end

---Check if player have given privileges.
---@param player_or_name ObjectRef|string Either a Player object or the name of a player.
---@param ... any Is either a list of strings, e.g. `"priva", "privb"` or a table, e.g. `{ priva = true, privb = true }`.
---@return boolean
---@return table<string, boolean> missing_privs
function minetest.check_player_privs(player_or_name, ...) end