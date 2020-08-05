
# import json
# import boto3
# import base64

# ACCESS_KEY = "AKIA4OFZD2XGTLIAAW2R"
# SECRET_KEY = "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"

# s3 = boto3.client('s3',aws_access_key_id=ACCESS_KEY,
#                       aws_secret_access_key=SECRET_KEY)
# rekognition = boto3.client('rekognition', 'ap-south-1',aws_access_key_id=ACCESS_KEY,
#                       aws_secret_access_key=SECRET_KEY)

# def lambda_handler(event, context):
#     name = event['name']
#     image = event['image']
#     # image = image[image.find(",")+1:]
#     dec = base64.b64decode(image + "===")
#     s3.put_object(Bucket='reko-test-harsh', Key=name, Body=dec)
#     response = rekognition.detect_labels(
#         Image={
#             'S3Object': {
#                 'Bucket': 'reko-test-harsh',
#                 'Name': name,
#             }
#         },
#         MaxLabels=10,
#         MinConfidence=90,
#     )
    
#     return {'statusCode': 200, 'body': response, 'headers': {'Access-Control-Allow-Origin': '*'}} 



# This is the testing for cloudinary
# import json
# import boto3
# import base64
# from io import BytesIO
# # import requests
# import urllib3
# http = urllib3.PoolManager()


# ACCESS_KEY = "AKIA4OFZD2XGTLIAAW2R"
# SECRET_KEY = "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"

# s3 = boto3.client('s3',aws_access_key_id=ACCESS_KEY,
#                       aws_secret_access_key=SECRET_KEY)
# rekognition = boto3.client('rekognition', 'ap-south-1',aws_access_key_id=ACCESS_KEY,
#                       aws_secret_access_key=SECRET_KEY)

# def lambda_handler(event, context):
    
#     # byte_in=event['url']
#     # image = event['image']
#     # image = image[image.find(",")+1:]
#     # dec = base64.b64decode(image + "===")
#     # s3.put_object(Bucket='reko-test-harsh', Key=name, Body=dec)
#     # with open(event['image', "rb") as cf:
#     #     base64_image=base64.b64encode(cf.read())
#     #     base_64_binary = base64.decodebytes(base64_image)
#     image=base64.b64encode(event['image'])
#     filename='x.png'
#     with open(filename, 'wb') as f:
#         f.write(imgdata)
    
#     response = http.request('GET', event['image'])
#     print(res)
#     # response.raw.decode_content = True
#     # image = Image.open(response)
#     with open(response, 'rb') as image:
#         response = client.detect_labels(Image={'Bytes': image.read()})
    
#     response = rekognition.detect_labels(
#         Image={'Bytes':image.read()
#         },
#         MaxLabels=10,
#         MinConfidence=90,
#     )
    
#     return {'statusCode': 200, 'body': response, 'headers': {'Access-Control-Allow-Origin': '*'}} 






import json
import boto3
import base64
import credentials

s3 = boto3.client('s3',aws_access_key_id=credentials.ACCESS_KEY,
                      aws_secret_access_key=credentials.SECRET_KEY)
rekognition = boto3.client('rekognition', 'ap-south-1',aws_access_key_id=credentials.ACCESS_KEY,
                      aws_secret_access_key=credentials.SECRET_KEY)

def lambda_handler(event, context):
    name = event['name']
    image = event['image']
    # image = image[image.find(",")+1:]
    dec = base64.b64decode(image + "===")
    s3.put_object(Bucket='reko-test-harsh', Key=name, Body=dec)
    response = rekognition.detect_labels(
        Image={
            'Bytes':image
        },
        MaxLabels=10,
        MinConfidence=90,
    )
    
    return {'statusCode': 200, 'body': response, 'headers': {'Access-Control-Allow-Origin': '*'}} 