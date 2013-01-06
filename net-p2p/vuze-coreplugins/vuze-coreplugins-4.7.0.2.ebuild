# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/vuze-coreplugins/vuze-coreplugins-4.7.0.2.ebuild,v 1.1 2012/03/10 05:59:46 dirtyepic Exp $

# eventually this should be built from source...

EAPI=2

inherit eutils

PLUGINS_N=azplugins
RATING_N=azrating
UPDATER_N=azupdater
UPNPAV_N=azupnpav
PLUGINS_V=2.1.6
RATING_V=1.3.1
UPDATER_V=1.8.17
UPNPAV_V=0.3.9
PLUGINS_DIST=${PLUGINS_N}_${PLUGINS_V}.jar
RATING_DIST=${RATING_N}_${RATING_V}.jar
UPDATER_DIST=${UPDATER_N}_${UPDATER_V}.zip
UPNPAV_DIST=${UPNPAV_N}_${UPNPAV_V}.zip

ALLPLUGINS_URL="http://azureus.sourceforge.net/plugins"

DESCRIPTION="Core plugins for Vuze that are included in upstream distribution"
HOMEPAGE="http://www.vuze.com/"
SRC_URI="
	${ALLPLUGINS_URL}/${PLUGINS_DIST}
	${ALLPLUGINS_URL}/${RATING_DIST}
	${ALLPLUGINS_URL}/${UPDATER_DIST}
	${ALLPLUGINS_URL}/${UPNPAV_DIST}"
LICENSE="GPL-2 BSD"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND="~net-p2p/vuze-${PV}"
DEPEND="${RDEPEND}
	app-arch/unzip"

S="${WORKDIR}"

src_unpack() {
	mkdir -p plugins/{${PLUGINS_N},${RATING_N},${UPDATER_N},${UPNPAV_N}} || die
	cp "${DISTDIR}/${PLUGINS_DIST}" plugins/${PLUGINS_N} || die
	cp "${DISTDIR}/${RATING_DIST}" plugins/${RATING_N} || die
	cd "${WORKDIR}/plugins/${UPDATER_N}" && unpack ${UPDATER_DIST} || die
	cd "${WORKDIR}/plugins/${UPNPAV_N}" && unpack ${UPNPAV_DIST} || die
}

src_compile() { :; }

src_install() {
	insinto /usr/share/vuze/
	doins -r "${WORKDIR}/plugins"
}

pkg_postinst() {
	elog "Since version 4.0.0.2, plugins that are normally bundled by upstream"
	elog "(and auto-installed in each user's ~/.azureus if not bundled)"
	elog "are now installed into shared plugin directory by the ebuild."
	elog "Vuze may warn that shared plugin dir is not writable, that's fine."
	elog "Users are recommended to delete the following plugin copies:"
	elog "~/.azureus/plugins/{${PLUGINS_N},${RATING_N},${UPDATER_N},${UPNPAV_N}}"
}
