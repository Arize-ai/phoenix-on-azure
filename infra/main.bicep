param name string
param location string = resourceGroup().location
param tags object = {}
param htpasswd string

param storageName string
param containerEnvId string

param env array = []
param imageName string = 'docker.io/arizephoenix/phoenix:sql-9'

resource containerApp 'Microsoft.App/containerApps@2022-11-01-preview' = {
  name: name
  location: location
  tags: tags
  identity: {
    type: 'None'
  }
  properties: {
    environmentId: containerEnvId
    configuration: {
      activeRevisionsMode: 'single'
      ingress: {
        external: true
        targetPort: 80
        allowInsecure: false
      }
      secrets: [
        {
          name: 'phoenix-auth'
          value: htpasswd
        }
        {
          name: 'nginx-conf'
          value: '''
server {
  listen       80;
  server_name  localhost;

  location / {
      auth_basic "Restricted Access";
      auth_basic_user_file /etc/nginx/conf.d/htpasswd;
      proxy_pass http://127.0.0.1:6006;
      proxy_pass_request_headers on;
      proxy_http_version 1.1;
      proxy_set_header Upgrade $http_upgrade;
      proxy_set_header Connection "upgrade";
  }
  error_page   500 502 503 504  /50x.html;
  location = /50x.html {
      root   /usr/share/nginx/html;
  }
}
'''
        }
      ]
    }
    template: {
      containers: [
        {
          image: 'docker.io/library/nginx:latest'
          name: 'nginx'
          resources: {
            cpu: '0.5'
            memory: '1Gi'
          }
          volumeMounts: [
            {
              volumeName: 'nginx-conf'
              mountPath: '/etc/nginx/conf.d'
            }
          ]
        }
        {
          image: imageName
          name: name
          env: concat(
            [
              {
                name: 'PHOENIX_WORKING_DIR'
                value: '/mnt/data2'
              }
            ],
            env
          )
          args: [
            '-m'
            'phoenix.server.main'
            '--host'
            '0.0.0.0'
            '--port'
            '6006'
            'serve'
          ]
          resources: {
            cpu: '1.5'
            memory: '3Gi'
          }
          volumeMounts: [
            {
              volumeName: 'phoenix-storage'
              mountPath: '/mnt/data'
            }
          ]
        }
      ]
      scale: {
        maxReplicas: 1
      }
      volumes: [
        {
          name: 'phoenix-storage'
          storageName: storageName
          storageType: 'AzureFile'
        }
        {
          name: 'nginx-conf'
          storageType: 'Secret'
          secrets: [
            {
              secretRef: 'nginx-conf'
              path: 'default.conf'
            }
            {
              secretRef: 'phoenix-auth'
              path: 'htpasswd'
            }
          ]
        }
      ]
    }
  }
}

output imageName string = imageName
output name string = containerApp.name
output SERVICE_APP_URI string = 'https://${containerApp.properties.configuration.ingress.fqdn}'
