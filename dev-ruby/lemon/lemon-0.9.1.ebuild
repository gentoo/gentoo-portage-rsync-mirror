# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/lemon/lemon-0.9.1.ebuild,v 1.2 2014/08/05 16:00:53 mrueg Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21"

RUBY_FAKEGEM_TASK_TEST=""
RUBY_FAKEGEM_RECIPE_DOC="yard"
RUBY_FAKEGEM_EXTRADOC="README.md"

inherit ruby-fakegem

DESCRIPTION="Lemon is a unit testing framework"
HOMEPAGE="https://rubyworks.github.io/lemon/"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_bdepend "test? ( dev-ruby/qed )"
ruby_add_rdepend "
	dev-ruby/ae
	>=dev-ruby/ansi-1.3
	dev-ruby/rubytest"

each_ruby_test() {
	${RUBY} -S qed || die 'tests failed'
}
