# Giftoppr

### Environment Variables

```bash
DROPBOX_KEY=""
DROPBOX_SECRET=""
```

### Heroku

```bash
heroku labs:enable user-env-compile
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
