# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/mpt-status/mpt-status-1.2.0.ebuild,v 1.7 2014/08/10 20:22:11 slyfox Exp $

inherit eutils

DESCRIPTION="mpt-status is a query tool to access the running configuration and status of LSI SCSI HBAs"
HOMEPAGE="http://www.drugphish.ch/~ratz/mpt-status/"
SRC_URI="http://www.drugphish.ch/~ratz/mpt-status/${P}.tar.bz2
	mirror://gentoo/${PN}-1.2.0-linux-sources.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86 ~ppc"
IUSE=""

src_unpack() {

	unpack ${A}
	epatch "${FILESDIR}/${PN}-1.2.0-gentoo.patch"

	cd "${S}"
	sed -i -e 's,\(^.*linux/compiler\.h.*$\),,' mpt-status.h
	sed -i -e '/KERNEL_PATH/d' Makefile

}

src_install() {

	make DESTDIR="${D}" install || die "make install failed"
	cd "${S}/doc"
	dodoc AUTHORS Changelog DeveloperNotes FAQ README \
		ReleaseNotes THANKS TODO

}
