# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-net-ldap/ruby-net-ldap-0.3.1-r1.ebuild,v 1.1 2014/03/11 01:35:52 mrueg Exp $

EAPI=5
# jruby: triggers casting errors in java itself.
USE_RUBY="ruby18 ruby19"

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
	dev-ruby/rspec:2 )"
