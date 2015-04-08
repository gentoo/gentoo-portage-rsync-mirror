# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/electrum/electrum-1.9.8-r1.ebuild,v 1.2 2015/03/14 19:53:20 blueness Exp $

EAPI="5"

PYTHON_COMPAT=( python{2_6,2_7} )
PYTHON_REQ_USE="ncurses?"

inherit eutils distutils-r1 gnome2-utils

MY_P=Electrum-${PV}
DESCRIPTION="User friendly Bitcoin client"
HOMEPAGE="http://electrum.org/"
SRC_URI="http://download.electrum.org/download/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
LINGUAS="ar_SA cs_CZ de_DE eo_UY es_ES fr_FR hu_HU
		 id_ID it_IT ja_JP ky_KG lv_LV nl_NL
		 pl_PL pt_BR pt_PT ro_RO ru_RU sk_SK sl_SI
		 ta_IN th_TH vi_VN zh_CN"

IUSE="aliases cli coinbase_com +fiat gtk3 ncurses pos qrcode +qt4 sync vkb"

for lingua in ${LINGUAS}; do
	IUSE+=" linguas_${lingua}"
done

REQUIRED_USE="
	|| ( cli gtk3 ncurses qt4 )
	aliases? ( qt4 )
	coinbase_com? ( qt4 )
	fiat? ( qt4 )
	pos? ( qt4 )
	qrcode? ( qt4 )
	sync? ( qt4 )
	vkb? ( qt4 )
"

RDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	>=dev-python/ecdsa-0.9[${PYTHON_USEDEP}]
	dev-python/slowaes[${PYTHON_USEDEP}]
	gtk3? (
		dev-python/pygobject:3[${PYTHON_USEDEP}]
		x11-libs/gtk+:3[introspection]
	)
	qrcode? ( media-gfx/zbar[python,v4l,${PYTHON_USEDEP}] )
	qt4? (
		coinbase_com? ( dev-python/PyQt4[${PYTHON_USEDEP},webkit] )
		dev-python/PyQt4[${PYTHON_USEDEP}]
	)
	ncurses? ( dev-lang/python )
"

S="${WORKDIR}/${MY_P}"

DOCS="RELEASE-NOTES"

src_prepare() {
	# Prevent .desktop, icon, and translations from being installed in the wrong locations
	epatch "${FILESDIR}"/setup.py-1.9.7.patch

	epatch "${FILESDIR}"/electrum.desktop-1.9.7.patch
	validate_desktop_entries

	# Bugfix
	epatch "${FILESDIR}/${PV}-gtk3-fix.patch"

	# Remove unrequested localization files:
	for lang in ${LINGUAS}; do
		if use linguas_${lang}; then
			test -f "locale/${lang}/LC_MESSAGES/${PN}.mo" || die
		else
			rm -r "locale/${lang}" || die
		fi
	done

	# Remove unrequested GUI implementations:
	local gui
	for gui in  \
		$(usex cli      '' stdio)  \
		$(usex gtk3     '' gtk  )  \
		$(usex qt4      '' qt   )  \
		$(usex ncurses  '' text )  \
	; do
		sed -i "/'electrum_gui\.${gui}/d" setup.py || die
	done

	if ! use qt4; then
		local bestgui=$(usex gtk3 gtk $(usex ncurses text stdio))
		sed -i "s/\(config.get('gui', \?\)'classic'/\1'${bestgui}'/" electrum || die
	fi

	local plugin
	for plugin in  \
		$(usex aliases       '' aliases         )  \
		$(usex coinbase_com  '' coinbase_buyback)  \
		$(usex fiat          '' exchange_rate   )  \
		$(usex sync          '' labels          )  \
		$(usex pos           '' pointofsale     )  \
		$(usex qrcode        '' qrscanner       )  \
		$(usex vkb           '' virtualkeyboard )  \
	; do
		sed -i "/'electrum_plugins\.${plugin}/d" setup.py || die
	done

	distutils-r1_src_prepare
}

src_install() {
	doicon -s 128 icons/${PN}.png
	distutils-r1_src_install
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
