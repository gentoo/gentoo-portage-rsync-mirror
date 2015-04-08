# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/clearlooks-phenix/clearlooks-phenix-3.0.16.ebuild,v 1.1 2013/10/28 22:51:40 hasufell Exp $

EAPI=5

DESCRIPTION="Clearlooks-Phenix is a GTK+ 3 port of Clearlooks, the default theme for GNOME 2"
HOMEPAGE="http://www.jpfleury.net/en/software/clearlooks-phenix.php"
SRC_URI="https://gitorious.org/projets-divers/clearlooks-phenix/archive/${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
LICENSE="GPL-3"
SLOT="3.6"
IUSE=""

RDEPEND=">=x11-libs/gtk+-3.6:3
	x11-themes/gtk-engines"

S=${WORKDIR}/projets-divers-clearlooks-phenix

src_install() {
	insinto "/usr/share/themes/Clearlooks-Phenix-${SLOT}"
	doins -r *
}

pkg_postinst() {
	elog "If you are upgrading from ${PN}-2.0.17 you might have"
	elog "to reselect the theme, because it has been renamed"
	elog "to allow parallel installation!"
}
