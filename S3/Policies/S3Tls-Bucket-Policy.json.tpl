{
    "Id": "Policy1718282404818",
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "${sid-name}",
        "Action": "s3:*",
        "Effect": "Allow",
        "Resource": [ "${bucket-arn}/*",
                    "${bucket-arn}"
                ],
        "Condition": {
          "Bool": {
            "aws:SecureTransport": "false"
          },
          "NumericLessThan": {
            "s3:TlsVersion": "1.2"
          }
        },
        "Principal": "*"
      }
    ]
  }