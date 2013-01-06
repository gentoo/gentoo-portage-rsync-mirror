# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/renattach/renattach-1.2.4.ebuild,v 1.1 2010/09/05 23:47:57 xmw Exp $

EAPI=2

DESCRIPTION="Filter that renames/deletes dangerous email attachments."
HOMEPAGE="http://www.pc-tools.net/unix/renattach/"
SRC_URI="http://www.pc-tools.net/files/unix/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_install () {
	emake DESTDIR="${D}" install || die

	mv "${D}"/etc/renattach.conf.ex "${D}"/etc/renattach.conf || die

	dodoc AUTHORS ChangeLog README NEWS || die
}
