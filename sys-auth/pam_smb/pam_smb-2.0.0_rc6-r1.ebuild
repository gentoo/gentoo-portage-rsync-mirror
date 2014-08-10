# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/pam_smb/pam_smb-2.0.0_rc6-r1.ebuild,v 1.5 2014/08/10 20:22:47 slyfox Exp $

inherit eutils pam

MY_P=${P/_rc/-rc}

DESCRIPTION="The PAM SMB module, allows authentication against a SMB (such as the Win_x families) server"
HOMEPAGE="http://www.csn.ul.ie/~airlied/pam_smb/"
SRC_URI="mirror://samba/pam_smb/v2/${MY_P}.tar.gz
	http://www.csn.ul.ie/~airlied/pam_smb/v2/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""

DEPEND=">=sys-libs/pam-0.75"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/10-pam_smb-bash-3.1.patch"
}

src_compile() {
	econf --disable-root-only || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	dopammod pamsmbm/pam_smb_auth.so
	exeinto /usr/sbin
	doexe pamsmbd/pamsmbd

	dodoc BUGS CHANGES README TODO faq/{pam_smb_faq.sgml,additions.txt}
	docinto pam.d
	dodoc pam_smb.conf*

	newinitd "${FILESDIR}/pamsmbd-init pamsmbd"
}

pkg_postinst() {
	elog
	elog "You must create /etc/pam_smb.conf yourself, containing"
	elog "your domainname, PDC and BDC.  See example files in docdir."
	elog
}
