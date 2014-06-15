# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libquvi/libquvi-0.9.4-r1.ebuild,v 1.1 2014/06/15 13:51:02 mgorny Exp $

EAPI=5
AUTOTOOLS_AUTORECONF=1

inherit autotools-utils multilib-minimal

DESCRIPTION="Library for parsing video download links"
HOMEPAGE="http://quvi.sourceforge.net/"
SRC_URI="mirror://sourceforge/quvi/${PV:0:3}/${P}.tar.xz"

LICENSE="AGPL-3"
SLOT="0/8" # subslot = libquvi soname version
KEYWORDS="~amd64 ~arm ~hppa ~x86"
IUSE="examples nls static-libs"

RDEPEND="!<media-libs/quvi-0.4.0
	>=dev-libs/glib-2.24.2:2[${MULTILIB_USEDEP}]
	>=dev-libs/libgcrypt-1.4.5:0=[${MULTILIB_USEDEP}]
	>=media-libs/libquvi-scripts-0.9[${MULTILIB_USEDEP}]
	>=net-libs/libproxy-0.3.1[${MULTILIB_USEDEP}]
	>=net-misc/curl-7.21.0[${MULTILIB_USEDEP}]
	>=dev-lang/lua-5.1[deprecated,${MULTILIB_USEDEP}]
	nls? ( virtual/libintl[${MULTILIB_USEDEP}] )"
DEPEND="${RDEPEND}
	app-arch/xz-utils
	virtual/pkgconfig[${MULTILIB_USEDEP}]
	nls? ( sys-devel/gettext )"

PATCHES=( "${FILESDIR}"/${PN}-0.9.1-headers-reinstall.patch )

multilib_src_configure() {
	local myeconfargs=(
		$(use_enable nls)
		--with-manual
	)
	autotools-utils_src_configure
}

multilib_src_install_all() {
	einstalldocs
	prune_libtool_files

	use examples && dodoc -r examples
}
