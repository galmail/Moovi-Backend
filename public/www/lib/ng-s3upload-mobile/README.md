ng-s3upload-mobile - Mobile Friendly File Upload to S3 using AngularJS
===========

This project is a fork of the original [ng-s3upload github repo](https://github.com/asafdav/ng-s3upload) by Asaf David. It adds HTML5 mobile friendly syntaxis for file validation, thanks to Francesco Iovine [media capture example](http://www.francesco.iovine.name/w3c/mediacapture/)

## Download Options

#### Bower 
```
bower install ng-s3upload-mobile
```

#### Npm
```
npm install ng-s3upload-mobile
```

## Setup

1. Setup your AWS S3 bucket

Please refer to [this github repo](https://github.com/asafdav/ng-s3upload)

2. Create a server side service that will return the needed details for uploading files to S3.
your service shall return a json in the following format: 

  ```json
  {
   "policy": "XXXX",
   "signature": "YYY",
   "key": "ZZZ"
  }
  ```
XXX - A policy json that is required by AWS, base64 encoded.
YYY - HMAC and sha of your private key
ZZZ - Your public key

For more info on how to do it, please check [this github repo](https://github.com/asafdav/ng-s3upload)

## Usage

1. Add ng-s3upload.js to your main file (index.html)

2. If you have not already done so, include [ngSanitize]( http://ajax.googleapis.com/ajax/libs/angularjs/1.0.3/angular-sanitize.js) in your application.

3. Set `ngS3upload` as a dependency in your module
  ```javascript
  var myapp = angular.module('myapp', ['ngS3upload-mobile'])
  ```

4. Add s3-upload directive to the wanted element, example:
  ```html
  <div s3-upload bucket="s3Bucket" ng-model="product.remote_product_file_url"
     s3-upload-options="{getOptionsUri: s3OptionsUri, folder: 'images/'}">
  ```

attributes: 
* bucket - Specify the wanted bucket
* s3-upload-options - Provide additional options:
  * getOptionsUri - The uri of the server service that is needed to sign the request (mentioned in section Setup#4) - Required. 
  * folder - optional, specifies a folder inside the bucket the save the file to
  * enableValidation - optional, set to "false" in order to disable the field validation.
  * targetFilename - An optional attribute for the target filename. if provided the file will be renamed to the provided value instead of having the file original filename.
  
## Themes
ng-s3upload allows to customize the directive template using themes. Currently the available themes are: bootstrap2, bootstrap3

#### How to?

```javascript
app.config(function(ngS3Config) {
  ngS3Config.theme = 'bootstrap3';
});
```

