# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/zebedee/zebedee-2.5.3-r1.ebuild,v 1.4 2012/06/28 10:03:38 ago Exp $

EAPI="2"

inherit toolchain-funcs

DESCRIPTION="A simple, free, secure TCP and UDP tunnel program"
HOMEPAGE="http://www.winton.org.uk/zebedee/"
SRC_URI="mirror://sourceforge/zebedee/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ia64 ~mips ~ppc ppc64 s390 ~sparc x86"
IUSE=""

DEPEND="dev-lang/perl
	dev-libs/openssl
	sys-libs/zlib
	app-arch/bzip2"

src_prepare() {
	sed -i Makefile \
		-e '/^CFLAGS/s:=:+=:' \
		-e 's| -o zebedee| $(LDFLAGS)&|' \
		|| die "sed Makefile"
}

src_compile() {
	emake \
		CC=$(tc-getCC) \
		BFINC=-I/usr/include/openssl \
		BFLIB=-lcrypto \
		ZINC=-I/usr/include \
		ZLIB=-lz \
		BZINC=-I/usr/include \
		BZLIB=-lbz2 \
		OS=linux || die
}

src_install() {
	emake \
		ROOTDIR="${D}"/usr \
		MANDIR="${D}"/usr/share/man/man1 \
		ZBDDIR="${D}"/etc/zebedee \
		OS=linux \
		install || die

	rm -f "${D}"/etc/zebedee/*.{txt,html}

	dodoc *.txt
	dohtml *.html

	doinitd "${FILESDIR}"/zebedee
}

pkg_postinst() {
	echo
	einfo "Before you use the Zebedee rc script (/etc/init.d/zebedee), it is"
	einfo "recommended that you edit the server config file: "
	einfo "(/etc/zebedee/server.zbd)."
	einfo "the \"detached\" directive should remain set to false;"
	einfo "the rc script takes care of backgrounding automatically."
	echo
}
