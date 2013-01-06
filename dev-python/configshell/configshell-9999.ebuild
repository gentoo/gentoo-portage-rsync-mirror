# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/configshell/configshell-9999.ebuild,v 1.2 2012/10/19 04:56:43 patrick Exp $

EAPI=4

EGIT_REPO_URI="git://linux-iscsi.org/${PN}.git"
PYTHON_DEPEND="2"
RESTRICT_PYTHON_ABIS="3.* 2.7-pypy-* 2.5-jython"
SUPPORT_PYTHON_ABIS="1"

inherit eutils distutils git-2 python

DESCRIPTION="ConfigShell Community Edition for target_core_mod/ConfigFS"
HOMEPAGE="http://linux-iscsi.org/"
SRC_URI=""

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-python/epydoc
	dev-python/simpleparse
	"
RDEPEND="${DEPEND}"
