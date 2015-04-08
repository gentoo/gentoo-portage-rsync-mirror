# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/net-scp/net-scp-1.2.1.ebuild,v 1.1 2014/05/03 08:23:10 graaff Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21"

RUBY_FAKEGEM_EXTRADOC="CHANGES.txt README.rdoc"

RUBY_FAKEGEM_TASK_TEST=""

inherit ruby-fakegem

DESCRIPTION="A pure Ruby implementation of the SCP client protocol"
HOMEPAGE="http://net-ssh.rubyforge.org/scp"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""

ruby_add_bdepend "
	doc? ( >=dev-ruby/net-ssh-2.6.5 )
	test? (
		>=dev-ruby/net-ssh-2.9.0
		dev-ruby/mocha
	)"

ruby_add_rdepend ">=dev-ruby/net-ssh-2.6.5"

each_ruby_test() {
	${RUBY} -Ilib:test test/test_all.rb || die
}
