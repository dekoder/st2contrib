#   (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
#   All rights reserved. This program and the accompanying materials
#   are made available under the terms of the Apache License v2.0 which accompany this distribution.
#
#   The Apache License is available at
#   http://www.apache.org/licenses/LICENSE-2.0
#
####################################################
# Authenticates and creates an OpenStack server.
#
# Inputs:
#   - host - OpenStack machine host
#   - identity_port - optional - port used for OpenStack authentication - Default: 5000
#   - compute_port - optional - port used for OpenStack computations - Default: 8774
#   - img_ref - image reference for server to be created
#   - username - OpenStack username
#   - password - OpenStack password
#   - tenant_name - name of the project on OpenStack
#   - server_name - server name
#   - proxy_host - optional - proxy server used to access the web site - Default: none
#   - proxy_port - optional - proxy server port - Default: none
# Outputs:
#   - return_result - response of the last operation that was executed
#   - error_message - error message of the operation that failed
####################################################

namespace: io.cloudslang.openstack

flow:
  name: create_openstack_server_flow
  inputs:
    - host
    - identity_port:
        default: "'5000'"
    - compute_port:
        default: "'8774'"
    - network_id:
        required: false
    - img_ref
    - username
    - password
    - tenant_name
    - server_name
    - proxy_host:
        required: false
    - proxy_port:
        required: false
  workflow:
    - authentication:
        do:
          get_authentication_flow:
            - host
            - identity_port
            - username
            - password
            - tenant_name
            - proxy_host:
                required: false
            - proxy_port:
                required: false
        publish:
          - token
          - tenant
          - return_result
          - error_message
    - create_server:
        do:
          create_openstack_server:
            - host
            - compute_port
            - token
            - tenant
            - img_ref
            - network_id:
                required: false
            - server_name
            - proxy_host:
                required: false
            - proxy_port:
                required: false
        publish:
          - return_result
          - error_message
  outputs:
    - return_result
    - error_message


