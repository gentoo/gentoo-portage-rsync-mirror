# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/qupzilla/qupzilla-1.8.4.ebuild,v 1.1 2014/11/08 08:54:04 yngwin Exp $

EAPI=5
PLOCALES="ar_SA bg_BG ca_ES cs_CZ de_DE el_GR es_ES es_MX es_VE eu_ES fa_IR fi_FI fr_FR gl_ES he_IL hr_HR hu_HU id_ID it_IT ja_JP ka_GE lg lv_LV nl_NL nqo pl_PL pt_BR pt_PT ro_RO ru_RU sk_SK sr sr@ijekavian sr@ijekavianlatin sr@latin sv_SE tr_TR uk_UA uz@Latn zh_CN zh_TW"
PLUGINS_HASH='bb52c82eeedae50ac33a8d10943998193491230b'
PLUGINS_VERSION='2014.10.02' # if there are no updates, we can use the older archive

inherit eutils l10n multilib qmake-utils vcs-snapshot

DESCRIPTION="Qt WebKit web browser"
HOMEPAGE="http://www.qupzilla.com/"
SRC_URI="https://github.com/QupZilla/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/QupZilla/${PN}-plugins/archive/${PLUGINS_HASH}.tar.gz -> ${PN}-plugins-${PLUGINS_VERSION}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="dbus debug gnome-keyring kde nonblockdialogs +qt4 qt5"
REQUIRED_USE="^^ ( qt4 qt5 )"

RDEPEND="dev-libs/openssl:0
	gnome-keyring? ( gnome-base/gnome-keyring )
	kde? ( kde-base/kwalletd:4 )
	qt4? ( >=dev-qt/qtcore-4.8:4
		>=dev-qt/qtgui-4.8:4
		>=dev-qt/qtscript-4.8:4
		>=dev-qt/qtsql-4.8:4[sqlite]
		>=dev-qt/qtwebkit-4.8:4
		dbus? ( >=dev-qt/qtdbus-4.8:4 ) )
	qt5? ( dev-qt/linguist-tools:5
		dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtconcurrent:5
		dev-qt/qtprintsupport:5
		dev-qt/qtscript:5
		dev-qt/qtsql:5[sqlite]
		dev-qt/qtwebkit:5
		dbus? ( dev-qt/qtdbus:5 ) )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS=( AUTHORS CHANGELOG FAQ README.md )

src_prepare() {
	rm_loc() {
		# remove localizations the user has not specified
		sed -i -e "/${1}.ts/d" translations/translations.pri || die
		rm translations/${1}.ts || die
	}

	# remove outdated prebuilt localizations
	rm -rf bin/locale || die

	# remove empty locale
	rm translations/empty.ts || die

	# get extra plugins into qupzilla build tree
	mv "${WORKDIR}"/${PN}-plugins-${PLUGINS_VERSION}/plugins/* "${S}"/src/plugins/ || die

	l10n_find_plocales_changes "translations" "" ".ts"
	l10n_for_each_disabled_locale_do rm_loc
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

	if use qt4 ; then
		eqmake4 $(use gnome-keyring && echo "DEFINES+=GNOME_INTEGRATION")
	else
		eqmake5 $(use gnome-keyring && echo "DEFINES+=GNOME_INTEGRATION")
	fi
}

src_install() {
	emake INSTALL_ROOT="${D}" install
	einstalldocs
}

pkg_postinst() {
	if has_version www-plugins/adobe-flash; then
		ewarn "For using adobe flash plugin you most likely need to run"
		ewarn "    \"paxctl-ng -m /usr/bin/qupzilla\""
	fi
}
