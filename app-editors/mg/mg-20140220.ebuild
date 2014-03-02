# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/mg/mg-20140220.ebuild,v 1.3 2014/03/02 15:37:43 ulm Exp $

EAPI=5

inherit eutils toolchain-funcs

DESCRIPTION="MicroGnuEmacs, a port from the BSDs"
HOMEPAGE="http://homepage.boetes.org/software/mg/"
SRC_URI="http://homepage.boetes.org/software/mg/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE="livecd"

RDEPEND="dev-libs/libbsd
	sys-libs/ncurses"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	epatch_user

	# remove OpenBSD specific easter egg
	sed -i -e 's/theo\.o//' GNUmakefile || die
	sed -i -e '/theo_init/d' main.c || die

	# fix path to tutorial in man page
	sed -i -e "s:doc/mg/:doc/${PF}/:" mg.1 || die
}

src_compile() {
	local pkgc=$(tc-getPKG_CONFIG)

	emake CC="$(tc-getCC)" \
		CPPFLAGS="-DFKEYS -DREGEX -DXKEYS -D__dead=__dead2 $("${pkgc}" \
			--cflags libbsd-overlay)" \
		CFLAGS="${CFLAGS}" \
		LIBS="$("${pkgc}" --libs ncurses libbsd-overlay)"
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
