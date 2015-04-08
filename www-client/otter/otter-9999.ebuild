# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/otter/otter-9999.ebuild,v 1.6 2015/02/04 12:37:20 jer Exp $

EAPI=5
WANT_CMAKE="always"
inherit eutils cmake-utils git-r3

DESCRIPTION="Project aiming to recreate classic Opera (12.x) UI using Qt5"
HOMEPAGE="http://otter-browser.org/"
EGIT_REPO_URI="https://github.com/Emdek/otter"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

DEPEND="
	dev-qt/qtconcurrent:5
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtmultimedia:5
	dev-qt/qtnetwork:5
	dev-qt/qtprintsupport:5
	dev-qt/qtscript:5
	dev-qt/qtsql:5
	dev-qt/qtwebkit:5
	dev-qt/qtwidgets:5
"
RDEPEND="
	${DEPEND}
"
DOCS=( CHANGELOG CONTRIBUTING.md TODO )

src_prepare() {
	if [[ -n ${LINGUAS} ]]; then
		local lingua
		for lingua in resources/translations/*.qm; do
			lingua=$(basename ${lingua})
			lingua=${lingua/otter-browser_/}
			lingua=${lingua/.qm/}
			if ! has ${lingua} ${LINGUAS}; then
				rm resources/translations/otter-browser_${lingua}.qm || die
			fi
		done
	fi
}

src_install() {
	cmake-utils_src_install
	domenu ${PN}-browser.desktop
}
