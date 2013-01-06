# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/pixz/pixz-1.0.ebuild,v 1.2 2012/12/06 03:09:11 vapier Exp $

EAPI=4

inherit toolchain-funcs flag-o-matic

DESCRIPTION="Parallel Indexed XZ compressor"
HOMEPAGE="https://github.com/vasi/pixz"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/vasi/pixz.git"
	inherit git-2
	KEYWORDS=""
else
	SRC_URI="mirror://github/vasi/${PN}/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="BSD-2"
SLOT="0"
IUSE="static"

LIB_DEPEND=">=app-arch/libarchive-2.8[static-libs(+)]
	>=app-arch/xz-utils-5[static-libs(+)]"
RDEPEND="!static? ( ${LIB_DEPEND//\[static-libs(+)]} )"
DEPEND="${RDEPEND}
	static? ( ${LIB_DEPEND} )"

src_configure() {
	use static && append-ldflags -static
}

src_compile() {
	emake CC="$(tc-getCC)" OPT=""
}

src_install() {
	dobin pixz
	dodoc README TODO
}
