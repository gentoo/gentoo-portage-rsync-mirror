# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libchewing/libchewing-0.4.0-r1.ebuild,v 1.1 2014/12/04 22:08:00 dlan Exp $

EAPI=5

inherit autotools eutils multilib toolchain-funcs

DESCRIPTION="Library for Chinese Phonetic input method"
HOMEPAGE="http://chewing.csie.net/"
SRC_URI="https://github.com/chewing/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="static-libs test system-sqlite"

DEPEND="
	virtual/pkgconfig
	test? (
		sys-libs/ncurses[unicode]
		>=dev-libs/check-0.9.4
	)
	system-sqlite? ( dev-db/sqlite:3 )
"

DOCS=( AUTHORS NEWS README.md TODO )

src_prepare() {
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		$(usex system-sqlite --with-sqlite3 --with-internal-sqlite3) \
		--disable-gcov
}

src_test() {
	# test subdirectory is not enabled by default; this means that we
	# have to make it explicit.
	emake -C test check
}

src_install() {
	default
	prune_libtool_files
}
