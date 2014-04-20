# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/qupzilla/qupzilla-1.6.5.ebuild,v 1.1 2014/04/20 09:47:40 yngwin Exp $

EAPI=5
PLOCALES="ar_SA bg_BG ca_ES cs_CZ de_DE el_GR es_ES es_VE eu_ES fa_IR fr_FR gl_ES he_IL hu_HU id_ID it_IT ja_JP ka_GE lg nl_NL nqo pl_PL pt_BR pt_PT ro_RO ru_RU sk_SK sr_BA@latin sr_BA sr_RS@latin sr_RS sv_SE uk_UA zh_CN zh_TW"
PLUGINS_HASH='b19f6e0b83baca40e96019ccda329b88459e6a7f'
PLUGINS_VERSION='1.6.3' # if there are no updates, we can use the older archive

inherit l10n multilib qt4-r2 vcs-snapshot

DESCRIPTION="Qt WebKit web browser"
HOMEPAGE="http://www.qupzilla.com/"
SRC_URI="https://github.com/QupZilla/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/QupZilla/${PN}-plugins/archive/${PLUGINS_HASH}.tar.gz -> ${PN}-plugins-${PLUGINS_VERSION}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="dbus debug gnome-keyring kde nonblockdialogs"

RDEPEND="dev-libs/openssl:0
	>=dev-qt/qtcore-4.8:4
	>=dev-qt/qtgui-4.8:4
	>=dev-qt/qtscript-4.8:4
	>=dev-qt/qtsql-4.8:4[sqlite]
	>=dev-qt/qtwebkit-4.8:4
	dbus? ( >=dev-qt/qtdbus-4.8:4 )
	gnome-keyring? ( gnome-base/gnome-keyring )
	kde? ( kde-base/kwalletd:4 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS=( AUTHORS CHANGELOG FAQ README.md )
PATCHES=( "${FILESDIR}/${P}-plugins-version-check-fix.patch" )

src_prepare() {
	# remove outdated prebuilt localizations
	rm -rf bin/locale || die

	# remove empty locale
	rm translations/empty.ts || die

	mv "${WORKDIR}"/${PN}-plugins-${PLUGINS_VERSION}/plugins/* "${S}"/src/plugins/ || die
	mv "${WORKDIR}"/${PN}-plugins-${PLUGINS_VERSION}/themes/* "${S}"/bin/themes/ || die

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
}

rm_loc() {
	rm -f "${ED}"/usr/share/${PN}/locale/${1}.qm || die
}

pkg_postinst(){
	if has_version www-plugins/adobe-flash; then
		ewarn "For using adobe flash plugin you most likely need to run \"paxctl-ng -m /usr/bin/qupzilla\""
	fi
}
