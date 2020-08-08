# rekognition_with_s3_flutter

A Flutter app which can be used to detect labels from images uploaded to S3.<br>
**About the App**:-<br>
This app users to upload images to their S3 bucket with the help of Keys which they have generated from IAM used in AWS.Once the Image is uploaded then the user can detect Labels from the Uploaded image for which we pass the filename with which we have stored the file in the S3 bucket.<br>
Also for storing the file in the S3 bucket we have converted the image into b64bytes which are passed along with the filename into the API created with the help of Lambda function and deployed with the help of API gateway in AWS.
<br>Once we get the response of the API in the form of JSON we then extract out the label names out of them and then display those labels on the screen.<br>
We can also use the labels accordingly.
<br>
The images which are stored in the S3 bucket have '.jpg' extension but cannot be viewed inside the image viewer.
<br>
__How to do this:-__<br>
Things which are done in this app:-<br>
* API's
* Lambda Function Calling and deployment
* AWS
* Image picker
* Json data formatting and dealing
___
Built in:-
* Flutter
___
Some snaps from the app:-
* Full video:-<br>
* Images uploaded in S3:-<br>
<img src="https://res.cloudinary.com/harshkumarkhatri/image/upload/v1596892571/readme%20images/rekognition%20with%20s3%20flutter/Screenshot_from_2020-08-08_18-45-41_cgz7te.png">
* Images from app<br>
<img src="https://res.cloudinary.com/harshkumarkhatri/image/upload/v1596892572/readme%20images/rekognition%20with%20s3%20flutter/Screenshot_from_2020-08-08_18-42-59_j9t9vp.png">
<img src="https://res.cloudinary.com/harshkumarkhatri/image/upload/v1596892573/readme%20images/rekognition%20with%20s3%20flutter/Screenshot_from_2020-08-08_18-43-25_xnurk7.png">
<img src="https://res.cloudinary.com/harshkumarkhatri/image/upload/v1596892572/readme%20images/rekognition%20with%20s3%20flutter/Screenshot_from_2020-08-08_18-43-35_k1s1rm.png">
## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
