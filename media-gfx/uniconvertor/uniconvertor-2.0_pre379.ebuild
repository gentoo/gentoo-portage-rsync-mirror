# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/uniconvertor/uniconvertor-2.0_pre379.ebuild,v 1.3 2014/11/05 13:42:24 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Commandline tool for popular vector formats convertion"
HOMEPAGE="http://sk1project.org/modules.php?name=Products&product=uniconvertor https://code.google.com/p/uniconvertor/"
SRC_URI="http://dev.gentoo.org/~jlec/distfiles/${P}.tar.xz"

KEYWORDS="~amd64 ~arm ~hppa ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux ~x64-macos ~sparc-solaris ~x86-solaris"
SLOT="0"
LICENSE="GPL-2 LGPL-2"
IUSE=""

DEPEND="media-libs/lcms:2
	virtual/python-imaging
	dev-python/pycairo"
RDEPEND="${DEPEND}
	app-text/ghostscript-gpl"
