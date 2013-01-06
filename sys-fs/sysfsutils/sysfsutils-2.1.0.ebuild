# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/sysfsutils/sysfsutils-2.1.0.ebuild,v 1.11 2010/11/19 17:45:25 jlec Exp $

EAPI="3"

inherit toolchain-funcs eutils

DESCRIPTION="System Utilities Based on Sysfs"
HOMEPAGE="http://linux-diag.sourceforge.net/Sysfsutils.html"
SRC_URI="mirror://sourceforge/linux-diag/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~amd64-linux ~x86-linux"
IUSE=""

src_unpack() {
	unpack ${A}
	epunt_cxx
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS CREDITS ChangeLog NEWS README TODO docs/libsysfs.txt || die
	gen_usr_ldscript -a sysfs

	# We do not distribute this
	rm -f "${ED}"/usr/bin/dlist_test "${ED}"/usr/lib*/libsysfs.la || die
}
