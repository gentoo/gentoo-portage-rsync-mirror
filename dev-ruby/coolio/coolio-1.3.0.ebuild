# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/coolio/coolio-1.3.0.ebuild,v 1.1 2015/04/03 10:52:58 graaff Exp $

EAPI=5

# iobuffer: -rbx
USE_RUBY="ruby19 ruby20 ruby21 ruby22"

RUBY_FAKEGEM_RECIPE_TEST="rspec2"
RUBY_FAKEGEM_EXTRADOC="CHANGES.md README.md"
RUBY_FAKEGEM_NAME="cool.io"

RUBY_FAKEGEM_GEMSPEC="cool.io.gemspec"

inherit multilib ruby-fakegem

DESCRIPTION="A high performance event framework for Ruby which uses the libev C library"
HOMEPAGE="http://coolio.github.com/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND+=" >=dev-libs/libev-4.19"
RDEPEND+=" >=dev-libs/libev-4.19"

RUBY_PATCHES=( "${PN}-1.1.0-libev.patch" "${PN}-1.1.0-rubyio.patch" )

ruby_add_rdepend ">=dev-ruby/iobuffer-1"

all_ruby_prepare() {
	rm -r Gemfile* ext/libev ext/cool.io/libev.c lib/.gitignore || die

	sed -i -e '/[Bb]undler/d' Rakefile || die
	sed -i -e '28i  s.add_dependency "iobuffer"' ${RUBY_FAKEGEM_GEMSPEC} || die
	sed -i -e '/git ls-files/d' ${RUBY_FAKEGEM_GEMSPEC} || die

	# Remove specs that require network connectivity
	rm spec/dns_spec.rb || die
}

each_ruby_configure() {
	${RUBY} -Cext/cool.io extconf.rb || die
}

each_ruby_compile() {
	emake V=1 -Cext/cool.io
	cp ext/cool.io/cool.io_ext$(get_modname) lib/ || die
}
