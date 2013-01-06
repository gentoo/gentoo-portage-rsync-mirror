# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/diffutils/diffutils-2.9.ebuild,v 1.2 2012/03/27 17:52:39 vapier Exp $

inherit flag-o-matic

DESCRIPTION="Tools to make diffs and compare files"
HOMEPAGE="http://www.gnu.org/software/diffutils/"
SRC_URI="mirror://gnu-alpha/diffutils/${P}.tar.gz
	mirror://gnu/diffutils/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd"
IUSE="nls static"

RDEPEND=""
DEPEND="nls? ( sys-devel/gettext )"

src_compile() {
	use static && append-ldflags -static
	econf \
		--with-packager="Gentoo" \
		--with-packager-version="${PVR}" \
		--with-packager-bug-reports="http://bugs.gentoo.org/" \
		$(use_enable nls) \
		|| die
	emake || die
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
}
