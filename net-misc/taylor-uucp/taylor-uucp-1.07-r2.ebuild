# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/taylor-uucp/taylor-uucp-1.07-r2.ebuild,v 1.3 2009/03/06 18:48:28 mrness Exp $

inherit eutils flag-o-matic autotools

DESCRIPTION="Taylor UUCP"
HOMEPAGE="http://www.airs.com/ian/uucp.html"
SRC_URI="mirror://gnu/uucp/uucp-${PV}.tar.gz"

IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~arm ia64 ppc sparc x86"

DEPEND=">=sys-apps/sed-4"
RDEPEND=""

S="${WORKDIR}/uucp-1.07"

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}/${P}-gentoo.patch"
	eautoreconf
}

src_compile() {
	append-flags -D_GNU_SOURCE -fno-strict-aliasing
	econf --with-newconfigdir=/etc/uucp || die "configure failed"
	make || die "make failed"
}

src_install() {
	dodir /usr/share/man/man{1,8}
	dodir /usr/share/info
	dodir /etc/uucp
	dodir /usr/bin /usr/sbin
	diropts -o uucp -g uucp -m 0750
	keepdir /var/log/uucp /var/spool/uucp
	diropts -o uucp -g uucp -m 0775
	keepdir /var/spool/uucppublic

	make \
		"prefix=${D}/usr" \
		"sbindir=${D}/usr/sbin" \
		"bindir=${D}/usr/bin" \
		"man1dir=${D}/usr/share/man/man1" \
		"man8dir=${D}/usr/share/man/man8" \
		"newconfigdir=${D}/etc/uucp" \
		"infodir=${D}/usr/share/info" \
		install install-info || die "make install failed"
	sed -i -e 's:/usr/spool:/var/spool:g' sample/config
	cp sample/* "${D}/etc/uucp"
	dodoc ChangeLog NEWS README TODO
}

pkg_preinst() {
	usermod -s /bin/bash uucp
}
