# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/haml/haml-3.1.8-r1.ebuild,v 1.2 2013/10/06 15:41:52 graaff Exp $

EAPI=5

USE_RUBY="ruby18 ruby19 ree18"

RUBY_FAKEGEM_TASK_TEST="test"
RUBY_FAKEGEM_TASK_DOC="-Ilib doc"

RUBY_FAKEGEM_EXTRADOC="CONTRIBUTING README.md"
RUBY_FAKEGEM_DOCDIR="doc"

RUBY_FAKEGEM_EXTRAINSTALL="init.rb rails VERSION VERSION_NAME"

inherit ruby-fakegem

DESCRIPTION="HAML - a ruby web page templating engine"
HOMEPAGE="http://haml-lang.com/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"

# TODO: haml has some emacs modes that it could be installing, in case
IUSE=""

RESTRICT="test"

ruby_add_rdepend "dev-ruby/sass"

# It could use merb during testing as well, but it's not mandatory
# ruby_add_bdepend "
# 	test? (
# 		dev-ruby/minitest
# 		dev-ruby/hpricot
# 		dev-ruby/erubis
# 		dev-ruby/rails
# 		dev-ruby/ruby_parser
# 		>=dev-ruby/sass-3.2.0
# 	)"
ruby_add_bdepend "doc? (
		dev-ruby/yard
		dev-ruby/maruku
		dev-ruby/sass
	)"

all_ruby_prepare() {
	# unbundle sass; remove dependency over fssm and add one over sass
	# itself.
	rm -r vendor/ || die

	pushd .. &>/dev/null
	epatch "${FILESDIR}"/${PN}-3.1.6-sass.patch
	sed -i \
		-e '/vendor\//d' \
		metadata || die
	popd &>/dev/null

	# Use newer sass and update specs to make a consistent combination.
	sed -i -e 's/fuchsia/magenta/' test/haml/results/filters.xhtml || die
}
