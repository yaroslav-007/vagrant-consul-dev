datacenter = "dc1"
bind_addr = "192.168.50.10"
data_dir = "/opt/consul"
encrypt = "PdlsUqF70Rn7KnYO/mJnAg=="
server = false 
retry_join = ["192.168.50.4", "192.168.50.5", "192.168.50.6"]
enable_script_checks = true
ui = true
####TSL
ca_file = "/etc/consul.d/keys/consul-agent-ca.pem"
cert_file = "/etc/consul.d/keys/dc1-client-consul-0.pem"
key_file = "/etc/consul.d/keys/dc1-client-consul-0-key.pem"

ports = {
    http = -1
    https = 8501
  }


####Gossip
encrypt_verify_incoming = true
encrypt_verify_outgoing = true
verify_incoming = true
verify_incoming_rpc = true
verify_outgoing = true