# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyvorbis/pyvorbis-1.4-r3.ebuild,v 1.10 2012/02/25 13:34:28 patrick Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython 2.7-pypy-*"

inherit distutils eutils

DESCRIPTION="Python bindings for the ogg.vorbis library"
HOMEPAGE="http://ekyo.nerim.net/software/pyogg/"
SRC_URI="http://ekyo.nerim.net/software/pyogg/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=">=dev-python/pyogg-1.1
	>=media-libs/libogg-1.0
	>=media-libs/libvorbis-1.0"
RDEPEND="${DEPEND}"

DOCS="AUTHORS COPYING ChangeLog NEWS README"

src_prepare() {
	distutils_src_prepare

	epatch "${FILESDIR}/pyvorbisfile.c-1.4.patch"
	epatch "${FILESDIR}/${P}-python25.patch"
}

src_configure() {
	"$(PYTHON -f)" config_unix.py || die "Configuration failed"
}

src_install() {
	distutils_src_install
	insinto /usr/share/doc/${PF}/examples
	doins test/*
}
