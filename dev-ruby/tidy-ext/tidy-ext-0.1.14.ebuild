# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/tidy-ext/tidy-ext-0.1.14.ebuild,v 1.12 2014/04/05 16:04:53 mrueg Exp $

EAPI=4
USE_RUBY="ruby19"

RUBY_FAKEGEM_DOCDIR="rdoc"

RUBY_FAKEGEM_RECIPE_TEST="rspec"

inherit ruby-fakegem eutils

DESCRIPTION="W3C HTML Tidy library implemented as a Ruby extension."
HOMEPAGE="http://github.com/carld/tidy"

LICENSE="HTML-Tidy"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86"
IUSE=""

all_ruby_prepare() {
	mkdir lib || die

	# Remove reference to rspec 1
	sed -i -e '/spec/d' spec/spec_helper.rb || die
}

each_ruby_configure() {
	${RUBY} -Cext/tidy extconf.rb || die "Unable to configure extension."
}

each_ruby_compile() {
	emake -Cext/tidy || die
	cp ext/tidy/tidy$(get_modname) lib/ || die "Unable to copy extension."
}
