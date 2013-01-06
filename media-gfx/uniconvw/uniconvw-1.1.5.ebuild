# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/uniconvw/uniconvw-1.1.5.ebuild,v 1.5 2010/08/08 17:53:44 jlec Exp $

EAPI="2"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils eutils

DESCRIPTION="Gtk frontend for UniConvertor"
HOMEPAGE="http://sk1project.org/modules.php?name=Products&product=uniconvertor"
SRC_URI="http://uniconvertor.googlecode.com/files/${P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2 LGPL-2"
IUSE=""

RDEPEND="
	>=media-libs/sk1libs-0.9.1
	~media-gfx/uniconvertor-${PV}
	dev-python/pygtk:2"
DEPEND="${RDEPEND}"

src_prepare() {
	sed -i \
		-e "s/'GNU_GPL_v2', 'GNU_LGPL_v2', 'COPYRIGHTS',//" \
		setup.py || die

	distutils_src_prepare
}
