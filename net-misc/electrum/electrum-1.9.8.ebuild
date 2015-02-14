# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/electrum/electrum-1.9.8.ebuild,v 1.3 2015/02/14 11:57:17 mgorny Exp $

EAPI="5"

PYTHON_COMPAT=( python{2_6,2_7} )

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
		 pl_PL pt_BR pt_PT ro_RO ru_RU sl_SI
		 ta_IN th_TH vi_VN zh_CN"

IUSE="gtk qrcode +qt4 webkit"

for lingua in ${LINGUAS}; do
		IUSE+=" linguas_${lingua}"
done

RDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	>=dev-python/ecdsa-0.9[${PYTHON_USEDEP}]
	dev-python/slowaes[${PYTHON_USEDEP}]
	gtk? ( dev-python/pygtk:2[${PYTHON_USEDEP}] )
	qrcode? ( media-gfx/zbar[python,v4l,${PYTHON_USEDEP}] )
	qt4? (
		 webkit? ( dev-python/PyQt4[webkit] )
		 dev-python/PyQt4[${PYTHON_USEDEP}]
		 )"

S=${WORKDIR}/${MY_P}

DOCS="RELEASE-NOTES"

src_prepare() {
	# Prevent .desktop, icon, and translations from being installed in the wrong locations
	epatch "${FILESDIR}"/setup.py-1.9.7.patch

	epatch "${FILESDIR}"/electrum.desktop-1.9.7.patch
	validate_desktop_entries

	# Remove unrequested localization files:
	for lang in ${LINGUAS}; do
		if use linguas_${lang}; then
			test -f "locale/${lang}/LC_MESSAGES/${PN}.mo" || die
		else
			rm -r "locale/${lang}" || die
		fi
	done

	# Remove unrequested GUI implementations:
	if use !gtk; then
		sed -i "/'electrum_gui.gtk/d" setup.py || die
	fi
	if use !qt4; then
		sed -i "/'electrum_gui.qt/d" setup.py  || die
	fi

	if use !qt4; then
		if use gtk; then
			sed -i "s/config.get('gui','classic')/ config.get('gui','gtk')/" electrum || die
		else
			sed -i "s/config.get('gui','classic')/ config.get('gui','text')/" electrum || die
		fi
	fi

	if use !webkit; then
		sed -i "/'electrum_plugins.coinbase_buyback/d" setup.py || die
	fi

	if use !qrcode; then
		sed -i "/'electrum_plugins.qrscanner/d" setup.py || die
	fi

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
