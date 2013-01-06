# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/clusterssh/clusterssh-9999.ebuild,v 1.3 2011/09/21 08:57:24 mgorny Exp $

EAPI=2

inherit git-2 perl-module

EGIT_REPO_URI="git://clusterssh.git.sourceforge.net/gitroot/clusterssh/clusterssh"

DESCRIPTION="Concurrent Multi-Server Terminal Access."
HOMEPAGE="http://clusterssh.sourceforge.net"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	dev-perl/Exception-Class
	dev-perl/Test-Pod
	dev-perl/Test-Pod-Coverage
	dev-perl/Test-Trap
	dev-perl/Try-Tiny
	dev-perl/perl-tk
	dev-perl/Config-Simple
	dev-perl/X11-Protocol
	x11-apps/xlsfonts"
DEPEND="
	${RDEPEND}
	virtual/perl-Module-Build
	dev-perl/Test-Pod"

SRC_TEST="do parallel"

src_unpack() {
	git-2_src_unpack
	perl-module_src_unpack
}
