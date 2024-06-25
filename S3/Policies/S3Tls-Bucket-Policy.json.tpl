{
  "Version": "2012-10-17",
  "Id": "Policy1718282404818",
  "Statement": [
    {
      "Sid": "${sid-name}",
      "Effect": "Deny",
      "Principal": "*",
      "Action": "s3:*",
      "Resource": [
        "${bucket-arn}",
        "${bucket-arn}/*"
      ],
      "Condition": {
        "Bool": {
          "aws:SecureTransport": "false"
        }
      }
    }
  ]
}
