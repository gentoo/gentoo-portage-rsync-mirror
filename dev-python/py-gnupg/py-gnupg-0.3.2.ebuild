# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/py-gnupg/py-gnupg-0.3.2.ebuild,v 1.14 2014/08/10 21:15:51 slyfox Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

MY_P="GnuPGInterface-${PV}"

DESCRIPTION="A Python module to interface with GnuPG"
HOMEPAGE="http://py-gnupg.sourceforge.net/"
SRC_URI="mirror://sourceforge/py-gnupg/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ia64 ppc sparc x86 ~amd64-linux ~x86-linux"
IUSE=""

DEPEND=">=app-crypt/gnupg-1.2.1-r1"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

DOCS="NEWS PKG-INFO THANKS"
PYTHON_MODNAME="GnuPGInterface.py"
