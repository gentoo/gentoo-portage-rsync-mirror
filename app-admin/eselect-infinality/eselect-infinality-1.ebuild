# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-infinality/eselect-infinality-1.ebuild,v 1.3 2013/01/25 11:06:21 ago Exp $

EAPI=4
inherit vcs-snapshot

DESCRIPTION="Eselect module to choose an infinality font configuration style"
HOMEPAGE="https://github.com/yngwin/eselect-infinality"
SRC_URI="${HOMEPAGE}/tarball/v1 -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="app-admin/eselect"
DEPEND=""

src_install() {
	dodoc README.rst
	insinto "/usr/share/eselect/modules"
	doins infinality.eselect
}

pkg_postinst() {
	elog "Use eselect infinality to select a font configuration style."
	elog "This is supposed to be used in pair with eselect lcdfilter."
}
