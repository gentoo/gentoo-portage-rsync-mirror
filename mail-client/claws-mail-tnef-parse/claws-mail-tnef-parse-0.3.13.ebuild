# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/claws-mail-tnef-parse/claws-mail-tnef-parse-0.3.13.ebuild,v 1.1 2012/11/20 21:11:02 fauli Exp $

EAPI=4

inherit multilib

MY_P="${P#claws-mail-}"
MY_P="${MY_P/-/_}"

DESCRIPTION="Plugin for Claws to support application/ms-tnef attachments"
HOMEPAGE="http://www.claws-mail.org/"
SRC_URI="http://www.claws-mail.org/downloads/plugins/${MY_P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""
RDEPEND=">=mail-client/claws-mail-3.8.1"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S="${WORKDIR}/${MY_P}"

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README

	# kill useless files
	rm -f "${D}"/usr/$(get_libdir)/claws-mail/plugins/*.{a,la}
}
