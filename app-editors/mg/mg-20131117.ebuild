# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/mg/mg-20131117.ebuild,v 1.1 2013/11/17 11:44:44 ulm Exp $

EAPI=5

inherit eutils toolchain-funcs

DESCRIPTION="MicroGnuEmacs, a port from the BSDs"
HOMEPAGE="http://homepage.boetes.org/software/mg/"
SRC_URI="http://homepage.boetes.org/software/mg/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE="livecd"

RDEPEND="sys-libs/ncurses"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	dev-libs/clens"

src_prepare() {
	epatch_user

	# remove OpenBSD specific easter egg
	sed -i -e 's/theo\.o//' GNUmakefile || die
	sed -i -e '/theo_init/d' main.c || die

	# fix path to tutorial in man page
	sed -i -e "s:doc/mg/:doc/${PF}/:" mg.1 || die
}

src_compile() {
	emake CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS} -DFKEYS -DREGEX -DXKEYS \
			-I${EPREFIX}/usr/include/clens" \
		LIBS="$("$(tc-getPKG_CONFIG)" --libs ncurses) -lclens"
}

src_install()  {
	einstall
	dodoc README README_PORTING tutorial
	# don't compress the tutorial, otherwise mg cannot open it
	docompress -x /usr/share/doc/${PF}/tutorial
}

pkg_postinst() {
	if use livecd; then
		[[ -e ${EROOT}/usr/bin/emacs ]] || ln -s mg "${EROOT}"/usr/bin/emacs
	fi
}
