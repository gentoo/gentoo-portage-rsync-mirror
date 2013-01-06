# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/libsyncml/libsyncml-0.5.4.ebuild,v 1.3 2012/05/03 20:20:59 jdhore Exp $

EAPI="2"

inherit cmake-utils

DESCRIPTION="Implementation of the SyncML protocol"
HOMEPAGE="http://libsyncml.opensync.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"
LICENSE="LGPL-2.1"
IUSE="debug doc http +obex test"

# bluetooth and obex merged because bluetooth support in obex backend is
# automagic, bug #285040
# libsoup:2.2 is forced off to avoid automagic
RDEPEND=">=dev-libs/glib-2.12
	>=dev-libs/libwbxml-0.10
	dev-libs/libxml2
	http? ( net-libs/libsoup:2.4 )
	obex? (
		net-wireless/bluez
		>=dev-libs/openobex-1.1[bluetooth] )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( app-doc/doxygen )
	test? ( >=dev-libs/check-0.9.7 )"

pkg_setup() {
	if ! use obex && ! use http; then
		eerror "${CATEGORY}/${P} without support for obex nor http is unusable."
		eerror "Please enable \"obex\" or/and \"http\" USE flags."
		die "Please enable \"obex\" or/and \"http\" USE flags."
	fi

	DOCS="AUTHORS CODING ChangeLog RELEASE"
}

src_configure() {
	local mycmakeargs="
		-DHAVE_LIBSOUP22=OFF
		-DDOC_INSTALL_DIR=/usr/share/doc/${PF}
		$(cmake-utils_use_enable debug TRACE)
		$(cmake-utils_use_enable http HTTP)
		$(cmake-utils_use_enable obex OBEX)
		$(cmake-utils_use_enable obex BLUETOOTH)
		$(cmake-utils_use_enable test UNIT_TEST)"

	if use http && use obex; then
		# Doc builds with those previous USE flags only
		mycmakeargs="${mycmakeargs} $(cmake-utils_use_build doc DOCUMENTATION)"
	fi

	cmake-utils_src_configure
}
