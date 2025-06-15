# c-buildenv - a containerised c build environment

For those who would prefer not to keep their build tools in their OS (or cant - lookin' at you, SteamOS 👀)

# Instructions

> [!NOTE]
> If you prefer using docker, just replace `podman` with `docker` in any of these commands, and it should work exactly the same.

- Clone this repo
- Put packages required for the build in `packages.txt`, one per line. E.g.

    ```txt
    libssl-dev
    libimlib2-dev
    ```
- Hopefully it will build successfully with:

    ```shell
    make podman-build repo="git://git.suckless.org/st"
    ```

    which will place the build output in `./dist`
- Or you can build and then install it on the host machine with:

    ```shell
    make podman-build-install dest=~/.local
    ```

    which will copy the build to the directory specified for `dest` (default is `~/.local`).
- If the build just isn't working, try using the shell environment to troubleshoot:

    ```shell
    make podman-shell
    ```

    this will not run the build command (including installing from packages.txt), so you need to run that with `./build.sh` once you have a shell on the buildenv container
- If you built the application with `make podman-build` but didn't install it yet, you can also do it after the fact with `make install dest="/path/to/install/dir"` (default is `~/.local`)

# Workflow/Optimisation

You can speed things up a bit by modifying the requirements that are installed in the Dockerfile.
Remove any you know you don't need, add ones that you know you need.
It just speeds up the whole process if you're troubleshooting because you're not waiting around for packages to install every time.

# TODO
- [ ] Add make targets for a container that mounts a local folder instead of cloning a repo from the remote
