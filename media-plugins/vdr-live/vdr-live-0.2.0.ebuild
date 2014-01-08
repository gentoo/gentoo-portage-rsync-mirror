# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-live/vdr-live-0.2.0.ebuild,v 1.7 2014/01/08 13:20:17 hd_brummy Exp $

EAPI=5

inherit vdr-plugin-2

DESCRIPTION="VDR Plugin: Web Access To Settings"
HOMEPAGE="http://live.vdr-developer.org"
SRC_URI="http://live.vdr-developer.org/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="media-video/vdr
	>=dev-libs/tntnet-1.5.3
	>=dev-libs/cxxtools-1.4.3"
RDEPEND="${DEPEND}"

DEPEND="${DEPEND}
	|| ( >=sys-devel/gcc-4.1 >=dev-libs/boost-1.33.0 )"

S="${WORKDIR}/${VDRPLUGIN}-${PV}"

src_prepare() {
	vdr-plugin-2_src_prepare

	sed -e "18s/==/=/" -i  buildutil/version-util
}

src_install() {
	vdr-plugin-2_src_install

	cd "${S}/live"
	insinto /etc/vdr/plugins/live
	doins -r *

	chown vdr:vdr -R "${D}"/etc/vdr/plugins/live
}

pkg_postinst() {
	vdr-plugin-2_pkg_postinst

	elog "Use for login:pass"
	elog "admin:live"
	elog "on first install"
	elog
	elog "To be able to use all functions of vdr-live"
	elog "you should emerge and enable vdr-epgsearch"
	elog
	elog "\temerge vdr-epgsearch"
	elog "\teselect vdr-plugin enable epgsearch"
}
