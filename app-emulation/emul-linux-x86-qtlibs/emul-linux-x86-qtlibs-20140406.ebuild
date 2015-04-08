# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-qtlibs/emul-linux-x86-qtlibs-20140406.ebuild,v 1.2 2014/05/04 12:23:18 pacho Exp $

EAPI=5
inherit eutils emul-linux-x86

LICENSE="LGPL-2.1 GPL-3"
KEYWORDS="-* amd64"

IUSE="gtkstyle"

DEPEND=""
RDEPEND="~app-emulation/emul-linux-x86-baselibs-${PV}
	~app-emulation/emul-linux-x86-medialibs-${PV}
	~app-emulation/emul-linux-x86-opengl-${PV}
	gtkstyle? ( ~app-emulation/emul-linux-x86-gtklibs-${PV} )"

src_install() {
	emul-linux-x86_src_install

	# Set LDPATH for not needing dev-qt/qtcore
	cat <<-EOF > "${T}/44qt4-emul"
	LDPATH=/usr/lib32/qt4
	EOF
	doenvd "${T}/44qt4-emul"
}
