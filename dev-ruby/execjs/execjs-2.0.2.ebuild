# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/execjs/execjs-2.0.2.ebuild,v 1.2 2013/10/26 07:25:12 graaff Exp $

EAPI=5
USE_RUBY="ruby18 ruby19 ruby20"

RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_EXTRADOC="README.md"

RUBY_FAKEGEM_GEMSPEC="${PN}.gemspec"
inherit ruby-fakegem

DESCRIPTION="ExecJS lets you run JavaScript code from Ruby"
HOMEPAGE="https://github.com/sstephenson/execjs"
SRC_URI="https://github.com/sstephenson/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86 ~x64-macos"

IUSE="test"

ruby_add_rdepend ">=dev-ruby/multi_json-1.0"

# execjs supports various javascript runtimes. They are listed in order
# as per the documentation. For now only include the ones already in the
# tree.

# therubyracer, therubyrhino, node.js, spidermonkey (deprecated)

# spidermonkey doesn't pass the test suite:
# https://github.com/sstephenson/execjs/issues/62

RDEPEND+=" || ( net-libs/nodejs )"

all_ruby_prepare() {
	# Avoid test requiring network connectivity. We could potentially
	# substitute dev-ruby/coffee-script-source for this.
	sed -i -e '/test_coffeescript/,/end/ s:^:#:' test/test_execjs.rb || die
}
