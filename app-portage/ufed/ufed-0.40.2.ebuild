# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/ufed/ufed-0.40.2.ebuild,v 1.1 2012/11/02 21:06:34 fuzzyray Exp $

EAPI=2

inherit multilib autotools

DESCRIPTION="Gentoo Linux USE flags editor"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://dev.gentoo.org/~fuzzyray/distfiles/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}
	dev-lang/perl"

src_prepare() {
	# Change the version number to reflect the ebuild version
	sed -i "s:,\[git\],:,\[${PVR}\],:" configure.ac
	eautoreconf
}
src_configure() {
	econf --libexecdir=/usr/$(get_libdir)/ufed
}

src_install() {
	emake DESTDIR="${D}" install || die
}
