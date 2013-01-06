# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/smtptools/smtptools-0.2.3.ebuild,v 1.13 2011/06/06 06:19:25 eras Exp $

inherit eutils

DESCRIPTION="A collection of tools to send or receive mails with SMTP"
HOMEPAGE="http://www.ohse.de/uwe/software/smtptools.html"
SRC_URI="ftp://ftp.ohse.de/uwe/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh x86"
IUSE=""

RDEPEND="!net-mail/qtools"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-cleanups.patch
}

src_compile() {
	# the configure check looks for the symbol name 'dn_expand' in
	# libresolv but later glibc's use the internal symbol name
	# '__dn_expand' and macro 'dn_expand' to '__dn_expand' in the
	# resolv.h header file ... lets force the func to be detected.
	ac_cv_lib_resolv_dn_expand="yes" \
	econf || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die "Installer failed"
	dodoc AUTHORS README README.cvs README.smtpblast \
		README.tomaildir README.usmtpd TODO
}
