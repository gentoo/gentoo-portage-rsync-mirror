# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/json_pure/json_pure-1.8.2.ebuild,v 1.2 2015/01/16 05:02:41 mrueg Exp $

EAPI=5

USE_RUBY="ruby19 ruby20 ruby21"
RUBY_FAKEGEM_RECIPE_TEST="rake"
RUBY_FAKEGEM_RECIPE_DOC="rdoc"

inherit multilib ruby-fakegem

DESCRIPTION="A JSON implementation in pure Ruby"
HOMEPAGE="http://flori.github.com/json"

LICENSE="Ruby-BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"

ruby_add_bdepend "test? (
	dev-ruby/sdoc
	dev-ruby/permutation
)"

all_ruby_prepare() {
	sed -i -e 's/`git ls-files`/""/' Rakefile || die
}

each_ruby_configure() {
	${RUBY} -Cext/json/ext/generator extconf.rb || die
	${RUBY} -Cext/json/ext/parser extconf.rb || die
}

each_ruby_compile() {
	emake V=1 -Cext/json/ext/generator
	emake V=1 -Cext/json/ext/parser
	cp ext/json/ext/generator/generator$(get_modname) lib/ || die
	cp ext/json/ext/parser/parser$(get_modname) lib/ || die
}

each_ruby_test() {
	env JSON=pure ${RUBY} -S rake test_pure || die
	env JSON=ext  ${RUBY} -S rake test_ext || die
}
