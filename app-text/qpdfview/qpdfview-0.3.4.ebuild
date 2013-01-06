# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/qpdfview/qpdfview-0.3.4.ebuild,v 1.3 2012/10/17 03:40:38 phajdan.jr Exp $

EAPI=4
PLOCALES="cs de el pt_BR ru sk uk"
inherit l10n qt4-r2

DESCRIPTION="A tabbed PDF viewer using the poppler library"
HOMEPAGE="http://launchpad.net/qpdfview"
SRC_URI="https://launchpad.net/${PN}/trunk/${PV/_}/+download/${P/_}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm x86"
IUSE="cups dbus svg"

RDEPEND="app-text/poppler[qt4]
	x11-libs/qt-core:4[iconv]
	x11-libs/qt-gui:4
	cups? ( net-print/cups )
	dbus? ( x11-libs/qt-dbus:4 )
	svg? ( x11-libs/qt-svg:4 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS="CONTRIBUTORS README TODO"

S=${WORKDIR}/${P/_}

src_prepare() {
	l10n_for_each_disabled_locale_do rm_loc
}

src_configure() {
	local config i

	for i in cups dbus svg ; do
		if ! use ${i} ; then
			config+=" without_${i}"
		fi
	done

	eqmake4 CONFIG+="${config}"
}

rm_loc() {
	einfo "Removing ${1} localization..."
	sed -e "s;translations/${PN}_${1}.ts;;" \
		-i ${PN}.pro || die "sed translations failed"
	rm translations/${PN}_${1}.{qm,ts} || die "rm translations failed"
}
