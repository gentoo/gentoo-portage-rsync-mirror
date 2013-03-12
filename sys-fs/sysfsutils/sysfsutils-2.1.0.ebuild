# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/sysfsutils/sysfsutils-2.1.0.ebuild,v 1.13 2013/03/12 15:59:38 ssuominen Exp $

EAPI=5
inherit autotools eutils toolchain-funcs

DESCRIPTION="System Utilities Based on Sysfs"
HOMEPAGE="http://linux-diag.sourceforge.net/Sysfsutils.html"
SRC_URI="mirror://sourceforge/linux-diag/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~amd64-linux ~x86-linux"
IUSE="static-libs"

src_prepare() {
	# workaround maintainer mode
	AT_M4DIR=m4 eautoreconf

	# with eautoreconf you get "Useless epunt_cxx usage"
	# without you don't
#	epunt_cxx
}

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS CREDITS ChangeLog NEWS README TODO docs/libsysfs.txt
	gen_usr_ldscript -a sysfs

	# We do not distribute this
	rm -f "${ED}"/usr/bin/dlist_test "${ED}"/usr/lib*/libsysfs.la || die
}
