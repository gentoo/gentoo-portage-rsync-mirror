# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/mg/mg-20130922-r1.ebuild,v 1.1 2013/10/13 07:12:46 ulm Exp $

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
	epatch "${FILESDIR}"/${P}-dirname.patch
	epatch_user

	# create our own Makefile to avoid BSD make
	echo -e 'SRCS =' *.c '\n\nmg: $(SRCS:.c=.o)' \
		'\n\t$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS)' >Makefile || die

	# remove OpenBSD specific easter egg
	sed -i -e 's/theo\.c//' Makefile || die
	sed -i -e '/theo_init/d' main.c || die

	# fix path to tutorial in man page
	sed -i -e "s:doc/mg/:doc/${PF}/:" mg.1 || die
}

src_compile() {
	emake CC="$(tc-getCC)" \
		CPPFLAGS="${CPPFLAGS} -DFKEYS -DREGEX -DXKEYS \
			-I${EPREFIX}/usr/include/clens" \
		LDLIBS="-lclens $("$(tc-getPKG_CONFIG)" --libs ncurses)"
}

src_install()  {
	dobin mg
	doman mg.1
	dodoc README README_PORTING tutorial
	# don't compress the tutorial, otherwise mg cannot open it
	docompress -x /usr/share/doc/${PF}/tutorial
}

pkg_postinst() {
	if use livecd; then
		[[ -e ${EROOT}/usr/bin/emacs ]] || ln -s mg "${EROOT}"/usr/bin/emacs
	fi
}
