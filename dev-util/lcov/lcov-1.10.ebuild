# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/lcov/lcov-1.10.ebuild,v 1.1 2013/02/04 08:48:33 patrick Exp $

EAPI="4"

inherit eutils

DESCRIPTION="A graphical front-end for GCC's coverage testing tool gcov"
HOMEPAGE="http://ltp.sourceforge.net/coverage/lcov.php"
SRC_URI="mirror://sourceforge/ltp/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86 ~x86-linux ~x64-macos"
IUSE=""

DEPEND=""
RDEPEND=">=dev-lang/perl-5
	dev-perl/GD[png]"

src_compile() { :; }

src_install() {
	emake PREFIX="${ED}" install
}
