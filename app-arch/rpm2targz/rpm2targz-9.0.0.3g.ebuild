# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/rpm2targz/rpm2targz-9.0.0.3g.ebuild,v 1.10 2012/09/30 11:17:14 ulm Exp $

inherit toolchain-funcs

DESCRIPTION="Convert a .rpm file to a .tar.gz archive"
HOMEPAGE="http://www.slackware.com/config/packages.php"
SRC_URI="mirror://gentoo/${P}.tar.lzma"

LICENSE="BSD-1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~sparc-fbsd ~x86-fbsd"
IUSE="userland_GNU"

# NOTE: rpm2targz autodetects rpm2cpio at runtime, and uses it if available,
#       so we don't explicitly set it as a dependency.
RDEPEND="app-arch/cpio"
DEPEND="app-arch/xz-utils"

src_compile() {
	emake CC="$(tc-getCC)" || die
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc *.README*
}
