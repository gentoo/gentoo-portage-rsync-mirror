# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/liborcus/liborcus-9999.ebuild,v 1.14 2015/04/04 23:25:25 dilfridge Exp $

EAPI=5

EGIT_REPO_URI="https://gitlab.com/orcus/orcus.git"

[[ ${PV} == 9999 ]] && GITECLASS="git-r3 autotools"
inherit eutils ${GITECLASS}
unset GITECLASS

DESCRIPTION="Standalone file import filter library for spreadsheet documents"
HOMEPAGE="https://gitlab.com/orcus/orcus/blob/master/README.md"
[[ ${PV} == 9999 ]] || SRC_URI="http://kohei.us/files/orcus/src/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
[[ ${PV} == 9999 ]] || \
KEYWORDS="~amd64 ~arm ~ppc ~x86"
IUSE="static-libs"

RDEPEND="
	>=dev-libs/boost-1.51.0:=
	>=dev-libs/libixion-9999:=
	sys-libs/zlib:=
"
# this will depend on libixion-0.9 at some point...

DEPEND="${RDEPEND}
	>=dev-util/mdds-0.7.1
"

src_prepare() {
	[[ ${PV} == 9999 ]] && eautoreconf
}

src_configure() {
	econf \
		--disable-werror \
		$(use_enable static-libs static)
}

src_install() {
	default

	prune_libtool_files --all
}
