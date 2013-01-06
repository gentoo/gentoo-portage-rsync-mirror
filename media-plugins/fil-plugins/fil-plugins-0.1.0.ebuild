# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/fil-plugins/fil-plugins-0.1.0.ebuild,v 1.4 2007/11/19 09:53:36 drac Exp $

inherit multilib toolchain-funcs

MY_P=${P/fil/FIL}

DESCRIPTION="FIL-plugins ladspa plugin package. Filters by Fons Adriaensen"
HOMEPAGE="http://www.kokkinizita.net/linuxaudio/"
SRC_URI="http://www.kokkinizita.net/linuxaudio/downloads/${MY_P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

DEPEND="media-libs/ladspa-sdk"

S=${WORKDIR}/${MY_P}

src_compile() {
	tc-export CXX
	sed -i -e "s/-O3//" Makefile
	sed -i -e "s/g++/$(tc-getCXX)/" Makefile
	emake || die
}

src_install() {
	dodoc AUTHORS README
	insinto /usr/$(get_libdir)/ladspa
	insopts -m0755
	doins *.so
}
