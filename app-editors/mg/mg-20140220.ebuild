# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/mg/mg-20140220.ebuild,v 1.4 2014/03/03 21:49:00 ulm Exp $

EAPI=5

inherit eutils toolchain-funcs

DESCRIPTION="MicroGnuEmacs, a port from the BSDs"
HOMEPAGE="http://homepage.boetes.org/software/mg/"
SRC_URI="http://homepage.boetes.org/software/mg/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86 ~amd64-fbsd ~x86-fbsd"
IUSE="livecd"

RDEPEND="sys-libs/ncurses
	!elibc_FreeBSD? ( dev-libs/libbsd )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}/${P}-freebsd.patch"
	epatch_user

	# remove OpenBSD specific easter egg
	sed -i -e 's/theo\.o//' GNUmakefile || die
	sed -i -e '/theo_init/d' main.c || die

	# fix path to tutorial in man page
	sed -i -e "s:doc/mg/:doc/${PF}/:" mg.1 || die

	# remove pkg-config call; we pass flags and libs as parameters
	sed -i -e '/pkg-config/d' GNUmakefile || die
}

src_compile() {
	local pc=$(tc-getPKG_CONFIG) extraflags extralibs

	if use elibc_FreeBSD; then
		extralibs="-lutil"
	else
		extraflags=$("${pc}" --cflags libbsd-overlay)
		extralibs=$("${pc}" --libs libbsd-overlay)
	fi

	emake CC="$(tc-getCC)" \
		CPPFLAGS="-DFKEYS -DREGEX -DXKEYS -D__dead=__dead2 ${extraflags}" \
		CFLAGS="${CFLAGS}" \
		LIBS="$("${pc}" --libs ncurses) ${extralibs}"
}

src_install()  {
	einstall
	dodoc README tutorial
	# don't compress the tutorial, otherwise mg cannot open it
	docompress -x /usr/share/doc/${PF}/tutorial
}

pkg_postinst() {
	if use livecd; then
		[[ -e ${EROOT}/usr/bin/emacs ]] || ln -s mg "${EROOT}"/usr/bin/emacs
	fi
}
