# Deploy a VM on AWS with AWS-CDK using typescript

## Creation

Get the available templates

```sh
$ cdk init --list
Available templates:
* app: Template for a CDK Application
   └─ cdk init app --language=[csharp|fsharp|go|java|javascript|python|typescript]
* lib: Template for a CDK Construct Library
   └─ cdk init lib --language=typescript
* sample-app: Example CDK Application with some constructs
   └─ cdk init sample-app --language=[csharp|fsharp|go|java|javascript|python|typescript]
```

Create an ap

```sh
$ cdk init app --language typescript
```

### Documentation

* [aws construct library](https://docs.aws.amazon.com/cdk/api/v2/docs/aws-construct-library.html)

## Deployment

Bootstrap the CDK environment (based on Cloud Formation)

```sh
$ time cdk deploy --require-approval never

✨  Synthesis time: 3.13s

TsStack: deploying... [1/1]
TsStack: creating CloudFormation changeset...

 ✅  TsStack

✨  Deployment time: 174.99s

Stack ARN:
arn:aws:cloudformation:eu-central-1:857198930267:stack/TsStack/e56e0620-63b8-11ef-9396-02cd0e43d265

✨  Total time: 178.12s

cdk deploy --require-approval never  6.85s user 1.09s system 4% cpu 2:58.97 total
```

## Decomission

Destroy the stack.

```$ time cdk destroy -f
TsStack: destroying... [1/1]

 ✅  TsStack: destroyed

cdk destroy -f  6.61s user 1.03s system 8% cpu 1:26.36 total
```

Clean up CDK resources

* delete the cloud formation CDK stack
* empty and delete the CDK S3 bucket

## From the template README.md

This is a blank project for CDK development with TypeScript.

The `cdk.json` file tells the CDK Toolkit how to execute your app.

### Useful commands

* `npm run build`   compile typescript to js
* `npm run watch`   watch for changes and compile
* `npm run test`    perform the jest unit tests
* `npx cdk deploy`  deploy this stack to your default AWS account/region
* `npx cdk diff`    compare deployed stack with current state
* `npx cdk synth`   emits the synthesized CloudFormation template
