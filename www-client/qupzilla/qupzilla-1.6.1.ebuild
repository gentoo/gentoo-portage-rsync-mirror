# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/qupzilla/qupzilla-1.6.1.ebuild,v 1.1 2014/01/29 20:27:33 pinkbyte Exp $

EAPI=5

PLOCALES="ar_SA bg_BG ca_ES cs_CZ de_DE el_GR es_ES es_VE eu_ES fa_IR fr_FR gl_ES he_IL hu_HU id_ID it_IT ja_JP ka_GE lg nl_NL nqo pl_PL pt_BR pt_PT ro_RO ru_RU sk_SK sr_BA@latin sr_BA sr_RS@latin sr_RS sv_SE uk_UA zh_CN zh_TW"

inherit l10n multilib pax-utils qt4-r2 vcs-snapshot

DESCRIPTION="Qt WebKit web browser"
HOMEPAGE="http://www.qupzilla.com/"
SRC_URI="https://github.com/QupZilla/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/QupZilla/${PN}-plugins/archive/ce262a05e0f5cea171650ed6589a12359358a732.tar.gz -> ${PN}-plugins-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dbus debug gnome-keyring kde nonblockdialogs"

RDEPEND="
	dev-libs/openssl:0
	>=dev-qt/qtcore-4.8:4
	>=dev-qt/qtgui-4.8:4
	>=dev-qt/qtscript-4.8:4
	>=dev-qt/qtsql-4.8:4[sqlite]
	>=dev-qt/qtwebkit-4.8:4
	dbus? ( >=dev-qt/qtdbus-4.8:4 )
	gnome-keyring? ( gnome-base/gnome-keyring )
	kde? ( kde-base/kwalletd:4 )
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
"

DOCS=( AUTHORS CHANGELOG FAQ README.md )
PATCHES=( "${FILESDIR}/${P}-plugins-version-check-fix.patch" )

src_prepare() {
	# remove outdated prebuilt localizations
	rm -rf bin/locale || die

	# remove empty locale
	rm translations/empty.ts || die

	mv "${WORKDIR}"/${PN}-plugins-${PV}/plugins/* "${S}"/src/plugins/ || die
	mv "${WORKDIR}"/${PN}-plugins-${PV}/themes/* "${S}"/bin/themes/ || die

	l10n_find_plocales_changes "translations" "" ".ts"
	qt4-r2_src_prepare
}

src_configure() {
	# see BUILDING document for explanation of options
	export \
		QUPZILLA_PREFIX="${EPREFIX}/usr/" \
		USE_LIBPATH="${EPREFIX}/usr/$(get_libdir)" \
		USE_QTWEBKIT_2_2=true \
		DISABLE_DBUS=$(usex dbus '' 'true') \
		KDE_INTEGRATION=$(usex kde 'true' '') \
		NONBLOCK_JS_DIALOGS=$(usex nonblockdialogs 'true' '')

	eqmake4 $(use gnome-keyring && echo "DEFINES+=GNOME_INTEGRATION")
}

src_install() {
	qt4-r2_src_install
	l10n_for_each_disabled_locale_do rm_loc
	pax-mark m "${ED}"/usr/bin/qupzilla
}

rm_loc() {
	rm -f "${ED}"/usr/share/${PN}/locale/${1}.qm || die
}
