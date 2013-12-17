# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/q4wine/q4wine-1.1_p2.ebuild,v 1.1 2013/12/17 21:31:52 hwoarang Exp $

EAPI="4"
LANGS="cs de en es fa he it ru uk pl pt af"

inherit cmake-utils

# Upstream names the package PV-rX. We need to fix that to
# PV_pX so we can use portage revisions.
MY_PV="${PV/_p/-r}"
MY_P="${PN}-${MY_PV}"
DESCRIPTION="Qt4 GUI configuration tool for Wine"
HOMEPAGE="http://q4wine.brezblock.org.ua/"
SRC_URI="mirror://sourceforge/${PN}/${PN}/${PN}%20${MY_PV}/${MY_P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug +icoutils +wineappdb -dbus gnome kde"

for x in ${LANGS}; do
	IUSE+=" linguas_${x}"
done

CDEPEND="dev-qt/qtgui:4
	dev-qt/qtsingleapplication
	dev-qt/qtsql:4[sqlite]"

DEPEND="${CDEPEND}
	dev-util/cmake"

RDEPEND="${CDEPEND}
	app-admin/sudo
	app-emulation/wine
	>=sys-apps/which-2.19
	icoutils? ( >=media-gfx/icoutils-0.26.0 )
	sys-fs/fuseiso
	kde? ( kde-base/kdesu )
	gnome? ( x11-libs/gksu )
	dbus? ( dev-qt/qtdbus:4 )"

DOCS="README AUTHORS ChangeLog"

S="${WORKDIR}/${MY_P}"

src_configure() {
	mycmakeargs="${mycmakeargs} \
		-DWITH_SYSTEM_SINGLEAPP=ON \
		$(cmake-utils_use debug DEBUG) \
		$(cmake-utils_use_with icoutils ICOUTILS) \
		$(cmake-utils_use_with wineappdb WINEAPPDB) \
		$(cmake-utils_use_with dbus DBUS)"

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	for x in ${LANGS}; do
		if ! has ${x} ${LINGUAS}; then
			find "${D}" -name "${PN}_${x}*.qm" -exec rm {} \;
		fi
	done
}
