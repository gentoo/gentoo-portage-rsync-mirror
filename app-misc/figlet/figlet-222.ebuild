# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/figlet/figlet-222.ebuild,v 1.18 2010/10/20 05:11:54 mr_bones_ Exp $

EAPI=2
inherit eutils bash-completion toolchain-funcs

MY_P=${P/-/}
DESCRIPTION="program for making large letters out of ordinary text"
HOMEPAGE="http://www.figlet.org/"
# Bug 35339 - add more fonts to figlet ebuild
# The fonts are available from the figlet site, but they don't
# have versions so we mirror them ourselves.
SRC_URI="ftp://ftp.figlet.org/pub/figlet/program/unix/${MY_P}.tar.gz
	mirror://gentoo/contributed-${PN}-221.tar.gz
	mirror://gentoo/ms-dos-${PN}-221.tar.gz"

LICENSE="AFL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

S=${WORKDIR}/${MY_P}

src_prepare() {
	cp "${WORKDIR}"/contributed/C64-fonts/*.flf fonts/ || die
	cp "${WORKDIR}"/contributed/bdffonts/*.flf fonts/ || die
	cp "${WORKDIR}"/ms-dos/*.flf fonts/ || die
	cp "${WORKDIR}"/contributed/*.flf fonts/ || die

	epatch \
		"${FILESDIR}"/${P}-gentoo.diff \
		"${FILESDIR}"/${P}-includes.diff
}

src_compile() {
	emake clean
	emake \
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS} ${LDFLAGS}" \
		all || die
}

src_install() {
	dodir /usr/bin /usr/share/man/man6 || die "dodir failed"
	chmod +x figlist showfigfonts
	use prefix || ED="${D}"
	emake \
		DESTDIR="${ED}"/usr/bin \
		MANDIR="${ED}"/usr/share/man/man6 \
		DEFAULTFONTDIR="${ED}"/usr/share/figlet \
		install || die "make install failed"

	dodoc README figfont.txt
	dobashcompletion "${FILESDIR}"/figlet.bashcomp
}
