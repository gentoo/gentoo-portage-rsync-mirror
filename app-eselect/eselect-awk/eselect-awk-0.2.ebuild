# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-eselect/eselect-awk/eselect-awk-0.2.ebuild,v 1.1 2015/03/31 16:46:25 ulm Exp $

EAPI=4

DESCRIPTION="Manages the {,/usr}/bin/awk symlink"
HOMEPAGE="http://www.gentoo.org"
SRC_URI="http://dev.gentoo.org/~ottxor/distfiles/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-macos"
IUSE=""

src_install() {
	insinto /usr/share/eselect/modules
	doins awk.eselect
}
