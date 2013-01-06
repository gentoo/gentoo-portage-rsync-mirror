# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyalsa/pyalsa-1.0.26.ebuild,v 1.5 2012/12/01 19:52:35 armin76 Exp $

EAPI="2"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils eutils

DESCRIPTION="Python bindings for ALSA library"
HOMEPAGE="http://alsa-project.org/"
SRC_URI="mirror://alsaproject/pyalsa/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND="media-libs/alsa-lib"
DEPEND="${RDEPEND}
	dev-python/setuptools"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

src_prepare() {
	distutils_src_prepare

	epatch "${FILESDIR}/${PN}-1.0.25-no-build-symlinks.patch"
}
