# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pytools/pytools-9999.ebuild,v 1.4 2011/09/21 08:46:39 mgorny Exp $

EAPI="3"

inherit distutils git-2

EGIT_REPO_URI="http://git.tiker.net/trees/pytools.git"

DESCRIPTION="A collection of tools missing from the Python standard library"
HOMEPAGE="http://mathema.tician.de/software/pytools"

SRC_URI=""
LICENSE="MIT"
KEYWORDS=""
SLOT="0"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND=""
