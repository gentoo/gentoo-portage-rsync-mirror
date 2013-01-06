# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/kaya/kaya-0.4.ebuild,v 1.5 2011/10/29 00:55:27 abcd Exp $

EAPI=4
USE_RUBY="ruby18"
CMAKE_IN_SOURCE_BUILD=1

# Could in principle also work with other ruby implementations,
# but kdebindings is ruby18-only atm...

inherit kde4-base ruby-ng

DESCRIPTION="Board game suite for KDE"
HOMEPAGE="http://pcapriotti.github.com/kaya/"
SRC_URI="mirror://github/pcapriotti/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""
ruby_add_rdepend "|| ( kde-base/korundum kde-base/kdebindings-ruby )"
ruby_add_rdepend "dev-ruby/builder"

pkg_setup() {
	ruby-ng_pkg_setup
	kde4-base_pkg_setup
}

src_unpack() {
	kde4-base_src_unpack

	cd "${WORKDIR}"
	mkdir all
	mv ${P} all/ || die "Could not move sources"
}

all_ruby_prepare() {
	kde4-base_src_prepare
}

all_ruby_configure() {
	CMAKE_USE_DIR=${S}
	kde4-base_src_configure
}

all_ruby_compile() {
	CMAKE_USE_DIR=${S}
	kde4-base_src_compile
}

all_ruby_install() {
	CMAKE_USE_DIR=${S}
	kde4-base_src_install
}

pkg_postinst() {
	kde4-base_pkg_postinst
	elog "To be able to use the kaya board game front-end, you need to install at least one"
	elog "of the following game engines: "
	elog "    games-board/gnuchess"
	elog "    games-board/gnushogi"
}
