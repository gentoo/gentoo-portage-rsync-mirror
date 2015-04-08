# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/fuse-python/fuse-python-0.2.1-r1.ebuild,v 1.2 2015/03/27 16:26:16 ago Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} pypy )

inherit distutils-r1

KEYWORDS="amd64 ~x86"
DESCRIPTION="Python FUSE bindings"
HOMEPAGE="http://fuse.sourceforge.net/wiki/index.php/FusePython"

SRC_URI="mirror://sourceforge/fuse/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND=">=sys-fs/fuse-2.0"
DEPEND="${RDEPEND}"
