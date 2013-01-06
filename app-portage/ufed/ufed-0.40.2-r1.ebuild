# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/ufed/ufed-0.40.2-r1.ebuild,v 1.6 2012/12/16 19:53:47 armin76 Exp $

EAPI=4

inherit base multilib autotools prefix

DESCRIPTION="Gentoo Linux USE flags editor"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://dev.gentoo.org/~fuzzyray/distfiles/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}
	dev-lang/perl"

# Populate the patches array for patches applied for -rX releases
# It is an array of patch file names of the form:
# "${FILESDIR}"/${P}-make.globals-path.patch
PATCHES=(
	"${FILESDIR}"/${P}-prefix.patch
	"${FILESDIR}"/${P}-manpage-URL.patch
)

src_prepare() {
	base_src_prepare
	# Change the version number to reflect the ebuild version
	sed -i "s:,\[git\],:,\[${PVR}\],:" configure.ac
	eprefixify ufed.8
	eautoreconf
}
src_configure() {
	econf --libexecdir="${EPREFIX}"/usr/$(get_libdir)/ufed
}

src_install() {
	emake DESTDIR="${D}" install || die
}
