# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-linux-procfs/python-linux-procfs-9999.ebuild,v 1.2 2013/09/05 18:46:49 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1 git-2

DESCRIPTION="Python classes to extract information from the Linux kernel /proc files"
HOMEPAGE="https://www.kernel.org/pub/scm/libs/python/python-linux-procfs/
	https://kernel.googlesource.com/pub/scm/libs/python/python-linux-procfs/python-linux-procfs/"
EGIT_REPO_URI="https://www.kernel.org/pub/scm/libs/python/${PN}/${PN}.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=""
DEPEND=""
