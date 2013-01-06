# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/sparse/sparse-9999.ebuild,v 1.11 2012/05/24 02:37:51 vapier Exp $

EAPI="2"

inherit eutils multilib toolchain-funcs
if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="git://git.kernel.org/pub/scm/devel/sparse/sparse.git"
	inherit git-2
fi

DESCRIPTION="C semantic parser"
HOMEPAGE="http://sparse.wiki.kernel.org/index.php/Main_Page"

if [[ ${PV} == "9999" ]] ; then
	SRC_URI=""
	#KEYWORDS=""
else
	SRC_URI="mirror://kernel/software/devel/sparse/dist/${P}.tar.bz2"
	KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
fi

LICENSE="OSL-1.1"
SLOT="0"
IUSE="gtk xml"

RDEPEND="gtk? ( x11-libs/gtk+:2 )
	xml? ( dev-libs/libxml2 )"
DEPEND="${RDEPEND}
	gtk? ( virtual/pkgconfig )
	xml? ( virtual/pkgconfig )"

src_prepare() {
	sed -i \
		-e '/^PREFIX=/s:=.*:=/usr:' \
		-e "/^LIBDIR=/s:/lib:/$(get_libdir):" \
		-e '/^CFLAGS =/{s:=:+=:;s:-O2 -finline-functions::}' \
		Makefile || die
	export MAKEOPTS+=" V=1 CC=$(tc-getCC) HAVE_GTK2=$(usex gtk) HAVE_LIBXML=$(usex xml)"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc FAQ README
}
