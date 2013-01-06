# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/GraphViz/GraphViz-2.100.0.ebuild,v 1.2 2012/10/14 18:27:40 armin76 Exp $

EAPI=4

MODULE_A_EXT=tgz
MODULE_AUTHOR=RSAVAGE
MODULE_VERSION=2.10
inherit perl-module

DESCRIPTION="GraphViz - Interface to the GraphViz graphing tool"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="media-gfx/graphviz
	dev-perl/IPC-Run"
	#dev-perl/XML-Twig #used in GraphViz::XML
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? (
		virtual/perl-Test-Simple
		>=dev-perl/Test-Pod-1.440.0
	)
"

SRC_TEST="do"

src_install() {
	perl-module_src_install

	insinto /usr/share/doc/${PF}/examples
	doins "${S}"/examples/* || die
}
