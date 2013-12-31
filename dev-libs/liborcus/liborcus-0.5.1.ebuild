# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/liborcus/liborcus-0.5.1.ebuild,v 1.8 2013/12/27 08:57:34 scarabeus Exp $

EAPI=5

EGIT_REPO_URI="git://gitorious.org/orcus/orcus.git"

[[ ${PV} == 9999 ]] && GITECLASS="git-2 autotools"
inherit eutils autotools ${GITECLASS}
unset GITECLASS

DESCRIPTION="Standalone file import filter library for spreadsheet documents"
HOMEPAGE="http://gitorious.org/orcus/pages/Home"
[[ ${PV} == 9999 ]] || SRC_URI="http://kohei.us/files/orcus/src/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0/0.5"
[[ ${PV} == 9999 ]] || \
KEYWORDS="amd64 ~arm ~ppc x86"
IUSE="static-libs"

RDEPEND="
	>=dev-libs/boost-1.51.0:=
	>=dev-libs/libixion-0.5.0:=
	sys-libs/zlib
"
DEPEND="${RDEPEND}
	>=dev-util/mdds-0.8.1:=
"

src_prepare() {
	sed -i \
		-e 's:AM_CONFIG_HEADER:AC_CONFIG_HEADERS:g' \
		configure.ac || die

	epatch \
		"${FILESDIR}"/${P}-linking.patch \
		"${FILESDIR}"/${P}-mdds.patch \
		"${FILESDIR}"/${P}-oldnamespace.patch
	eautoreconf
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
