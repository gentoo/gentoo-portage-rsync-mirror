# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/html-xml-utils/html-xml-utils-5.3.ebuild,v 1.3 2012/07/29 17:17:53 armin76 Exp $

inherit eutils

DESCRIPTION="A number of simple utilities for manipulating HTML and XML files."
SRC_URI="http://www.w3.org/Tools/HTML-XML-utils/${P}.tar.gz"
HOMEPAGE="http://www.w3.org/Tools/HTML-XML-utils/"
LICENSE="W3C"

IUSE=""
KEYWORDS="~amd64 ~ppc ~x86 ~x86-linux ~ppc-macos ~x86-macos"
SLOT="0"

RDEPEND="dev-util/gperf"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_install () {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README TODO
}
