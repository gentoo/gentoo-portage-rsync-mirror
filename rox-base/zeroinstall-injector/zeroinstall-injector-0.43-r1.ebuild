# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-base/zeroinstall-injector/zeroinstall-injector-0.43-r1.ebuild,v 1.7 2010/10/10 17:51:34 armin76 Exp $

EAPI=3
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
PYTHON_DEPEND="2"
PYTHON_USE_WITH="xml"
inherit distutils

DESCRIPTION="Zeroinstall Injector allows regular users to install software themselves"
HOMEPAGE="http://0install.net/"
SRC_URI="mirror://sourceforge/zero-install/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc sparc x86"
IUSE=""

DEPEND="!<=rox-base/rox-session-0.30"
RDEPEND=">=dev-python/pygtk-2.0
	app-crypt/gnupg"

PYTHON_MODNAME="zeroinstall"

src_prepare() {
	# Change manpage install path (Bug 207495)
	sed -i 's:man/man1:share/man/man1:' setup.py
	cp "${FILESDIR}/0distutils-r2" "${WORKDIR}/0distutils"
}

src_compile() {
	distutils_src_compile
}

src_install() {
	distutils_src_install

	fix_0launch_gui() {
		python_convert_shebangs "$(python_get_version)" \
			"${ED}$(python_get_sitedir)/zeroinstall/0launch-gui/0launch-gui"
	}
	python_execute_function -q fix_0launch_gui

	exeinto "/usr/sbin/"
	doexe "${WORKDIR}/0distutils"

	local BASE_XDG_CONFIG="/etc/xdg/0install.net"
	local BASE_XDG_DATA="/usr/share/0install.net"

	insinto "${BASE_XDG_CONFIG}/injector"
	newins "${FILESDIR}/global.cfg" global

	dodir "${BASE_XDG_DATA}/native_feeds"
}
