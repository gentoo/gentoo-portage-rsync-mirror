# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/rfkill/rfkill-0.4.ebuild,v 1.7 2012/11/25 18:58:13 zerochaos Exp $

inherit toolchain-funcs

DESCRIPTION="Tool to read and control rfkill status through /dev/rfkill"
HOMEPAGE="http://wireless.kernel.org/en/users/Documentation/rfkill"
SRC_URI="http://wireless.kernel.org/download/${PN}/${P}.tar.bz2"

LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64 ~arm ~mips x86"
IUSE=""

RDEPEND=""
DEPEND="sys-devel/make"

CC=$(tc-getCC)
LD=$(tc-getLD)

src_compile() {
	emake V=1 || die "Failed to compile"
}

src_install() {
	emake install V=1 DESTDIR="${D}" || die "Failed to install"
}
