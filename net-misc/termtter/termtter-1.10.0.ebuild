# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/termtter/termtter-1.10.0.ebuild,v 1.1 2011/11/13 08:28:20 naota Exp $

EAPI=4

USE_RUBY="ruby18"
RUBY_FAKEGEM_TASK_TEST=""
RUBY_S="jugyo-termtter-9fc2743"

inherit ruby-fakegem

DESCRIPTION="Termtter is a terminal based Twitter client."
HOMEPAGE="https://github.com/jugyo/termtter"
SRC_URI="https://github.com/jugyo/termtter/tarball/v${PV} -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_rdepend "dev-ruby/highline
	dev-ruby/json
	dev-ruby/notify
	dev-ruby/rubytter
	dev-ruby/termcolor"

each_ruby_install() {
	each_fakegem_install
	ruby_fakegem_doins VERSION
}
