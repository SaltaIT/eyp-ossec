require 'spec_helper_acceptance'
require_relative './version.rb'

describe 'ossec class' do

  context 'basic setup' do
    # Using puppet_apply as a helper
    it 'should work with no errors' do
      pp = <<-EOF

      class { 'ossec::server': }

    	ossec::server::directories { 'server':
    		directories => [ '/etc', '/var/log' ],
    	}

    	ossec::server::sharedagent::agentconfig { 'generic':
    		os => '',
    	}

    	ossec::server::sharedagent::agentconfig { 'Linux':
    	}

    	ossec::server::sharedagent::directories { 'Linux':
    		directories => [ '/etc', '/var/log' ],
    	}

    	ossec::server::sharedagent::ignore { 'Linux':
    		file => '/etc/mtab',
    	}

    	ossec::server::sharedagent::localfile { 'Linux':
    		logformat => 'syslog',
    		location => '/var/log/messages',
    	}

    	ossec::server::sharedagent::rootcheck { 'Linux':
    	}

      EOF

      # Run it twice and test for idempotency
      expect(apply_manifest(pp).exit_code).to_not eq(1)
      expect(apply_manifest(pp).exit_code).to eq(0)
    end
  end
end
