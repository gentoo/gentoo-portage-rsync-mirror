# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/qupzilla/qupzilla-1.6.0.ebuild,v 1.1 2014/01/20 17:22:32 yngwin Exp $

EAPI=5
PLOCALES="ar_SA bg_BG bo_CN ca_ES cs_CZ da_DK de_DE el_GR es_AR es_ES es_VE
fa_IR fr_FR gl_ES he_IL hu_HU id_ID it_IT ja_JP ka_GE lg my_MM nb_NO nl_NL nqo
pl_PL pt_BR pt_PT ro_RO ru_RU sk_SK sr_BA@latin sr_BA sr_RS@latin sr_RS sv_SE
uk_UA zh_CN zh_TW"
inherit l10n multilib pax-utils qt4-r2 vcs-snapshot

MY_P="QupZilla-${PV}"

DESCRIPTION="Qt WebKit web browser"
HOMEPAGE="http://www.qupzilla.com/"
SRC_URI="http://www.qupzilla.com/uploads/${MY_P}.tar.gz
	https://github.com/QupZilla/qupzilla-plugins/archive/ce262a05e0f5cea171650ed6589a12359358a732.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dbus debug kde nonblockdialogs"

RDEPEND="dev-libs/openssl:0
	>=dev-qt/qtcore-4.7:4
	>=dev-qt/qtgui-4.7:4
	>=dev-qt/qtscript-4.7:4
	>=dev-qt/qtsql-4.7:4
	>=dev-qt/qtwebkit-4.7:4
	dbus? ( >=dev-qt/qtdbus-4.7:4 )
	kde? ( kde-base/kdelibs:4
		kde-base/kwalletd:4 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S=${WORKDIR}/${MY_P}

DOCS="AUTHORS BUILDING CHANGELOG FAQ README.md"

src_prepare() {
	# remove outdated copies of localizations:
	rm -rf bin/locale || die

	cp -r "${WORKDIR}/qupzilla-plugins-*/plugins/*" "${S}"/src/plugins/
	cp -r "${WORKDIR}/qupzilla-plugins-*/themes/*" "${S}"/bin/themes/

	epatch_user
}

src_configure() {
	# see BUILDING document for explanation of options
	export QUPZILLA_PREFIX="${EPREFIX}/usr/"
	export USE_LIBPATH="${QUPZILLA_PREFIX}$(get_libdir)/"
	export DISABLE_DBUS=$(use dbus && echo false || echo true)
	export KDE_INTEGRATION=$(use kde && echo false || echo true)
	export NONBLOCK_JS_DIALOGS=$(use nonblockdialogs && echo true || echo false)
	has_version '>=dev-qt/qtwebkit-4.8.0:4' && export USE_QTWEBKIT_2_2=true

	eqmake4
}

src_install() {
	qt4-r2_src_install
	l10n_for_each_disabled_locale_do rm_loc
	pax-mark m "${ED}"/usr/bin/qupzilla
}

rm_loc() {
	rm "${D}"/usr/share/${PN}/locale/${1}.qm || die
}
