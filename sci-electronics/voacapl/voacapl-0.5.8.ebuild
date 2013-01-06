# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/voacapl/voacapl-0.5.8.ebuild,v 1.5 2012/10/19 10:39:59 jlec Exp $

EAPI="4"

inherit fortran-2

DESCRIPTION="HF propagation prediction tool"
HOMEPAGE="http://www.qsl.net/hz1jw/voacapl/index.html"
SRC_URI="http://www.qsl.net/hz1jw/${PN}/downloads/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

src_install() {
	emake DESTDIR="${D}" docdir=/usr/share/doc/${PF} install
}
