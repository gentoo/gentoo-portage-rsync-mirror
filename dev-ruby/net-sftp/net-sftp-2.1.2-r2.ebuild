# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/net-sftp/net-sftp-2.1.2-r2.ebuild,v 1.1 2015/03/05 06:22:48 graaff Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21"

RUBY_FAKEGEM_EXTRADOC="CHANGES.txt README.rdoc"

inherit ruby-fakegem

DESCRIPTION="SFTP in pure Ruby"
HOMEPAGE="http://net-ssh.rubyforge.org/"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE=""

ruby_add_rdepend ">=dev-ruby/net-ssh-2.6.5"

ruby_add_bdepend "
	test? (
		>=dev-ruby/mocha-0.13
	)"
