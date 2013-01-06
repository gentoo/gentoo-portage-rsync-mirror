# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/qpdfview/qpdfview-0.3.6.ebuild,v 1.1 2012/12/05 11:28:15 kensington Exp $

EAPI=5
PLOCALES="ast ca cs da de el en_GB es fi fr he hr it my pt_BR ro ru sk tr ug uk zh_CN"
inherit l10n qt4-r2

DESCRIPTION="A tabbed PDF viewer using the poppler library"
HOMEPAGE="http://launchpad.net/qpdfview"
SRC_URI="https://launchpad.net/${PN}/trunk/${PV/_}/+download/${P/_}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="cups dbus svg synctex"

RDEPEND="app-text/poppler[qt4]
	x11-libs/qt-core:4[iconv]
	x11-libs/qt-gui:4
	cups? ( net-print/cups )
	dbus? ( x11-libs/qt-dbus:4 )
	svg? ( x11-libs/qt-svg:4 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS=( CHANGES CONTRIBUTORS README TODO )

S=${WORKDIR}/${P/_}

src_prepare() {
	l10n_for_each_disabled_locale_do rm_loc
}

src_configure() {
	local config i

	for i in cups dbus svg synctex; do
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
