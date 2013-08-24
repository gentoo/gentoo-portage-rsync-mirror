# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/camping/camping-2.1.532.ebuild,v 1.3 2013/08/24 11:23:57 maekke Exp $

EAPI=4
USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="CHANGELOG README.md"

inherit ruby-fakegem

DESCRIPTION="A small web framework modeled after Ruby on Rails."
HOMEPAGE="http://wiki.github.com/camping/camping"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="test"

ruby_add_bdepend "test? ( dev-ruby/rack-test )"

ruby_add_rdepend "
	>=dev-ruby/mab-0.0.3
	>=dev-ruby/rack-1.0"

each_ruby_test() {
	${RUBY} -S testrb test/app_*.rb || die
}
