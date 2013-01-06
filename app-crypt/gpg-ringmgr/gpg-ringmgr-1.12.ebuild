# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gpg-ringmgr/gpg-ringmgr-1.12.ebuild,v 1.18 2009/10/14 00:53:35 halcy0n Exp $

DESCRIPTION="GPG Keyring Manager to handle large GPG keyrings more easily"
HOMEPAGE="file:///dev/null"
SRC_URI="mirror://gentoo/${PN}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa amd64"
IUSE=""

DEPEND="dev-lang/perl
	>=app-crypt/gnupg-1.2.1"

src_unpack() {
	mkdir ${P}
	cp "${DISTDIR}"/${PN} "${S}" || die
}

src_compile() {
	pod2man "${S}"/${PN} >"${S}/"${PN}.1
	pod2html "${S}"/${PN} >"${S}"/${PN}.html
}

src_install() {
	dobin ${PN} || die
	doman ${PN}.1
	dohtml ${PN}.html
}
