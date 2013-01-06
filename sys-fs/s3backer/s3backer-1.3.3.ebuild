# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/s3backer/s3backer-1.3.3.ebuild,v 1.1 2012/08/23 15:48:56 radhermit Exp $

EAPI="4"

inherit autotools

DESCRIPTION="FUSE-based single file backing store via Amazon S3"
HOMEPAGE="http://code.google.com/p/s3backer"
SRC_URI="http://s3backer.googlecode.com/files/s3backer-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-misc/curl
	sys-fs/fuse
	sys-libs/zlib
	dev-libs/expat
	dev-libs/openssl"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i -e "/docdir=/s:packages/\$(PACKAGE):${PF}:" \
		-e "/doc_DATA=/d" \
		Makefile.am || die

	eautoreconf
}

src_compile() {
	emake CFLAGS="${CFLAGS}"
}
