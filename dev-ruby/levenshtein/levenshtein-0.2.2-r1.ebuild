# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/levenshtein/levenshtein-0.2.2-r1.ebuild,v 1.2 2013/12/22 18:35:53 blueness Exp $

EAPI=5
USE_RUBY="ruby18 ruby19 ruby20"

RUBY_FAKEGEM_RECIPE_TEST="rspec"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="CHANGELOG README"

inherit multilib ruby-fakegem

DESCRIPTION="Levenshtein distance algorithm."
HOMEPAGE="http://github.com/mbleigh/mash"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~ppc64 ~x86"
IUSE=""

each_ruby_configure() {
	${RUBY} -Cext/levenshtein extconf.rb || die
}

each_ruby_compile() {
	emake -Cext/levenshtein V=1
	cp ext/levenshtein/levenshtein_fast$(get_modname) lib/ || die
}

each_ruby_test() {
	${RUBY} -Ilib test/test.rb || die
}
