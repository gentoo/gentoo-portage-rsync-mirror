# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libs3/libs3-2.0.ebuild,v 1.2 2011/10/31 02:41:04 weaver Exp $

EAPI=4

DESCRIPTION="A C Library API for Amazon S3"
HOMEPAGE="http://libs3.ischo.com.s3.amazonaws.com/index.html"
SRC_URI="http://libs3.ischo.com.s3.amazonaws.com/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="net-misc/curl"
DEPEND="${RDEPEND}"

src_prepare() {
	sed -i -e 's/CFLAGS :=/CFLAGS +=/' -e 's/-Werror//' *makefile || die
}

src_install() {
	emake DESTDIR="${D}/usr" install || die
}
