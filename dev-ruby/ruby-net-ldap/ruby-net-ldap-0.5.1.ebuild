# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-net-ldap/ruby-net-ldap-0.5.1.ebuild,v 1.1 2014/03/23 06:54:31 graaff Exp $

EAPI=5
# jruby: requires ruby 1.9 compatibility
# ruby20: test failures related to encoding
USE_RUBY="ruby19"

RUBY_FAKEGEM_TASK_TEST="test spec"
RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="Contributors.rdoc History.rdoc README.rdoc"

RUBY_FAKEGEM_NAME="net-ldap"

inherit ruby-fakegem

DESCRIPTION="Pure ruby LDAP client implementation."
HOMEPAGE="http://net-ldap.rubyforge.org/"
LICENSE="MIT"

KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="test"

ruby_add_bdepend "test? ( dev-ruby/flexmock
	dev-ruby/metaid
	dev-ruby/test-unit:2
	dev-ruby/rspec:2 )"

all_ruby_prepare() {
	sed -i -e '1igem "test-unit"' test/common.rb || die

	# Avoid an integration spec that hangs due to setting up pipes and
	# intercepting openssl connect calls.
	rm spec/integration/ssl_ber_spec.rb || die
}
