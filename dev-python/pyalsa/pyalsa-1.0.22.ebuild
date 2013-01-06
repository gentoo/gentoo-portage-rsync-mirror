# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyalsa/pyalsa-1.0.22.ebuild,v 1.12 2012/02/20 14:42:27 patrick Exp $

EAPI="2"
PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.7-pypy-*"

inherit distutils

DESCRIPTION="Python Bindings for Alsa lib"
HOMEPAGE="http://alsa-project.org/"
SRC_URI="mirror://alsaproject/pyalsa/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND="media-libs/alsa-lib"
DEPEND="${RDEPEND}
	dev-python/setuptools"
RESTRICT_PYTHON_ABIS="2.4 3.*"

DISTUTILS_USE_SEPARATE_SOURCE_DIRECTORIES="1"
