# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libosmo-dsp/libosmo-dsp-0.3.ebuild,v 1.1 2013/06/17 02:35:28 zerochaos Exp $

EAPI=5
inherit autotools multilib

DESCRIPTION="A library with SDR DSP primitives"
HOMEPAGE="http://git.osmocom.org/libosmo-dsp/"

if [[ ${PV} == 9999* ]]; then
	inherit git-2
	EGIT_REPO_URI="git://git.osmocom.org/${PN}"
	KEYWORDS=""
else
	SRC_URI="https://dev.gentoo.org/~zerochaos/distfiles/${P}.tar.xz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0/${PV}"
IUSE="doc static-libs"

RDEPEND="sci-libs/fftw"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
	virtual/pkgconfig"

src_prepare() {
	eautoreconf
}

src_configure() {
	use doc || export ac_cv_path_DOXYGEN=false
	default_src_configure
}

src_install() {
	default_src_install
	use static-libs || rm "${ED}"/usr/$(get_libdir)/libosmodsp.a
}
