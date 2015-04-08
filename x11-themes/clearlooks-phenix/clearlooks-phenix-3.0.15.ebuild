# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/clearlooks-phenix/clearlooks-phenix-3.0.15.ebuild,v 1.2 2014/03/19 00:12:57 hasufell Exp $

EAPI=5

DESCRIPTION="Clearlooks-Phenix is a GTK+ 3 port of Clearlooks, the default theme for GNOME 2"
HOMEPAGE="http://www.jpfleury.net/en/software/clearlooks-phenix.php"
SRC_URI="http://jpfleury.indefero.net/p/${PN}/source/download/${PV}/ -> ${P}.zip"

KEYWORDS="amd64 x86"
LICENSE="GPL-3"
SLOT="3.6"
IUSE=""

SLOT_BLOCK="!x11-themes/clearlooks-phenix:3.4
	!x11-themes/clearlooks-phenix:0"
RDEPEND="${SLOT_BLOCK}
	>=x11-libs/gtk+-3.6:3
	x11-themes/gtk-engines"
DEPEND="app-arch/unzip"

src_install() {
	insinto "/usr/share/themes/Clearlooks-Phenix"
	doins -r *
}
