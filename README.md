# go-autograder-template

This template is intended to be used in conjunction with https://github.com/ucla-progsoftsys/go-autograder as a private repository and easily build the zip file to upload to gradescope

## Using this template

Optionally fork this repository into a (probably private) copy, or clone this repository locally with `git clone --recurse-submodules <repo-URL>`. Edit the configuration as required following the below information. Once done, run `./go-autograder/create_zip.sh` to create an `autograder.zip` file to upload to Gradescope, using the Ubuntu 22.04 Default base image. The Github Actions included in this template will run `create_zip.sh` and create the autograder for you - note that due to how Github Actions artifact uploading works, you need to unzip the Github-generated zip file, and then upload to gradescope the zip file extracted.

## Config files

See `go-autograder/README.md` for configuration information, as exact options may change depending on the version of the autograder you are using. If this folder is empty, run `git submodule update --init` to populate its contents.

## Testing

Put the files in the `submission` folder to simulate a student uploading their work, and then run `./run_autograder.sh`. Run `./run_autograder.sh -d` to drop into a shell, similarly to the "Debug via SSH" functionality of Gradescope.
