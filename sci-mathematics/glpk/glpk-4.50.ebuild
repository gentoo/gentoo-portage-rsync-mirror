# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/glpk/glpk-4.50.ebuild,v 1.2 2013/06/16 21:03:24 bicatali Exp $

EAPI=5

inherit eutils flag-o-matic toolchain-funcs autotools-utils

DESCRIPTION="GNU Linear Programming Kit"
LICENSE="GPL-3"
HOMEPAGE="http://www.gnu.org/software/glpk/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

SLOT="0/35"
IUSE="doc examples gmp odbc mysql static-libs"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~ppc-aix ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~x64-macos ~x86-macos"

RDEPEND="
	gmp? ( dev-libs/gmp )
	mysql? ( virtual/mysql )
	odbc? ( || ( dev-db/libiodbc dev-db/unixODBC ) )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_configure() {
	local myeconfargs=(
		$(use_enable mysql)
		$(use_enable odbc)
		$(use_with gmp)
	)
	if use mysql || use odbc; then
		myeconfargs+=( --enable-dl )
	else
		myeconfargs+=( --disable-dl )
	fi
	[[ -z $(type -P odbc-config) ]] && \
		append-cppflags $($(tc-getPKG_CONFIG) --cflags libiodbc)

	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
	use doc && dodoc doc/*.pdf doc/notes/*.pdf doc/*.txt
}
