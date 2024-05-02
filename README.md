# Deploy Phoenix to Azure

Phoenix provides MLOps and LLMOps insights at lightning speed with zero-config observability. Phoenix provides a notebook-first experience for monitoring your models and LLM Applications by providing:

LLM Traces - Trace through the execution of your LLM Application to understand the internals of your LLM Application and to troubleshoot problems related to things like retrieval and tool execution.
LLM Evals - Leverage the power of large language models to evaluate your generative model or application's relevance, toxicity, and more.
Embedding Analysis - Explore embedding point-clouds and identify clusters of high drift and performance degradation.
RAG Analysis - Visualize your generative application's search and retrieval process to identify problems and improve your RAG pipeline.
Structured Data Analysis - Statistically analyze your structured data by performing A/B analysis, temporal drift analysis, and more.

Table of contents:

- [Opening this project](#opening-this-project)
  - [GitHub Codespaces](#github-codespaces)
  - [VS Code Dev Containers](#vs-code-dev-containers)
  - [Local environment](#local-environment)
- [Deploying to Azure](#deploying-to-azure)
- [Disclaimer](#disclaimer)

## Opening this project

You have a few options for setting up this project.
The easiest way to get started is GitHub Codespaces, since it will setup all the tools for you,
but you can also [set it up locally](#local-environment) if desired.

### GitHub Codespaces

You can run this repo virtually by using GitHub Codespaces, which will open a web-based VS Code in your browser:

[![Open in GitHub Codespaces](https://img.shields.io/static/v1?style=for-the-badge&label=GitHub+Codespaces&message=Open&color=brightgreen&logo=github)](https://codespaces.new/arize-ai/phoenix-on-azure)

Once the codespace opens (this may take several minutes), open a terminal window.

### VS Code Dev Containers

A related option is VS Code Dev Containers, which will open the project in your local VS Code using the [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers):

1. Start Docker Desktop (install it if not already installed)
1. Open the project:
   [![Open in Dev Containers](https://img.shields.io/static/v1?style=for-the-badge&label=Dev%20Containers&message=Open&color=blue&logo=visualstudiocode)](https://vscode.dev/redirect?url=vscode://ms-vscode-remote.remote-containers/cloneInVolume?url=https://github.com/arize-ai/phoenix-on-azure)
1. In the VS Code window that opens, once the project files show up (this may take several minutes), open a terminal window.

### Local environment

1. Install the required tools:

   - [Azure Developer CLI](https://aka.ms/azure-dev/install)
   - [Python 3.9, 3.10, or 3.11](https://www.python.org/downloads/) (Only necessary if you want to enable authentication)

2. Create a new folder and switch to it in the terminal.
3. Run this command to download the project code:

   ```shell
   azd init -t phoenix-on-azure
   ```

   Note that this command will initialize a git repository, so you do not need to clone this repository.

4. Create a Python virtual environment and install the required packages:

   ```shell
   pip install -r requirements.txt
   ```

5. Open a terminal window inside the project folder.

## Deploying to Azure

Follow these steps to deploy Phoenix to Azure:

1. Login to your Azure account:

   ```shell
   azd auth login
   ```

1. Create a new azd environment:

   ```shell
   azd env new
   ```

   Enter a name that will be used for the resource group.
   This will create a new folder in the `.azure` folder, and set it as the active environment for any calls to `azd` going forward.

1. Run this command to provision all the resources:

   ```shell
   azd provision
   ```

   This will create a new resource group, and create the Azure Container App and PostgreSQL Flexible server inside that group.
   It will use the `init.sh` and `post.sh` hooks to set up default secrets, and pass the necessary environment variables to the Azure Container App.

1. Once the deployment is complete, you will see the URL for the Azure Container App in the output. You can open this URL in your browser to see the Phoenix web app.

## Disclaimer

Phoenix is an external project and is not affiliated with Microsoft.
