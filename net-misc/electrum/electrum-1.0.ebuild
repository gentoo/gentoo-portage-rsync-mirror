# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/electrum/electrum-1.0.ebuild,v 1.1 2012/09/16 20:45:21 blueness Exp $

EAPI="4"
PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.5 3.*"

inherit eutils distutils gnome2-utils

MY_P=Electrum-${PV}
DESCRIPTION="User friendly Bitcoin client"
HOMEPAGE="http://electrum-desktop.com/"
SRC_URI="http://electrum-desktop.com/files/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk qt4"
REQUIRED_USE="|| ( gtk qt4 )"

LANGS="en cs de fr nl ru sl vi zh"

for X in ${LANGS}; do
	IUSE+=" linguas_${X}"
done
unset X

RDEPEND="dev-python/ecdsa
	dev-python/slowaes
	gtk? ( dev-python/pygtk:2 )
	qt4? ( dev-python/PyQt4 )"

S=${WORKDIR}/${MY_P}

DOCS="RELEASE-NOTES"

src_prepare() {
	# Prevent icon from being installed in the wrong location:
	sed -i '/electrum\.png/ d' setup.py || die
	sed -i "s:^Icon=.*:Icon=${PN}:" "${PN}.desktop" || die

	# Fix language code
	mv locale/cn locale/zh || die  # Chinese

	# Remove unrequested localization files:
	local lang
	for lang in ${LANGS#en}; do
		if use linguas_$lang; then
			test -f "locale/$lang/LC_MESSAGES/${PN}.mo" || die
		else
			rm -r "locale/$lang" || die
		fi
	done

	# Remove unrequested GUI implementations:
	if use !gtk; then
		rm lib/gui.py || die
	fi
	if use !qt4; then
		rm lib/gui_qt.py lib/gui_lite.py || die
		sed -i 's/default="lite"/default="gtk"/' electrum || die
	fi

	distutils_src_prepare
}

src_install() {
	doicon -s 64 ${PN}.png
	distutils_src_install
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
	distutils_pkg_postinst
}

pkg_postrm() {
	gnome2_icon_cache_update
	distutils_pkg_postrm
}
