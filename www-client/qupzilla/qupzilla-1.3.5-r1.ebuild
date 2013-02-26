# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/qupzilla/qupzilla-1.3.5-r1.ebuild,v 1.3 2013/02/26 11:01:24 ago Exp $

EAPI=5
PLOCALES="cs_CZ de_DE el_GR es_ES es_VE fa_IR fr_FR hu_HU id_ID it_IT ja_JP
ka_GE nl_NL pl_PL pt_BR pt_PT ro_RO ru_RU sk_SK sr_BA sr_RS sv_SE uk_UA
zh_CN zh_TW"
inherit l10n multilib qt4-r2 vcs-snapshot

MY_P="QupZilla-${PV}"

DESCRIPTION="Qt WebKit web browser"
HOMEPAGE="http://www.qupzilla.com/"
SRC_URI="mirror://github/QupZilla/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="dbus debug kde nonblockdialogs"

DEPEND="
	>=x11-libs/qt-core-4.7:4
	>=x11-libs/qt-gui-4.7:4
	>=x11-libs/qt-script-4.7:4
	>=x11-libs/qt-sql-4.7:4
	>=x11-libs/qt-webkit-4.7:4
	dbus? ( >=x11-libs/qt-dbus-4.7:4 )"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

DOCS="AUTHORS BUILDING CHANGELOG FAQ README.md TODO"

src_prepare() {
	# remove outdated copies of localizations:
	rm -rf bin/locale || die
	epatch "${FILESDIR}"/${P}-libX11-underlinking.patch
	epatch "${FILESDIR}"/${P}-fixes.patch
	epatch_user
}

src_configure() {
	# see BUILDING document for explanation of options
	export QUPZILLA_PREFIX=${EPREFIX}/usr/
	export USE_LIBPATH=${QUPZILLA_PREFIX}$(get_libdir)
	export DISABLE_DBUS=$(use dbus && echo false || echo true)
	export KDE=$(use kde && echo true || echo false) # in future this will enable nepomuk integration
	export NONBLOCK_JS_DIALOGS=$(use nonblockdialogs && echo true || echo false)
	has_version '>=x11-libs/qt-webkit-4.8.0:4' && export USE_QTWEBKIT_2_2=true

	eqmake4
}

src_install() {
	qt4-r2_src_install
	l10n_for_each_disabled_locale_do rm_loc
}

rm_loc() {
	rm "${D}"/usr/share/${PN}/locale/${1}.qm || die
}
