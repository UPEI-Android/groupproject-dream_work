const crypto = require('crypto')
const fs = require('fs')

try {
    let access_token_secret = `ACCESS_TOKEN_SECRET=${crypto.randomBytes(64).toString('hex')}`
    let refresh_token_secret = `REFRESH_TOKEN_SECRET=${crypto.randomBytes(64).toString('hex')}`

    fs.writeFileSync('.env.production', access_token_secret + '\n' + refresh_token_secret)
} catch (err) {
    console.error(err)
}