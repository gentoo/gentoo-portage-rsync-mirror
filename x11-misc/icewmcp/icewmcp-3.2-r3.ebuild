# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/icewmcp/icewmcp-3.2-r3.ebuild,v 1.1 2011/10/01 06:20:23 vapier Exp $

EAPI="2"
PYTHON_DEPEND="2"

inherit python multilib

MY_PN=IceWMControlPanel
DESCRIPTION="A complete control panel for IceWM using gtk & python"
HOMEPAGE="http://icesoundmanager.sourceforge.net/index.php"
SRC_URI="mirror://sourceforge/icesoundmanager/${MY_PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="x11-wm/icewm
	dev-python/pygtk:2
	x11-libs/gtk+:2"
RDEPEND="${DEPEND}"

S=${WORKDIR}/INSTALL-IceWMCP

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm -rf licenses
	mv doc .. || die
}

src_install() {
	local dest="/usr/$(get_libdir)/${P}"
	dodoc ../doc/*.txt || die
	dohtml ../doc/*.html || die
	insinto ${dest}
	doins -r * || die

	local w wraps=(
		"IceWMCP.py IceWMCP"
		"IceWMCPKeyboard.py IceWMCP-Keyboard"
		"IceWMCPMouse.py IceWMCP-Mouse"
		"pyspool.py IceWMCP-PySpool"
		"IceWMCPWallpaper.py IceWMCP-Wallpaper"
		"IceWMCPWinOptions.py IceWMCP-WinOptions"
		"phrozenclock.py PhrozenClock"
		"icesound.py IceSoundManager"
		"IceWMCP_GtkPCCard.py GtkPCCard"
		"IceMe.py iceme"
		"icepref.py icepref"
		"icepref_td.py icepref_td"
		"IceWMCPGtkIconSelection.py IceWMCP-Icons"
		"IceWMCPEnergyStar.py IceWMCP-EnergyStar"
	)
	for w in "${wraps[@]}" ; do
		set -- ${w}
		printf '#!/bin/sh\nexec python %s/%s\n' "${dest}" "$1" > "${T}"/$2
		dobin "${T}"/$2 || die
	done
}

pkg_postinst() {
	einfo "Some of the icons displayed by IceWMCP may be pointing to"
	einfo "programs which are not on your system!  You can hide them"
	einfo "using the Configuration window (Ctrl+C)."
}
