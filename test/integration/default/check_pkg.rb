#hostname = "`hostname -s`.strip"

####Test OS
describe os.name do
  it { should eq 'ubuntu' }
end

describe os.release do
  it { should eq '18.04' }
end


###Check consul service
describe service('consul') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe user('consul') do
  it { should exist }
  its('group') { should eq 'consul' }
  its('home') { should eq '/etc/consul.d' }
  its('shell') { should eq '/bin/false' }
end


####Checks only on consul-server-1
vmhost = command('uname -n').stdout.strip
if vmhost == "consul-server-1"
  describe http('https://localhost:8501/ui/' ,
  ssl_verify: false) do
    its('status') { should eq 200 }
  end
  describe http('http://localhost:8501/ui/', ssl_verify: false) do
    its('body') { should cmp 'Client sent an HTTP request to an HTTPS server.' }
  end

####Check if all systems are listed in consul members
  describe bash('consul members -ca-file=/etc/consul.d/keys/consul-agent-ca.pem -client-cert=/etc/consul.d/keys/dc1-cli-consul-0.pem -client-key=/etc/consul.d/keys/dc1-cli-consul-0-key.pem -http-addr="https://localhost:8501"') do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not match 'failed' }
    its('stdout') { should match 'consul-server-1' }
    its('stdout') { should match 'consul-server-2' }
    its('stdout') { should match 'consul-server-3' }
    its('stdout') { should match 'consul-client-1' }
    its('stdout') { should match 'consul-client-2' }

  end

###Check some values in consul info  
  describe bash('consul info -ca-file=/etc/consul.d/keys/consul-agent-ca.pem -client-cert=/etc/consul.d/keys/dc1-cli-consul-0.pem -client-key=/etc/consul.d/keys/dc1-cli-consul-0-key.pem -http-addr="https://localhost:8501"') do
        its('exit_status') { should eq 0 }
        its('stdout') { should match 'members = 5' }
        its('stdout') { should match 'members = 3' }
        its('stdout') { should match 'encrypted = true' }
   
      end

###Check if there is two services -consul and web
      describe bash('consul catalog services -ca-file=/etc/consul.d/keys/consul-agent-ca.pem -client-cert=/etc/consul.d/keys/dc1-cli-consul-0.pem -client-key=/etc/consul.d/keys/dc1-cli-consul-0-key.pem -http-addr="https://localhost:8501"') do
            its('exit_status') { should eq 0 }
            its('stdout') { should match 'consul\nweb' }
          end
end

###Check if every server has bind installed
if vmhost.include? "consul-server-"
  describe service('bind9') do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end
  describe bash('dig +short @127.0.0.1 -p 53 web.service.consul') do
    its('exit_status') { should eq 0 }
    its('stdout') { should match '192.168.50.10' }
  end
end

if vmhost == "consul-client-1"
  describe file('/etc/consul.d/web.json') do
    it {should exist}
  end
  describe service('nginx') do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end
end