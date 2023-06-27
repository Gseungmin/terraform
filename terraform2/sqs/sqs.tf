resource "aws_s3_bucket" "sqs_bucket" {
  bucket = "ji-sqs-test-bucket"
}

resource "aws_sqs_queue" "queue" {
  name                      = "my-queue"
  delay_seconds             = 0
  max_message_size          = 262144
  message_retention_seconds = 345600
  receive_wait_time_seconds = 0
}

data "aws_iam_policy_document" "s3_queue_policy" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    }

    actions = ["sqs:SendMessage"]

    resources = [aws_sqs_queue.queue.arn]

    condition {
      test     = "ArnLike"
      variable = "aws:SourceArn"
      values   = [aws_s3_bucket.sqs_bucket.arn]
    }
  }
}

resource "aws_sqs_queue_policy" "s3_queue_policy" {
  queue_url = aws_sqs_queue.queue.id
  policy    = data.aws_iam_policy_document.s3_queue_policy.json
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.sqs_bucket.id

  queue {
    queue_arn     = aws_sqs_queue.queue.arn
    events        = ["s3:ObjectCreated:*"]
    filter_suffix = ".log"
  }
  depends_on = [aws_sqs_queue_policy.s3_queue_policy]
}

