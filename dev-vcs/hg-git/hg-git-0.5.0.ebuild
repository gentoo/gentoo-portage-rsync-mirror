# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/hg-git/hg-git-0.5.0.ebuild,v 1.1 2014/01/06 09:54:27 grobian Exp $

EAPI="5"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit eutils distutils

DESCRIPTION="push and pull from a Git server using Mercurial"
HOMEPAGE="http://hg-git.github.com/ http://pypi.python.org/pypi/hg-git"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND=">=dev-vcs/mercurial-1.9
		>=dev-python/dulwich-0.9.4"
DEPEND="${RDEPEND}
	dev-python/setuptools"

PYTHON_MODNAME="hggit"
