# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/zinnia/zinnia-0.05.ebuild,v 1.1 2010/05/04 02:38:01 matsuu Exp $

DESCRIPTION="Online hand recognition system with machine learning"
HOMEPAGE="http://zinnia.sourceforge.net/"
SRC_URI="mirror://sourceforge/zinnia/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog NEWS README || die
	dohtml doc/*.html doc/*.css || die
}
