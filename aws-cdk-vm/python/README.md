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
$ cdk init app --language python
$ ./.venv/bin/activate
$ pip install -r requirements.txt
```

### Documentation

* [aws construct library](https://docs.aws.amazon.com/cdk/api/v2/docs/aws-construct-library.html)

## Deployment

Bootstrap the CDK environment (based on Cloud Formation)

```sh
$ time cdk deploy --require-approval never

✨  Synthesis time: 6.25s

test1-cdk-python-vm:  start: Building a5175fae1dc6d0e0591f5688720efaf9bd723966c33607b4f6816df971abd8e4:current_account-current_region
test1-cdk-python-vm:  success: Built a5175fae1dc6d0e0591f5688720efaf9bd723966c33607b4f6816df971abd8e4:current_account-current_region
test1-cdk-python-vm:  start: Publishing a5175fae1dc6d0e0591f5688720efaf9bd723966c33607b4f6816df971abd8e4:current_account-current_region
test1-cdk-python-vm:  success: Published a5175fae1dc6d0e0591f5688720efaf9bd723966c33607b4f6816df971abd8e4:current_account-current_region
test1-cdk-python-vm: deploying... [1/1]
test1-cdk-python-vm: creating CloudFormation changeset...

 ✅  test1-cdk-python-vm

✨  Deployment time: 199.94s

Stack ARN:
arn:aws:cloudformation:eu-central-1:857198930267:stack/test1-cdk-python-vm/62ba7080-6541-11ef-80df-06a87bdaf341

✨  Total time: 206.2s

```

## Decomission

Destroy the stack.

```$ time cdk destroy -f
test1-cdk-python-vm: destroying... [1/1]

 ✅  test1-cdk-python-vm: destroyed

cdk destroy -f  6.05s user 0.97s system 11% cpu 1:02.52 total
```

Clean up CDK resources

* delete the cloud formation CDK stack
* empty and delete the CDK S3 bucket

## From the template README.md

This is a blank project for CDK development with Python.

The `cdk.json` file tells the CDK Toolkit how to execute your app.

This project is set up like a standard Python project.  The initialization
process also creates a virtualenv within this project, stored under the `.venv`
directory.  To create the virtualenv it assumes that there is a `python3`
(or `python` for Windows) executable in your path with access to the `venv`
package. If for any reason the automatic creation of the virtualenv fails,
you can create the virtualenv manually.

To manually create a virtualenv on MacOS and Linux:

```
$ python3 -m venv .venv
```

After the init process completes and the virtualenv is created, you can use the following
step to activate your virtualenv.

```
$ source .venv/bin/activate
```

If you are a Windows platform, you would activate the virtualenv like this:

```
% .venv\Scripts\activate.bat
```

Once the virtualenv is activated, you can install the required dependencies.

```
$ pip install -r requirements.txt
```

At this point you can now synthesize the CloudFormation template for this code.

```
$ cdk synth
```

To add additional dependencies, for example other CDK libraries, just add
them to your `setup.py` file and rerun the `pip install -r requirements.txt`
command.

## Useful commands

 * `cdk ls`          list all stacks in the app
 * `cdk synth`       emits the synthesized CloudFormation template
 * `cdk deploy`      deploy this stack to your default AWS account/region
 * `cdk diff`        compare deployed stack with current state
 * `cdk docs`        open CDK documentation

Enjoy!
