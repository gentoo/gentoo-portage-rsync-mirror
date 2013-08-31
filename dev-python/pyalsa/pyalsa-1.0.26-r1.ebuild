# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyalsa/pyalsa-1.0.26-r1.ebuild,v 1.1 2013/08/31 16:18:46 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} pypy2_0 )

inherit distutils-r1 flag-o-matic

DESCRIPTION="Python bindings for ALSA library"
HOMEPAGE="http://alsa-project.org/"
SRC_URI="mirror://alsaproject/pyalsa/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="media-libs/alsa-lib"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

python_prepare_all() {
	local PATCHES=(
		"${FILESDIR}/${PN}-1.0.25-no-build-symlinks.patch"
	)

	distutils-r1_python_prepare_all
}

python_configure_all() {
	# note: this needs changing when py3 becomes supported
	append-flags -fno-strict-aliasing
}
