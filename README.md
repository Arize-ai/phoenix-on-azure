# Deploy Phoenix to Azure

[![Open in GitHub Codespaces](https://img.shields.io/static/v1?style=for-the-badge&label=GitHub+Codespaces&message=Open&color=brightgreen&logo=github)](https://codespaces.new/arize-ai/phoenix-on-azure)
[![Open in Dev Containers](https://img.shields.io/static/v1?style=for-the-badge&label=Dev%20Containers&message=Open&color=blue&logo=visualstudiocode)](https://vscode.dev/redirect?url=vscode://ms-vscode-remote.remote-containers/cloneInVolume?url=https://github.com/arize-ai/phoenix-on-azure)

Phoenix provides MLOps and LLMOps insights at lightning speed with zero-config observability. Phoenix provides a notebook-first experience for monitoring your models and LLM Applications by providing:

![Example Image](https://storage.googleapis.com/arize-assets/phoenix/assets/images/phoenix_azure_azd3.png)

- LLM Traces - Trace through the execution of your LLM Application to understand the internals of your LLM Application and to troubleshoot problems related to things like retrieval and tool execution.
- LLM Evals - Leverage the power of large language models to evaluate your generative model or application's relevance, toxicity, and more.
  Embedding Analysis - Explore embedding point-clouds and identify clusters of high drift and performance degradation.
- RAG Analysis - Visualize your generative application's search and retrieval process to identify problems and improve your RAG pipeline.
  Structured Data Analysis - Statistically analyze your structured data by performing A/B analysis, temporal drift analysis, and more.

![Example Image](https://storage.googleapis.com/arize-assets/phoenix/assets/images/phoenix_azure_azd2.png)

Table of contents:

- [Getting Started](#getting-started)
  - [GitHub Codespaces](#github-codespaces)
  - [VS Code Dev Containers](#vs-code-dev-containers)
  - [Local environment](#local-environment)
- [Guidance](#guidance)
  - [Costs](#costs)
- [Disclaimer](#disclaimer)

## Getting Started

You have a few options for getting started with this template. The quickest way to get started is [GitHub Codespaces](#github-codespaces), since it will setup all the tools for you, but you can also [set it up locally](#local-environment). You can also use a [VS Code dev container](#vs-code-dev-containers)

### GitHub Codespaces

You can run this template virtually by using GitHub Codespaces. The button will open a web-based VS Code instance in your browser:

1. Open the template (this may take several minutes)
   [![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](placeholder)
2. Open a terminal window
3. Sign into your Azure account:

   ```shell
    azd auth login --use-device-code
   ```

4. Provision the Azure resources and deploy your code:

   ```shell
   azd up
   ```

5. To view the endpoint, follow the "Phoenix UI link"

6. Optionally, you can configure a CI/CD pipeline:

   ```shell
   azd pipeline config
   ```

### VS Code Dev Containers

A related option is VS Code Dev Containers, which will open the project in your local VS Code using the [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers):

1. Start Docker Desktop (install it if not already installed)
2. Open the project:
   [![Open in Dev Containers](https://img.shields.io/static/v1?style=for-the-badge&label=Dev%20Containers&message=Open&color=blue&logo=visualstudiocode)](placeholder)
3. In the VS Code window that opens, once the project files show up (this may take several minutes), open a terminal window.
4. Sign into your Azure account:

   ```shell
    azd auth login
   ```

5. Provision the Azure resources and deploy your code:

   ```shell
   azd up
   ```

6. To view the endpoint, follow the "Phoenix UI link"

7. Optionally, you can configure a CI/CD pipeline:

   ```shell
   azd pipeline config
   ```

### Local Environment

#### Prerequisites

- [Azure Developer CLI](https://aka.ms/azure-dev/install)
- [Python 3.9, 3.10, or 3.11](https://www.python.org/downloads/) (Only necessary if you want to enable authentication)

#### Quickstart

1. Run this command to download the project code:

   ```shell
   azd init -t Arize-ai/phoenix-on-azure
   ```

   Note: this command will initialize a git repository, so you do not need to clone this repository.

2. Create a Python virtual environment and install the required packages:

   ```shell
   pip install -r requirements.txt
   ```

3. Sign into your Azure account:

   ```shell
    azd auth login
   ```

4. Create a new azd environment:

   ```shell
   azd env new
   ```

   Enter a name that will be used for the resource group.
   This will create a new folder in the `.azure` folder, and set it as the active environment for any calls to `azd` going forward.

5. Run this command to provision all the resources:

   If you want your data to be persisted between deployments, you can set the `PERSISTENCE` environment variable to `true` before running the `provision` command.

   ```shell
   azd config set alpha.resourceGroupDeployments on
   # azd env set PERSISTENCE true
   azd provision
   ```

   This will create a new resource group, and create the Azure Container App and PostgreSQL Flexible server inside that group.
   It will use the `init.sh` and `post.sh` hooks to set up default secrets, and pass the necessary environment variables to the Azure Container App.

6. In order to deploy this template, you will need to turn on the resource group scoped deployments alpha feature. [Learn more about azd's feature versioning strategy](https://learn.microsoft.com/azure/developer/azure-developer-cli/feature-versioning).

   ```shell
   azd config set alpha.resourceGroupDeployments on
   ```

7. If you want your data to be persisted between deployments, you can set the `PERSISTENCE` environment variable to `true` before running the `up` command:

   ```shell
   azd env set PERSISTENCE true
   ```

8. Provision and deploy the project to Azure:

   ```shell
   azd up
   ```

   This will create a new resource group, and create the Azure Container App and PostgreSQL Flexible server inside that group.
   It will use the `init.sh` and `post.sh` hooks to set up default secrets, and pass the necessary environment variables to the Azure Container App.

9. To view the endpoint, follow the "Phoenix UI link"

10. Optionally, you can configure a CI/CD pipeline:

    ```shell
    azd pipeline config
    ```

## Guidance

### Costs

You can estimate the cost of this project's architecture with [Azure's pricing calculator](https://azure.microsoft.com/pricing/calculator/)

- Azure Container Apps - Consumption tier [pricing](https://azure.microsoft.com/pricing/details/container-apps/)
- Azure Monitor - Pay-as-you-go tier [pricing](https://azure.microsoft.com/pricing/details/monitor/)

## Disclaimer

Phoenix is an external project and is not affiliated with Microsoft.
