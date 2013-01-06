# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/shtool/shtool-2.0.4.ebuild,v 1.2 2007/01/22 08:16:33 flameeyes Exp $

DESCRIPTION="A compilation of small but very stable and portable shell scripts into a single shell tool"
HOMEPAGE="http://www.gnu.org/software/shtool/shtool.html"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"
#SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~ppc ~s390 ~sh ~sparc ~x86"
IUSE=""

DEPEND=">=dev-lang/perl-5.6"

src_install () {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README THANKS VERSION NEWS RATIONAL
}
