# go-autograder-template

This template is intended to be used in conjunction with https://github.com/ucla-progsoftsys/go-autograder as a private repository and easily build the zip file to upload to gradescope

## Using this template

Optionally fork this repository into a (probably private) copy, or clone this repository locally with `git clone --recurse-submodules <repo-URL>` (or if you forgot to do `--recurse-submodules`, run `git submodule update --init`). Edit the configuration as required following the below information. Once done, run `./go-autograder/create_zip.sh` to create an `autograder.zip` file to upload to Gradescope, using the Ubuntu 22.04 Default base image. The Github Actions included in this template will run `create_zip.sh` and create the autograder for you - note that due to how Github Actions artifact uploading works, you need to unzip the Github-generated zip file, and then upload to gradescope the zip file extracted.

## Config files

### `autograder.config.json`
This JSON file is where you will configure your autograder for your particular assignment. In this file, you must specify the names of the tests you want to use for grading, along with associated point values.

```json=
{
    "visibility": "visible", // Optional visibility setting for autograder results: visible, hidden, after_due_date, after_published
    "uploader": "bashupload.com", // Optional: Defines location to upload results.json file, visible to students. Currently, only bashupload.com is supported
    "ratelimit": { // Optional: Defines ratelimit of log uploading. 
        "count": 2,
        "minutes": 20
    },
    "tests": [
        {
            "name": "TestAddTwoNumbers",  // The name of the test (must match the test name as defined in test files)
            "number": "1.1", // Optional (will just be numbered in order of array if no number given)
            "points": 5, // The point value of the test case
            "visibility": "visible", // Optional: visibility setting for test case: visible, hidden, after_due_date, after_published
            "folder": "main", // Optional: directory to run go test in, relative to root folder of submission files
            "timeout": "600s", // Optional: test timeout for go test command - fails if it goes beyond this time
            "count": 4 // Optional: specify number of times to run test case - if it fails once, entire test case fails. Note that timeouts (if set) are per run, not across all runs in a single test case
        },
        {
            "name": "TestAddTwoNegativeNumbers",
            "number": "1.2",
            "points": 5,
            "visibility": "visible"
        },
        {
            "name": "TestAddNums",
            "number": "2.1",
            "points": 5,
            "visibility": "visible"
        },
        {
            "name": "TestAddNumsOne",
            "number": "2.2",
            "points": 5,
            "visibility": "visible"
        }
    ]
}
```

### replacement_files/
This folder's contents will be overlayed on top of students' submissions before running tests. For example, if students should have a `main/test_test.go` file, make the file `replacement_files/main/test_test.go`, which will replace (or add) that file in the student's code but keep any other files inside of the `main` folder submitted.

### custom_setup.sh
This shell script is run (using `source custom_setup.sh`) during autograder build time. Specify the `GO_VERSION` variable value to the version of go to install.

### custom_run_autograder.sh
This shell script is run after the student's submission is copied into `/autograder/source/submission` and had their files overlayed, but before running the test cases. This can be used to, for example, check integrity of parts of files in the submission, verify file structure, check for extraneous/missing files, or search for known suspicious strings.

### required_files.txt
Put one path per line to a file that should exist - if any file path does not exist, the autograder will reject the submission and give 0 points.

## Testing

Put the files in the `submission` folder to simulate a student uploading their work, and then run `./run_autograder.sh`. Run `./run_autograder.sh -d` to drop into a shell, similarly to the "Debug via SSH" functionality of Gradescope.
