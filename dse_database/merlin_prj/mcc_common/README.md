# common-makefile

Contains the common Makefile (currently) shared by:

- merlin_benchmark
- case_studies
- merlin_examples

## Usage

### Cloning

Since this repo primarily exists as a Git submodule of some other repo, begin begin by choosing a parent repository (for instance, one of the above).
Suppose, for instance, you've chosen case_studies:

```bash
$ git clone --recursive /uri/of/case_studies.git
```

Note the `--recursive` flag, which instructs Git to clone both the parent repo (case studies) and its submodules (currently only the common Makefile repo).

Alternatively, as a two-step process:

```bash
# Do a shallow clone of the parent repo:
$ git clone /uri/of/case_studies.git

# Clone the common Makefile submodule.
$ cd case_studies
$ git submodule init
$ git submodule update
```

### Updating the submodule

Git submodules are, in essence, sub-directories within an outer repository.
Submodules are also Git repositories of their own.

```bash
# Enter the common Makefile submodule's sub-directory.
$ cd /uri/of/case_studies/common

# Make changes to the submodule
$ echo "stuff" > ./new-file

# Commit it just like you would any other repo
$ pwd
/uri/of/case_studies/common
$ git add ./new-file
$ git commit -m 'Added stuff.'
$ git push

# Now we'll need to update the parent repository to point to the submodule's new commit
$ cd ..; pwd
/uri/of/case_studies
$ git add ./common
$ git commit -m 'Track the updated submodule.'
$ git push
```
