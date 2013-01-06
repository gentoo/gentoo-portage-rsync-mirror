# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vamp-libxtract-plugins/vamp-libxtract-plugins-0.4.2.20071019.ebuild,v 1.7 2009/07/24 17:57:14 ssuominen Exp $

EAPI=2
inherit eutils multilib toolchain-funcs

DESCRIPTION="Low-level feature extraction plugins using Jamie Bullock's libxtract library to provide around 50 spectral and other features"
HOMEPAGE="http://www.vamp-plugins.org/"
SRC_URI="mirror://sourceforge/vamp/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ppc64 x86"
IUSE=""

RDEPEND="=sci-libs/fftw-3*
	media-libs/libxtract
	media-libs/vamp-plugin-sdk"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc44.patch
	sed -e "s/-O2 -march=pentium3 -mfpmath=sse/-fPIC -DPIC/" \
		-e "s/ -Wl,-Bstatic//" -i Makefile
}

src_compile() {
	tc-export CXX
	emake || die "emake failed"
}

src_install() {
	insinto /usr/$(get_libdir)/vamp
	doins vamp-libxtract.{so,cat} || die "doins failed"
	dodoc README STATUS
}
