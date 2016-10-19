This library provides support for saving files in an encrypted form
by using Cipher-block chaining [4] and Offset Codebook Mode [5].
Both use Rijndael [1] as encryption algorithm, which is implemented
natively in Emacs.  Rijndael is a superset of the AES algorithm
[2].  For patent issues about OCB see [6], which allows this
distribution.  Additionally this library provides a password
generator based on AES and random user input.

Config file
Insert "(require 'aes)" into your local .emacs file to load this
library.
Insert "(aes-enable-auto-decryption)" into yout local .emacs file
for convenient automatic recognization of encrypted files during
loading.

Whenever possible, this library should be used byte-compiled, as
this provides a really great performance boost!

Main entry points:

`aes-encrypt-current-buffer' / `aes-decrypt-current-buffer' Ask for
password and encrypt / decrypt current buffer.
`aes-insert-password' Generate a random password from user input.

For customizing this library, there is the customization group aes
in the applications group.

Emacs versions 22 to 23 are recommended.  It should work with
version 21 and 24, but there were no tests.

This implementation allows additionally to the AES specification
blocklengths of 24 and 32 bytes.

Nb denotes the number of 32-bit words in the state.
Nk denotes the number of 32-bit words comprising the cipher key.
Nr denotes the number of rounds.
We allow Nb and Nk to be 4, 6, or 8. and Nr = max(Nb, Nk) + 6

Since Emacs implements integers as 29 bit numbers, it is not
possible to use the optimization, which requires 32 bit numbers.
For details see [3].  This leads to an 8-bit design for this
implementation.  So the following fitting implementation is used
here.
- Multiplication and inverting in GF(2^8) are implemented as a
- table lookups.
- The state is implemented as a string of length 4 * Nb.
- Plaintext and ciphertext are implemented as unibyte strings.
- The expanded key is implemented as a list of length 4 * Nb * (1 +
  Nr) with entries '((A . B) . (C . D)), where A, B, C and D are
  bytes.  It is precalculated before the en-/decryption algorithms.
- The S-boxes are implemented by lookup tables.
- The three operations ByteSub, ShiftRow and MixColumn together
  with round-key-addition are implemented in the functions
  `aes-SubShiftMixKeys' and `aes-InvSubShiftMixKeys' for encryption
  and decryption respectively.
- CBC mode is implemented straightforward, using a Zero or PKCS#7
  [7] padding.  The IV is appended to and saved with the
  ciphertext.
- OCB mode made the implementation of a pmac, based on AES,
  necessary, but the further details were straightforward.  The IV
  is appended to the ciphertext.  During decryption the created
  hash-value is checked.
- the function `aes-key-from-passwd' generates an AES key from an
  user input string (password).
- Further a facility is provided to generate random passwords,
  based on random user input like mousemovement, time and keyinput.
- The ciphertext is usually converted to a base-64 encoded string.

The version of the internal storage format of encrypted data is 1.2.

Known Bugs / TODO:
- Encrypted buffers are Auto-Saved unencrypted.
- This implementation is not resistant against DPA attacks [8].
- `aes-auto-decrypt' is not completely compliant to Emacs standards.
- Handle CBC and OCB in two different functions instead of the
  single function `aes-encrypt-buffer-or-string'.
- `aes-enlarge-to-multiple-num' is a really bad function name.
- don't handle padding in `aes-cbc-encrypt'.

References:
[1] http://csrc.nist.gov/archive/aes/rijndael/Rijndael-ammended.pdf
[2] http://csrc.nist.gov/publications/fips/fips197/fips-197.pdf
[3] http://www.openssl.org/
[4] http://en.wikipedia.org/wiki/Block_cipher_modes_of_operation
[5] http://tools.ietf.org/html/draft-krovetz-ocb-00
[6] http://www.cs.ucdavis.edu/~rogaway/ocb/license.htm
[7] http://tools.ietf.org/html/rfc5652#section-6.3
[8] http://en.wikipedia.org/wiki/Differential_power_analysis
