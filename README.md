 
# Vagrant project that builds 3 consul server with 2 clients.
This is project that builds 3 consul server with 2 clients with:
- Setting up nginx web server and adding it as a consul service
- Forwarding DNS queries to Consul.
- Securing RPC Communication with TLS Encryption.
- Gossip Encryption 


## Pre-requirements

**Install Vagrant:**
Download and install accordingly to your OS as described here:

https://www.vagrantup.com/downloads.html

**Install rbenv:**


On Linux:
> Note:
> On Graphical environments, when you open a shell, sometimes `~/.bash_profile` doesn't get loaded
> You may need to `source ~/.bash_profile` manually or use `~/.bashrc`

```
apt update
apt install autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm5 libgdbm-dev
wget -q https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer -O- | bash
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
source ~/.bash_profile
rbenv init
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
source ~/.bash_profile
```
On MacOS:
```
brew install rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
source ~/.bash_profile
rbenv init
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
source ~/.bash_profile
```

On Windows:
Install accordingly to https://rubyinstaller.org/

## How to run the code


 OS system | Operation
 ------------ | -------------
| Windows | Start menu -> Run and type cmd |
| Linux  |Start terminal |
| macOS | Press Command - spacebar to launch Spotlight and type "Terminal," then double-click the search result. |

## Clone the code locally:

    git clone https://github.com/yaroslav-007/vagrant-consul-dev.git
    cd vagrant-consul-dev
    vagrant up

When done:
 - You should be able to access webpage `https://localhost:8501/ui/`
 - Log in some server/client via `vagrant ssh <consul-server-(1-3)>/<consul-client-(1-2)>`





## Kitchen test
### Pre-requirements
```
rbenv install 2.5.1
rbenv local 2.5.1
rbenv versions
gem install bundler
bundle install
```

  

### Build

```
make
```

### Test
```
bundle exec kitchen converge
bundle exec kitchen verify
bundle exec kitchen destroy
```

##TO DO
 - Add ACL