# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/eflite/eflite-0.4.1.ebuild,v 1.9 2012/05/23 22:57:36 vapier Exp $

EAPI="2"

inherit user

DESCRIPTION="A speech server that allows emacspeak and other screen readers to interact with festival lite."
HOMEPAGE="http://eflite.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE="+16k_voice"

DEPEND=">=app-accessibility/flite-1.2"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i 's:/etc/es.conf:/etc/eflite/es.conf:g' *
}

src_configure() {
	local myconf
	if use 16k_voice; then
		myconf='--with-vox=cmu_us_kal16'
	fi
	econf ${myconf} || die "econf failed."
}

src_install() {
	einstall || die
	dodoc ChangeLog README INSTALL eflite_test.txt

	insinto /etc/eflite
	doins "${FILESDIR}"/es.conf

	newinitd "${FILESDIR}"/eflite.rc eflite
}

pkg_postinst() {
	enewgroup speech
}
