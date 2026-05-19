# motd.sh
*Colorful MOTD (message of the day) written in bash. Server status at a glance.*  
[![MIT Licence](https://raw.githubusercontent.com/WieWaldi/badges/master/badges/licence_mit.svg)](https://opensource.org/licenses/mit-license.php)
![Maintained](https://raw.githubusercontent.com/WieWaldi/badges/master/badges/maintained_yes-green.svg)

# Contributing
If you have an idea or feature request please open an [issue][1], even if you
don't have time to contribute!

## Making Changes
To get started, [fork][2] this repository on GitHub and clone a working copy for
development:

    $ git clone git@github.com:WieWaldi/motd.sh.git

Once you are finished, be sure to test changes locally and verify installation
by issuing:

    # export DESTDIR=`mktemp -d`
    # make install

Finally, commit your changes and create a [pull request][3] against the `master`
branch for review.

## Making New Releases
Making new releases is automated by GitHub Actions. Releases should only be
created from the `master` branch.

To make a new release, follow these steps:

1. Verify the latest results of the [CI][4] workflow on the `master` branch.

2. Create a release tag by issuing:

       $ git tag -a -m 'Release v<version>' v<version>

3. Push the release tag to the remote repository and verify the results of the
   [Release][5] workflow:

       $ git push origin --tags

## License
By contributing to this repository, you agree that your contributions will be
licensed under its MIT License. See the [LICENSE][7] file for details.

[1]: https://github.com/WieWaldi/motd.sh/issues
[2]: https://docs.github.com/en/github/getting-started-with-github/fork-a-repo
[3]: https://docs.github.com/en/github/collaborating-with-issues-and-pull-requests/creating-a-pull-request
[4]: https://github.com/WieWaldi/motd.sh/actions/workflows/ci.yml
[5]: https://github.com/WieWaldi/motd.sh/actions/workflows/release.yml
[6]: https://docs.freebsd.org/en/books/porters-handbook/upgrading/
[7]: https://github.com/WieWaldi/motd.sh/blob/master/LICENSE
