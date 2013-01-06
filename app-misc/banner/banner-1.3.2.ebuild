# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/banner/banner-1.3.2.ebuild,v 1.11 2010/10/19 05:58:01 leio Exp $

DESCRIPTION="The well known banner program for Linux"
HOMEPAGE="http://cedar-solutions.com"
SRC_URI="http://cedar-solutions.com/ftp/software/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux"
IUSE=""

DEPEND="!games-misc/bsd-games"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog README
}
