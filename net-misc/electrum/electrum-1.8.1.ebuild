# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/electrum/electrum-1.8.1.ebuild,v 1.1 2013/08/14 06:46:50 blueness Exp $

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
IUSE="gtk qt4"
REQUIRED_USE="|| ( gtk qt4 )"

LANGS="br cs de eo es fr it lv nl ru sl vi zh"

for X in ${LANGS}; do
	IUSE+=" linguas_${X}"
done
unset X

RDEPEND="
	dev-python/setuptools
	dev-python/ecdsa
	dev-python/slowaes
	gtk? ( dev-python/pygtk:2 )
	qt4? ( dev-python/PyQt4 )"

S=${WORKDIR}/${MY_P}

DOCS="RELEASE-NOTES"

src_prepare() {
	# Prevent icon from being installed in the wrong location:
	sed -i '/electrum\.png/ d' setup.py || die
	sed -i "s:^Icon=.*:Icon=${PN}:" "${PN}.desktop" || die

	# Fix .desktop to pass validation
	sed -i 's:bitcoin$:bitcoin;:' electrum.desktop || die

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
		rm gui/gui_gtk.py || die
	fi
	if use !qt4; then
		rm gui/gui_{classic,lite}.py gui/qt_{console,util}.py || die
		sed -i "/config.get('gui','classic')/s/classic/gtk/" electrum \
			|| die
	fi

	distutils-r1_src_prepare
}

src_install() {
	doicon -s 64 icons/${PN}.png
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
