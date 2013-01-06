# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/autogen/autogen-5.15.ebuild,v 1.7 2012/12/01 18:38:19 armin76 Exp $

EAPI="4"

inherit eutils

DESCRIPTION="Program and text file generation"
HOMEPAGE="http://www.gnu.org/software/autogen/"
SRC_URI="mirror://gnu/${PN}/rel${PV}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x64-macos ~x86-macos"
IUSE=""

RDEPEND=">=dev-scheme/guile-1.8
	dev-libs/libxml2"
DEPEND="${RDEPEND}"

src_install() {
	default
	dodoc NOTES TODO
	rm "${ED}"/usr/share/autogen/libopts-*.tar.gz || die
}
