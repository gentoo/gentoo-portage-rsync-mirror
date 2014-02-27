# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/subsurface/subsurface-4.0.ebuild,v 1.2 2014/02/27 11:55:10 pinkbyte Exp $

EAPI="5"

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="git://subsurface.hohndel.org/subsurface.git"
	GIT_ECLASS="git-2"
	KEYWORDS=""
	SRC_URI=""
	LIBDC_V="0.4.1"
else
	MY_P=${P/s/S}
	SRC_URI="http://subsurface.hohndel.org/downloads/${MY_P}.tgz https://bitbucket.org/bearsh/bearshlay/downloads/${MY_P}.tgz"
	KEYWORDS="~amd64 ~x86"
	LIBDC_V="0.4.1"
fi

PLOCALES="bg_BG da_DK de_CH de_DE es_ES et_EE fi_FI fr_FR he it_IT nb_NO nl_NL
	pl_PL pt_BR pt_PT ru_RU sk_SK sv_SE zh_TW"

inherit eutils l10n qt4-r2 ${GIT_ECLASS}

DESCRIPTION="An open source dive log program"
HOMEPAGE="http://subsurface.hohndel.org"
LICENSE="GPL-2"
SLOT="0"
IUSE="debug doc usb"

RDEPEND="dev-db/sqlite:3
	dev-libs/glib:2
	>=dev-libs/libdivecomputer-${LIBDC_V}[usb?]
	dev-libs/libxml2
	dev-libs/libxslt
	dev-libs/libzip
	dev-qt/qtcore:4
	dev-qt/qtgui:4
	dev-qt/qtsvg:4
	dev-qt/qtwebkit:4
	kde-base/marble
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( app-text/asciidoc )
"

DOCS="README"

src_unpack() {
	if [[ ${PV} = *9999* ]]; then
		git-2_src_unpack
	else
		unpack ${A}
		mv ${MY_P}* ${P} || die "failed to mv the files to ${P}"
	fi
}

rm_trans() {
	rm "${ED}/usr/share/${PN}/translations/${PN}_${1}.qm" || die "rm ${PN}_${1}.qm failed"
}

src_install() {
	qt4-r2_src_install

	l10n_for_each_disabled_locale_do rm_trans

	# this is not a translation but present (no need to die if not present)
	rm "${ED}/usr/share/${PN}/translations/${PN}_source.qm"

	if ! use doc; then
		rm -R "${ED}/usr/share/${PN}/Documentation"* || die "rm doc failed"
	fi
}
