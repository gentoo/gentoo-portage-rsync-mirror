# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/cups-windows/cups-windows-6.0.ebuild,v 1.5 2012/04/23 17:31:54 mgorny Exp $

DESCRIPTION="CUPS PostScript Driver for Windows"
HOMEPAGE="http://www.cups.org/links.php?V4"
SRC_URI="mirror://easysw/cups/windows/${P}-source.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=net-print/cups-1.2"
DEPEND="${RDEPEND}"

src_install() {
	emake install BUILDROOT="${D}" || die
	dodoc README.txt
}
