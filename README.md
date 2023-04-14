# OVERRIDE

### Installing the CLI

1.  Download the TAR file containing the latest stable release of the Salesforce CLI for Linux.

    ```bash
    wget https://developer.salesforce.com/media/salesforce-cli/sfdx/channels/stable/sfdx-linux-x64.tar.xz
    ```
2.  Create the directory where you want to install Salesforce CLI.

    ```bash
    mkdir ~/sfdx
    ```
3.  Unpack the contents for your TAR file:

    * `-C` unpacks the contents in the `~/sfdx directory`, while `--strip-components 1` removes the root path component.

    ```bash
    tar xJf sfdx-linux-x64.tar.xz -C ~/sfdx --strip-components 1
    ```
4.  Update your PATH environment variable to include the Salesforce CLI bin directory. For example, to set it for your current terminal session:

    ```bash
    export PATH=~/sfdx/bin:$PATH
    ```
5.  To update your PATH environment variable permanently, add the appropriate entry to your shell’s configuration file. For example, if you use the Bash shell, add this line to your `~/.bashrc` or `~/.bash_profile` file:

    ```bash
    PATH=~/sfdx/bin:$PATH
    export PATH
    ```
6.  Verify the installation:

    ```bash
    sfdx --version
    ```
7.  Something like this should print to the terminal.

    ```bash
    sfdx-cli/7.74.1-32db2396ed wsl-x64 node-v12.18.3
    ```

### Authenticating the CLI

1. Close any open Bash (Linux) sessions and open a new one.
2. Log into SFDC as normal in the default web browser.
3.  Authenticate the CLI to allow it to access SFDC as your user profile:

    ```bash
    sfdx auth:web:login -a sfdc
    ```

    * The default web browser should open a page that looks like the image below:\
      ![](images/auth.jpg)
4. Click the appropriate username under Saved Username.
5. A page should appear asking to Allow Access for the CLI. Click **Allow**.
6. Check back in the terminal where a message should indicate the CLI has been authenticated.
