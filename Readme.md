![Giftoppr](https://github.com/desktoppr/giftoppr/blob/master/app/assets/images/logo.png?raw=true)

[![Build Status](https://travis-ci.org/desktoppr/giftoppr.png?branch=master)](https://travis-ci.org/desktoppr/giftoppr)

### Getting started

You'll first need to grab a Dropbox API key from here: https://www.dropbox.com/developers.

When asked (full dropbox, or single folder only) choose single folder.

Set these env variables

```bash
DROPBOX_KEY=""
DROPBOX_SECRET=""
```

Then:

```bash
git clone git@github.com:desktoppr/giftoppr.git
cd giftoppr
bundle
rake db:schema:load
rake db:seed # Loads in gifs from ~/Dropbox/Apps/Giftoppr
rails server
```

### Heroku

Ensure environment variables are available during deploys.

```bash
heroku labs:enable user-env-compile
```

Increase maximum database connections to 20

```bash
heroku config -s | awk '/^DATABASE_URL=/{print $0 "?pool=20"}' | xargs heroku config:add
```

You'll need these environment variables for asset_sync and S3

### Environment Variables

```bash
DROPBOX_KEY=""
DROPBOX_SECRET=""
AWS_ACCESS_KEY_ID=""
AWS_SECRET_ACCESS_KEY=""
FOG_DIRECTORY=""
FOG_HOST=""
FOG_PROVIDER=""
ASSET_SYNC_GZIP_COMPRESSION=true
SECRET_TOKEN=""
```

### CORS and S3

If you're hosting the gifs on S3, you'll need to edit its CORS configuration so it allows XHR requests

```xml
<?xml version="1.0" encoding="UTF-8"?>
<CORSConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
    <CORSRule>
        <AllowedOrigin>*</AllowedOrigin>
        <AllowedMethod>GET</AllowedMethod>
        <AllowedMethod>POST</AllowedMethod>
        <AllowedMethod>PUT</AllowedMethod>
        <AllowedHeader>*</AllowedHeader>
    </CORSRule>
</CORSConfiguration>
```
