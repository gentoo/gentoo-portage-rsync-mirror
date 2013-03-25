# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/qpdfview/qpdfview-0.4.ebuild,v 1.2 2013/03/25 04:19:41 pinkbyte Exp $

EAPI=5

PLOCALES="ast bs ca cs da de el en_GB es eu fi fr he hr id it ky ms my pl pt_BR ro ru sk tr ug uk zh_CN"
inherit l10n multilib qt4-r2

DESCRIPTION="A tabbed PDF viewer using the poppler library"
HOMEPAGE="http://launchpad.net/qpdfview"
SRC_URI="https://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="cups dbus djvu +pdf postscript sqlite +svg synctex"

RDEPEND="app-text/poppler[qt4]
	dev-qt/qtcore:4[iconv]
	dev-qt/qtgui:4
	cups? ( net-print/cups )
	dbus? ( dev-qt/qtdbus:4 )
	djvu? ( app-text/djvu )
	postscript? ( app-text/libspectre )
	sqlite? ( dev-qt/qtsql:4[sqlite] )
	svg? ( dev-qt/qtsvg:4 )
	!svg? ( virtual/freedesktop-icon-theme )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS=( CHANGES CONTRIBUTORS README TODO )

rm_loc() {
	sed -e "/translations\/${PN}_${1}.ts/d" \
		-i ${PN}.pro || die "sed translations failed"
	rm translations/${PN}_${1}.{qm,ts} || die "rm translations failed"
}

src_prepare() {
	l10n_find_plocales_changes "translations" "${PN}_" '.ts'
	l10n_for_each_disabled_locale_do rm_loc

	qt4-r2_src_prepare
}

src_configure() {
	local config i

	for i in cups dbus pdf djvu svg synctex ; do
		if ! use ${i} ; then
			config+=" without_${i}"
		fi
	done

	if ! use sqlite ; then
		config+=" without_sql"
	fi

	if ! use postscript ; then
		config+=" without_ps"
	fi

	eqmake4 CONFIG+="${config}" PLUGIN_INSTALL_PATH="/usr/$(get_libdir)/${PN}"
}
