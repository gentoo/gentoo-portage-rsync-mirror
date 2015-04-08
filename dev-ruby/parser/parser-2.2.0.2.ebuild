# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/parser/parser-2.2.0.2.ebuild,v 1.1 2015/01/10 22:14:18 mrueg Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21"

RUBY_FAKEGEM_RECIPE_DOC="yard"
RUBY_FAKEGEM_TASK_TEST="test"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG.md README.md"

RUBY_FAKEGEM_VERSION="${PV/_pre/.pre.}"

inherit ruby-fakegem

DESCRIPTION="A production-ready Ruby parser written in pure Ruby"
HOMEPAGE="https://github.com/whitequark/parser"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_bdepend "test? (
	dev-ruby/minitest:5
	dev-ruby/racc
	dev-ruby/cliver )"
ruby_add_rdepend "dev-ruby/ast
	dev-ruby/slop:3"

all_ruby_prepare() {
	sed -i -e "/[Bb]undler/d" Rakefile || die
	sed -i -e "/simplecov/,+35d" test/helper.rb || die
}
