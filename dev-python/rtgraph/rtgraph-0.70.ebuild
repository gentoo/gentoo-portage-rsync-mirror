# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/rtgraph/rtgraph-0.70.ebuild,v 1.8 2013/11/06 05:03:45 patrick Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils

DESCRIPTION="Widgets for graphing data in real-time using PyGTK, and UI components for controlling the graphs."
HOMEPAGE="http://navi.cx/svn/misc/trunk/rtgraph/web/index.html"
SRC_URI="http://navi.picogui.org/releases/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
IUSE="examples"

DEPEND="dev-python/pygtk:2"
RDEPEND="${DEPEND}"

DOCS="BUGS README"
PYTHON_MODNAME="rtgraph.py Tweak.py"

src_install() {
	distutils_src_install

	if use examples; then
		insinto /usr/share/doc/${P}/examples
		doins cpu_meter.py graph_ui.py isometric_graph.py line_graph.py polar_graph.py tweak_graph.py || die "Installation of examples failed"
	fi
}
