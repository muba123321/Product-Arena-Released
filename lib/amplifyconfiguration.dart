const amplifyconfig = ''' {
    "UserAgent": "aws-amplify-cli/2.0",
    "Version": "1.0",
    "api": {
        "plugins": {
            "awsAPIPlugin": {
                "api69a54e7e": {
                    "endpointType": "REST",
                    "endpoint": "https://14fthj4mi3.execute-api.us-east-1.amazonaws.com/dev",
                    "region": "us-east-1",
                    "authorizationType": "AWS_IAM"
                },
                "lecturesroles": {
                    "endpointType": "REST",
                    "endpoint": "https://97yz8f00p4.execute-api.us-east-1.amazonaws.com/dev",
                    "region": "us-east-1",
                    "authorizationType": "AWS_IAM"
                },
                "UserObjectInitialization": {
                    "endpointType": "REST",
                    "endpoint": "https://0j3tlh8ebf.execute-api.us-east-1.amazonaws.com/dev",
                    "region": "us-east-1",
                    "authorizationType": "AWS_IAM"
                },
                "getUserLectures": {
                    "endpointType": "REST",
                    "endpoint": "https://tewntuwg12.execute-api.us-east-1.amazonaws.com/dev",
                    "region": "us-east-1",
                    "authorizationType": "AWS_IAM"
                },
                "updateLastStoppedDelta": {
                    "endpointType": "REST",
                    "endpoint": "https://2c167fis4d.execute-api.us-east-1.amazonaws.com/dev",
                    "region": "us-east-1",
                    "authorizationType": "AWS_IAM"
                },
                "getLecturesOrder": {
                    "endpointType": "REST",
                    "endpoint": "https://5wymaudv1h.execute-api.us-east-1.amazonaws.com/dev",
                    "region": "us-east-1",
                    "authorizationType": "AWS_IAM"
                },
                "contactEmailDelta": {
                    "endpointType": "REST",
                    "endpoint": "https://ee2pn2jym0.execute-api.us-east-1.amazonaws.com/dev",
                    "region": "us-east-1",
                    "authorizationType": "AWS_IAM"
                }
            }
        }
    },
    "auth": {
        "plugins": {
            "awsCognitoAuthPlugin": {
                "UserAgent": "aws-amplify-cli/0.1.0",
                "Version": "0.1.0",
                "IdentityManager": {
                    "Default": {}
                },
                "CredentialsProvider": {
                    "CognitoIdentity": {
                        "Default": {
                            "PoolId": "us-east-1:a714ad99-8f18-40b2-9b5c-a65e6da51bd7",
                            "Region": "us-east-1"
                        }
                    }
                },
                "CognitoUserPool": {
                    "Default": {
                        "PoolId": "us-east-1_Y59HRuokp",
                        "AppClientId": "71n2nju4n74f9cs85d8cddsq4d",
                        "Region": "us-east-1"
                    }
                },
                "Auth": {
                    "Default": {
                        "authenticationFlowType": "USER_SRP_AUTH",
                        "socialProviders": [],
                        "usernameAttributes": [
                            "EMAIL"
                        ],
                        "signupAttributes": [
                            "ADDRESS",
                            "BIRTHDATE",
                            "EMAIL",
                            "FAMILY_NAME",
                            "GIVEN_NAME",
                            "PHONE_NUMBER"
                        ],
                        "passwordProtectionSettings": {
                            "passwordPolicyMinLength": 8,
                            "passwordPolicyCharacters": []
                        },
                        "mfaConfiguration": "OFF",
                        "mfaTypes": [
                            "SMS"
                        ],
                        "verificationMechanisms": [
                            "EMAIL"
                        ]
                    }
                }
            }
        }
    }
}''';
