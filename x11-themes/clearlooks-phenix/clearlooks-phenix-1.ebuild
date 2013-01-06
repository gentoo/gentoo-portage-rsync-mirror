# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/clearlooks-phenix/clearlooks-phenix-1.ebuild,v 1.1 2013/01/01 19:40:37 hasufell Exp $

EAPI=5

MY_P=${PN}-v${PV}
DESCRIPTION="Clearlooks-Phenix is a GTK+ 3 port of Clearlooks, the default theme for GNOME 2"
HOMEPAGE="http://www.jpfleury.net/en/software/clearlooks-phenix.php"
SRC_URI="http://dev.gentoo.org/~hasufell/distfiles/${MY_P}.zip"

KEYWORDS="~amd64 ~x86"
LICENSE="GPL-3"
SLOT="3.2"
IUSE=""

SLOT_BLOCK="!x11-themes/clearlooks-phenix:3.4
	!x11-themes/clearlooks-phenix:0"
RDEPEND="${SLOT_BLOCK}
	<x11-libs/gtk+-3.3
	x11-themes/gtk-engines"
DEPEND="app-arch/unzip"

S=${WORKDIR}/${MY_P}

src_install() {
	insinto "/usr/share/themes/Clearlooks-Phenix"
	doins -r *
}
