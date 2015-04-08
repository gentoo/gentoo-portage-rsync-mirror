# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/ufed/ufed-0.90_rc2-r1.ebuild,v 1.1 2013/09/11 17:51:19 fuzzyray Exp $

EAPI=5

inherit base eutils multilib autotools

DESCRIPTION="Gentoo Linux USE flags editor"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://dev.gentoo.org/~fuzzyray/distfiles/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE=""

COMMON_DEPEND="sys-libs/ncurses"
RDEPEND="${COMMON_DEPEND}
	dev-lang/perl"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig"

# Populate the patches array for patches applied for -rX releases
# It is an array of patch file names of the form:
# "${FILESDIR}"/${P}-make.globals-path.patch
PATCHES=(
	"${FILESDIR}"/${P}-get_portdir_from_portageq.patch
)

src_prepare() {
	base_src_prepare
	# Change the version number to reflect the ebuild version
	sed -i "s:,\[git\],:,\[${PVR}\],:" configure.ac
	eautoreconf
}

src_configure() {
	econf --libexecdir="${EPREFIX}"/usr/$(get_libdir)/ufed
}
