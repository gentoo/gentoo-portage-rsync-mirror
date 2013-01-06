# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/gauche-gl/gauche-gl-0.5.1.ebuild,v 1.2 2012/07/10 12:28:42 hattya Exp $

EAPI="4"

inherit eutils

MY_P="${P/g/G}"

DESCRIPTION="OpenGL binding for Gauche"
HOMEPAGE="http://practical-scheme.net/gauche/"
SRC_URI="mirror://sourceforge/gauche/${MY_P}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE="cg examples"

RDEPEND=">=dev-scheme/gauche-0.9.2
	virtual/opengl
	media-libs/freeglut
	cg? ( media-gfx/nvidia-cg-toolkit )"
DEPEND="${RDEPEND}"
S="${WORKDIR}/${MY_P}"

src_configure() {
	local myconf
	use cg && myconf="--enable-cg"

	econf ${myconf}
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc ChangeLog README

	if use examples; then
		docompress -x /usr/share/doc/${PF}/examples
		docinto examples
		dodoc examples/*.scm
		# install simple
		dodoc -r examples/simple
		# install glbook
		dodoc -r examples/glbook
		dodoc -r examples/images
		# install slbook
		dodoc -r examples/slbook
		# install cg examples
		if use cg; then
			dodoc -r examples/cg
		fi
	fi
}
