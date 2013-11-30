# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/oauth/oauth-0.4.7.ebuild,v 1.2 2013/11/30 15:58:53 graaff Exp $

EAPI=4
USE_RUBY="ruby18 ree18 ruby19 jruby"

RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_EXTRADOC="HISTORY README.rdoc TODO"

inherit ruby-fakegem

DESCRIPTION="A RubyGem for implementing both OAuth clients and servers."
HOMEPAGE="http://oauth.rubyforge.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-macos"
IUSE=""

ruby_add_bdepend "test? (
		dev-ruby/test-unit:2
		dev-ruby/mocha:0.12
		dev-ruby/webmock )"

all_ruby_prepare() {
	# Require a compatible version of mocha
	sed -i -e '1igem "mocha", "~> 0.12.0"' test/test_helper.rb || die

	# Ensure a consistent test order to avoid loading issues with e.g. rack
	sed -i -e "s/.rb']/.rb'].sort/" Rakefile || die

	# Remove tests that require Rails 2.3 since that is ruby18-only.
	rm test/test_action_controller_request_proxy.rb || die
}

each_ruby_prepare() {
	case ${RUBY} in
		*ruby18)
			# Ignore hash ordering test failures
			sed -i -e '183s:^:#:' -e '224s:^:#:' test/integration/consumer_test.rb || die
			;;
		*rubyee18)
			# Ignore hash ordering test failures
			sed -i -e '183s:^:#:' -e '224s:^:#:' test/integration/consumer_test.rb || die
			;;
		*ruby19)
			# Remove tests depending on rails.
			;;
		*)
			;;
	esac
}
