# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/tinymount/tinymount-0.2.8.ebuild,v 1.1 2015/02/03 05:54:47 yngwin Exp $

EAPI=5
unset _live_inherits
PLOCALES="ru uk"

if [[ ${PV} == *9999* ]]; then
	_live_inherits="git-2"
	EGIT_REPO_URI="git://github.com/limansky/${PN}.git"
else
	SRC_URI="https://github.com/limansky/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

inherit l10n qt4-r2 ${_live_inherits}

DESCRIPTION="Simple disk mount utility"
HOMEPAGE="http://github.com/limansky/tinymount"

LICENSE="GPL-2"
SLOT="0"
IUSE="debug libnotify"

COMMON_DEPEND="dev-qt/qtgui:4
	dev-qt/qtdbus:4
	libnotify? ( x11-libs/libnotify )"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig"
RDEPEND="${COMMON_DEPEND}
	sys-fs/udisks:0"

DOCS=( ChangeLog README.md )

src_prepare() {
	remove_locale() {
		# this is nonfatal sed, so '|| die' unneeded here
		sed -i -e "/TRANSLATIONS/s/translations\/${PN}_${1}.ts//" src/src.pro
	}

	# Check for locales added/removed from previous version
	l10n_find_plocales_changes "src/translations" "${PN}_" '.ts'

	# Prevent disabled locales from being built
	l10n_for_each_disabled_locale_do remove_locale

	# bug #441986
	sed -i src/src.pro -e 's|-Werror||g' || die # bug #441986

	qt4-r2_src_prepare
}

src_configure() {
	local params="PREFIX=/usr"
	use libnotify && params="${params} CONFIG+=with_libnotify"
	eqmake4 ${params}
}
