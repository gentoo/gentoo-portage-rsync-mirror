# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/camping/camping-2.1.532.ebuild,v 1.6 2014/08/05 16:00:46 mrueg Exp $

EAPI=5
USE_RUBY="ruby19 ruby20"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="CHANGELOG README.md"

inherit ruby-fakegem

DESCRIPTION="A small web framework modeled after Ruby on Rails"
HOMEPAGE="http://wiki.github.com/camping/camping"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="test"

ruby_add_bdepend "test? ( dev-ruby/rack-test >=dev-ruby/minitest-4:0 )"

ruby_add_rdepend "
	>=dev-ruby/mab-0.0.3
	>=dev-ruby/rack-1.0"

all_ruby_prepare() {
	sed -i -e '1igem "minitest", "~> 4.0"' test/test_helper.rb || die
}

each_ruby_test() {
	${RUBY} -S testrb test/app_*.rb || die
}
