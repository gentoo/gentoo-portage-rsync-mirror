# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyaudio/pyaudio-0.2.7.ebuild,v 1.1 2012/11/02 12:10:01 radhermit Exp $

EAPI="4"
PYTHON_DEPEND="2:2.6 3:3.2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.5 3.1 *-jython"

inherit distutils

DESCRIPTION="Python bindings for PortAudio"
HOMEPAGE="http://people.csail.mit.edu/hubert/pyaudio/"
SRC_URI="http://people.csail.mit.edu/hubert/pyaudio/packages/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="media-libs/portaudio"
RDEPEND="${DEPEND}"

PYTHON_MODNAME="pyaudio.py"

S=${WORKDIR}/PyAudio-${PV}

src_install() {
	distutils_src_install
	use doc && dohtml -r docs/*
}
