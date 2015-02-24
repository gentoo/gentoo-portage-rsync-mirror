# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/boxes/boxes-1.1.2.ebuild,v 1.1 2015/02/24 09:11:15 jlec Exp $

EAPI=5

inherit flag-o-matic toolchain-funcs

DESCRIPTION="Draw any kind of boxes around your text"
HOMEPAGE="http://boxes.thomasjensen.com/ https://github.com/ascii-boxes/boxes"
SRC_URI="https://github.com/ascii-boxes/boxes/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="
	sys-devel/bison
	sys-devel/flex
	"

src_prepare() {
	append-cflags -Iregexp -I. -ansi
	append-ldflags -Lregexp
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}"
}

src_install() {
	dobin src/boxes
	doman doc/boxes.1
	dodoc README
	insinto /usr/share/boxes
	doins boxes-config
}
