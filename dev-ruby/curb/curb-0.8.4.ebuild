# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/curb/curb-0.8.4.ebuild,v 1.1 2013/07/14 06:55:32 graaff Exp $

EAPI=5
# No longer compatible with ruby 1.8
USE_RUBY="ruby19 ruby20"

RUBY_FAKEGEM_RECIPE_TEST="rake"
RUBY_FAKEGEM_RECIPE_DOC="rdoc"

inherit ruby-fakegem

DESCRIPTION="Ruby-language bindings for libcurl"
HOMEPAGE="http://curb.rubyforge.org/"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND+=" net-misc/curl[ssl]"
RDEPEND+=" net-misc/curl[ssl]"

all_ruby_prepare() {
	# fix tests when localhost is also ::1
	sed -i -e 's|localhost:|127.0.0.1:|g' tests/*.rb || die
}

each_ruby_configure() {
	${RUBY} -Cext extconf.rb || die "extconf.rb failed"
}

each_ruby_compile() {
	emake -Cext CFLAGS="${CFLAGS} -fPIC" archflags="${LDFLAGS}"
	cp -l ext/curb_core$(get_modname) lib || die
}
