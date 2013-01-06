# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/hello/hello-2.6.ebuild,v 1.1 2010/04/12 23:36:47 abcd Exp $

EAPI="3"

DESCRIPTION="GNU \"Hello, world\" application"
HOMEPAGE="http://www.gnu.org/software/hello/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.xz"

LICENSE="FDL-1.3 GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="nls"

src_configure() {
	econf $(use_enable nls)
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS ChangeLog* NEWS README THANKS TODO contrib/evolution.txt || die "dodoc failed"
	for x in contrib man doc po tests src; do
		newdoc $x/ChangeLog ChangeLog.$x || die "newdoc failed"
	done
}
