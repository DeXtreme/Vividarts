data "aws_iam_policy_document" "eks_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "eks_role" {
  name               = "vividarts-eks-role"
  assume_role_policy = data.aws_iam_policy_document.eks_role.json
}

resource "aws_iam_role_policy_attachment" "eks_role" {
  role       = aws_iam_role.eks_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}


data "aws_iam_policy_document" "eks_node_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "eks_node_role" {
  name               = "vividarts-eks-node-role"
  assume_role_policy = data.aws_iam_policy_document.eks_node_role.json
}

resource "aws_iam_role_policy_attachment" "eks_node_role_worker" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "eks_node_role_ecr" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}


resource "aws_iam_role_policy_attachment" "eks_node_role_cni" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}


data "aws_iam_policy_document" "lambda" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}


data "aws_iam_policy_document" "lambda_s3" {
  statement {
    effect = "Allow"

    actions = [
      "s3:ListBucket",
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]
    resources = [
      aws_s3_bucket.results.arn,
      "${aws_s3_bucket.results.arn}/*"
    ]
  }
}

data "aws_iam_policy_document" "lambda_lambda" {
  statement {
    effect = "Allow"

    actions = [
      "lambda:InvokeFunction",
    ]
    resources = [
     "arn:aws:lambda:us-east-1:226535979006:function:*" 
    ]
  }
}


resource "aws_iam_role" "lambda" {
  name               = "vividarts-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.lambda.json
  inline_policy {
    name   = "vividarts-s3-access"
    policy = data.aws_iam_policy_document.lambda_s3.json
  }
  inline_policy {
    name   = "vividarts-lambda-access"
    policy = data.aws_iam_policy_document.lambda_lambda.json
  }
}

resource "aws_iam_role_policy_attachment" "lambda" {
  role       = aws_iam_role.lambda.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
