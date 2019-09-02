datacenter = "dc1"
bootstrap_expect = 3
retry_join = ["192.168.50.4", "192.168.50.5", "192.168.50.6"]
#bootstrap = true
data_dir = "/opt/consul"
encrypt = "PdlsUqF70Rn7KnYO/mJnAg=="
leave_on_terminate = true
server = true
ui = true
performance {
  raft_multiplier = 1
}

client_addr = "0.0.0.0"
bind_addr = "192.168.50.5"

####TSL

ca_file = "/etc/consul.d/keys/consul-agent-ca.pem"
cert_file = "/etc/consul.d/keys/dc1-server-consul-1.pem"
key_file = "/etc/consul.d/keys/dc1-server-consul-1-key.pem"
  ports {
    http = -1
    https = 8501
  }
verify_incoming = false
verify_incoming_rpc = true
verify_outgoing = true
verify_server_hostname = true
enable_script_checks = false
disable_remote_exec = true

auto_encrypt {
  allow_tls = false
}


####Gossip
encrypt_verify_incoming = true
encrypt_verify_outgoing = true
