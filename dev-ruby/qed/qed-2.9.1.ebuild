# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/qed/qed-2.9.1.ebuild,v 1.1 2014/05/15 18:09:24 p8952 Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21"

RUBY_FAKEGEM_TASK_TEST=""
RUBY_FAKEGEM_RECIPE_DOC="yard"
RUBY_FAKEGEM_EXTRADOC="README.md"

inherit ruby-fakegem

DESCRIPTION="QED (Quality Ensured Demonstrations) is a TDD/BDD framework."
HOMEPAGE="https://rubyworks.github.io/qed/"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_bdepend "test? ( dev-ruby/ae )"
ruby_add_rdepend "
	dev-ruby/ansi
	dev-ruby/brass
	>=dev-ruby/facets-2.8"

each_ruby_test() {
	${RUBY} -Ilib bin/qed || die 'tests failed'
}
