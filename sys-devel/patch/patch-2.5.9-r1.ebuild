# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/patch/patch-2.5.9-r1.ebuild,v 1.18 2008/03/18 12:34:29 vapier Exp $

inherit flag-o-matic eutils

DESCRIPTION="Utility to apply diffs to files"
HOMEPAGE="http://www.gnu.org/software/patch/patch.html"
#SRC_URI="mirror://gnu/patch/${P}.tar.gz"
#Using own mirrors until gnu has md5sum and all packages up2date
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd" # dont stabilize
IUSE="static"

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	if type -p patch > /dev/null ; then
		epatch "${FILESDIR}"/patch-2.5.9-cr-stripping.patch
	fi
}

src_compile() {
	strip-flags
	append-flags -DLINUX -D_XOPEN_SOURCE=500
	use static && append-ldflags -static

	local myconf=""
	[[ ${USERLAND} != "GNU" ]] && myconf="--program-prefix=g"
	ac_cv_sys_long_file_names=yes econf ${myconf} || die

	emake || die "emake failed"
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog NEWS README
}
