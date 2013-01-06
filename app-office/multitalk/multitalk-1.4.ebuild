# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/multitalk/multitalk-1.4.ebuild,v 1.3 2009/12/17 10:56:01 ssuominen Exp $

inherit eutils toolchain-funcs

DESCRIPTION="A new type of presentation program"
HOMEPAGE="http://www.srcf.ucam.org/~dmi1000/multitalk/"
SRC_URI="http://www.srcf.ucam.org/~dmi1000/multitalk/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="examples latex"

DEPEND=">=media-libs/libsdl-1.2.7
	>=media-libs/sdl-image-1.2.3
	>=media-libs/sdl-ttf-2.0.6
	>=media-libs/sdl-gfx-2.0.13"

RDEPEND="${DEPEND}
	latex? ( virtual/latex-base media-gfx/imagemagick )"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}

	cd "${S}"
	sed -i \
		-e "s:g++:$(tc-getCXX) ${CXXFLAGS}:" \
		-e "s:-L\${HOME}/lib:${LDFLAGS}:" \
		Makefile || die "sed for Makefile failed."
}

src_install() {
	dodir /usr/bin
	emake SYSPREFIX="${D}usr" install || die

	insinto /usr/share/${PN}/examples
	doins examples/about.{graph,talk}

	doenvd "${FILESDIR}/99multitalk"

	dodoc README docs/Changelog docs/multitalk.pdf
}

pkg_postinst() {
	elog "You will have to source /etc/profile (or logout and back in)."
	elog "See also /usr/share/doc/${PF}/${PN}.pdf."
}
