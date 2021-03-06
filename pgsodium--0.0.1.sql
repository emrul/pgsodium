-- complain if script is sourced in psql, rather than via CREATE EXTENSION
\echo Use "CREATE EXTENSION pgsodium" to load this file. \quit

CREATE FUNCTION randombytes_random()
RETURNS integer
AS '$libdir/pgsodium', 'pgsodium_randombytes_random'
LANGUAGE C VOLATILE;

CREATE FUNCTION randombytes_uniform(upper_bound integer)
RETURNS integer
AS '$libdir/pgsodium', 'pgsodium_randombytes_uniform'
LANGUAGE C VOLATILE STRICT;

CREATE FUNCTION randombytes_buf(size integer)
RETURNS bytea
AS '$libdir/pgsodium', 'pgsodium_randombytes_buf'
LANGUAGE C VOLATILE STRICT;

CREATE FUNCTION crypto_secretbox_keygen()
RETURNS bytea
AS '$libdir/pgsodium', 'pgsodium_crypto_secretbox_keygen'
LANGUAGE C VOLATILE;

CREATE FUNCTION crypto_secretbox_noncegen()
RETURNS bytea
AS '$libdir/pgsodium', 'pgsodium_crypto_secretbox_noncegen'
LANGUAGE C VOLATILE;

CREATE FUNCTION crypto_secretbox(message text, nonce bytea, key bytea)
RETURNS bytea
AS '$libdir/pgsodium', 'pgsodium_crypto_secretbox'
LANGUAGE C IMMUTABLE STRICT;

CREATE FUNCTION crypto_secretbox_open(ciphertext bytea, nonce bytea, key bytea)
RETURNS text
AS '$libdir/pgsodium', 'pgsodium_crypto_secretbox_open'
LANGUAGE C IMMUTABLE STRICT;

CREATE FUNCTION crypto_auth(message text, key bytea)
RETURNS bytea
AS '$libdir/pgsodium', 'pgsodium_crypto_auth'
LANGUAGE C IMMUTABLE STRICT;

CREATE FUNCTION crypto_auth_verify(mac bytea, message text, key bytea)
RETURNS boolean
AS '$libdir/pgsodium', 'pgsodium_crypto_auth_verify'
LANGUAGE C IMMUTABLE STRICT;

CREATE FUNCTION crypto_auth_keygen()
RETURNS bytea
AS '$libdir/pgsodium', 'pgsodium_crypto_auth_keygen'
LANGUAGE C VOLATILE;

CREATE FUNCTION crypto_generichash(message text, key bytea DEFAULT NULL)
RETURNS bytea
AS '$libdir/pgsodium', 'pgsodium_crypto_generichash'
LANGUAGE C VOLATILE;

CREATE FUNCTION crypto_shorthash(message text, key bytea)
RETURNS bytea
AS '$libdir/pgsodium', 'pgsodium_crypto_shorthash'
LANGUAGE C VOLATILE STRICT;

CREATE TYPE crypto_box_keypair AS (public bytea, secret bytea);

CREATE OR REPLACE FUNCTION crypto_box_new_keypair()
RETURNS SETOF crypto_box_keypair
AS '$libdir/pgsodium', 'pgsodium_crypto_box_keypair'
LANGUAGE C VOLATILE;

CREATE FUNCTION crypto_box_noncegen()
RETURNS bytea
AS '$libdir/pgsodium', 'pgsodium_crypto_box_noncegen'
LANGUAGE C VOLATILE;

CREATE FUNCTION crypto_box(message text, nonce bytea, public bytea, secret bytea)
RETURNS bytea
AS '$libdir/pgsodium', 'pgsodium_crypto_box'
LANGUAGE C IMMUTABLE STRICT;

CREATE FUNCTION crypto_box_open(ciphertext bytea, nonce bytea, public bytea, secret bytea)
RETURNS text
AS '$libdir/pgsodium', 'pgsodium_crypto_box_open'
LANGUAGE C IMMUTABLE STRICT;

CREATE TYPE crypto_sign_keypair AS (public bytea, secret bytea);

CREATE OR REPLACE FUNCTION crypto_sign_new_keypair()
RETURNS SETOF crypto_sign_keypair
AS '$libdir/pgsodium', 'pgsodium_crypto_sign_keypair'
LANGUAGE C VOLATILE;

CREATE OR REPLACE FUNCTION crypto_sign(message text, key bytea)
RETURNS bytea
AS '$libdir/pgsodium', 'pgsodium_crypto_sign'
LANGUAGE C IMMUTABLE STRICT;

CREATE OR REPLACE FUNCTION crypto_sign_open(signed_message bytea, key bytea)
RETURNS text
AS '$libdir/pgsodium', 'pgsodium_crypto_sign_open'
LANGUAGE C IMMUTABLE STRICT;

CREATE OR REPLACE FUNCTION crypto_pwhash_saltgen()
RETURNS bytea
AS '$libdir/pgsodium', 'pgsodium_crypto_pwhash_saltgen'
LANGUAGE C VOLATILE;

CREATE OR REPLACE FUNCTION crypto_pwhash(password text, salt bytea)
RETURNS bytea
AS '$libdir/pgsodium', 'pgsodium_crypto_pwhash'
LANGUAGE C IMMUTABLE STRICT;

CREATE OR REPLACE FUNCTION crypto_pwhash_str(password text)
RETURNS text
AS '$libdir/pgsodium', 'pgsodium_crypto_pwhash_str'
LANGUAGE C VOLATILE STRICT;

CREATE OR REPLACE FUNCTION crypto_pwhash_str_verify(hashed_password text, password text)
RETURNS bool
AS '$libdir/pgsodium', 'pgsodium_crypto_pwhash_str_verify'
LANGUAGE C IMMUTABLE STRICT;

CREATE OR REPLACE FUNCTION crypto_box_seal(message text, public_key bytea)
RETURNS bytea
AS '$libdir/pgsodium', 'pgsodium_crypto_box_seal'
LANGUAGE C VOLATILE STRICT;

CREATE OR REPLACE FUNCTION crypto_box_seal_open(ciphertext bytea, public_key bytea, secret_key bytea)
RETURNS text
AS '$libdir/pgsodium', 'pgsodium_crypto_box_seal_open'
LANGUAGE C VOLATILE STRICT;
