# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/synopsis/synopsis-0.12.ebuild,v 1.3 2011/04/10 21:14:49 arfrever Exp $

EAPI=3
PYTHON_DEPEND="2"

inherit distutils eutils multilib toolchain-funcs

DESCRIPTION="General source code documentation tool"
HOMEPAGE="http://synopsis.fresco.org/index.html"
SRC_URI="http://synopsis.fresco.org/download/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="media-gfx/graphviz
	dev-libs/boehm-gc
	net-misc/omniORB"
RDEPEND="${DEPEND}"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc45.patch
}

src_configure() {
	tc-export CC CXX
	$(PYTHON) setup.py config --libdir=/usr/$(get_libdir) \
		--with-gc-prefix=/usr || die
}
