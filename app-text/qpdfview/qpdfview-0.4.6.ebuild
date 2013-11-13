# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/qpdfview/qpdfview-0.4.6.ebuild,v 1.2 2013/11/13 18:54:44 bicatali Exp $

EAPI=5

PLOCALES="ast az bg bs ca cs da de el en_GB eo es eu fi fr gl he hr id it kk ky ms my pl pt pt_BR ro ru sk tr ug uk zh_CN"
inherit l10n multilib qt4-r2

DESCRIPTION="A tabbed document viewer"
HOMEPAGE="http://launchpad.net/qpdfview"
SRC_URI="https://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86 ~amd64-linux ~x86-linux"
IUSE="cups dbus djvu +pdf postscript sqlite +svg synctex"

RDEPEND="dev-qt/qtcore:4[iconv]
	dev-qt/qtgui:4
	cups? ( net-print/cups )
	dbus? ( dev-qt/qtdbus:4 )
	djvu? ( app-text/djvu )
	pdf? ( app-text/poppler[qt4] )
	postscript? ( app-text/libspectre )
	sqlite? ( dev-qt/qtsql:4[sqlite] )
	svg? ( dev-qt/qtsvg:4 )
	!svg? ( virtual/freedesktop-icon-theme )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS=( CHANGES CONTRIBUTORS README TODO )

prepare_locale() {
	lrelease "translations/${PN}_${1}.ts" || die "preparing ${1} locale failed"
}

rm_help() {
	if [[ -e "miscellaneous/help_${1}.html" ]]; then
		rm "miscellaneous/help_${1}.html" || die "removing extraneous help files failed"
	fi
}

src_prepare() {
	l10n_find_plocales_changes "translations" "${PN}_" '.ts'
	l10n_for_each_locale_do prepare_locale
	l10n_for_each_disabled_locale_do rm_help
	# adapt for prefix
	sed -i \
		-e "s:/usr:${EPREFIX}/usr:g" \
		qpdfview.pri || die
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

	eqmake4 CONFIG+="${config}" PLUGIN_INSTALL_PATH="${EPREFIX}/usr/$(get_libdir)/${PN}"
}
